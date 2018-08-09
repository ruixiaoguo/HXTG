//
//  XWAlterview.m
//  new
//
//  Created by chinat2t on 14-11-6.
//  Copyright (c) 2014年 chinat2t. All rights reserved.
//

#import "HXAlterview.h"
#import "UILabel+ContentSize.h"
#import "NSString+TxtHeight.h"

/*! 设置警告框的长和宽 */
#define Alertwidth Main_Screen_Height*0.45
#define Alertheigth 80.0f
#define XWtitlegap 15.0f
#define XWtitleofheigth 10.0f
#define XWSinglebuttonWidth 160.0f
/*! 单个按钮时的宽度 */
#define XWdoublebuttonWidth 100.0f
/*! 双个按钮的宽度 */
#define XWbuttonHeigth 35.0f
/*! 按钮的高度 */
#define XWbuttonbttomgap 10.0f
/*! 设置按钮距离底部的边距 */

@interface HXAlterview ()
{
    CGFloat contentHight;
    BOOL _leftLeave;
    UIView *bgView;
    
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UIButton *leftbtn;
@property (nonatomic, strong) UIButton *rightbtn;
@property (nonatomic, strong) UIButton *centerbtn;

@property (nonatomic, strong) UIView *backimageView;

@end

@implementation HXAlterview



+ (CGFloat)alertWidth
{
    return Alertwidth;
}

+ (CGFloat)alertHeight
{
    return Alertheigth;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

+(HXAlterview*)showmessage:(NSString *)message subtitle:(NSString *)subtitle cancelbutton:(NSString *)cancle
{
    HXAlterview *alert = [[HXAlterview alloc] initWithTitle:message contentText:subtitle rightButtonTitle:nil leftButtonTitle:cancle];
    [alert show];
    alert.rightBlock = ^() {
    };
    alert.dismissBlock = ^() {
    };
    return alert;
}


- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    rightButtonTitle:(NSString *)leftTitle
   leftButtonTitle:(NSString *)rigthTitle
{
    if (self = [super init]) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Alertwidth, 35)];
        self.alertTitleLabel.font = UIFontSystem15;
        self.alertTitleLabel.textColor=[UIColor whiteColor];
        self.alertTitleLabel.backgroundColor = UIColorRedTheme;
        [self addSubview:self.alertTitleLabel];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.alertTitleLabel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.alertTitleLabel.bounds;
        maskLayer.path = maskPath.CGPath;
        self.alertTitleLabel.layer.mask = maskLayer;
        
        CGFloat contentLabelWidth = Alertwidth - 16-20;
        CGFloat contentStrHight = [content heightWithLabelFont:UIFontSystem13 withLabelWidth:Alertwidth];
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((Alertwidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame)+2, contentLabelWidth, contentStrHight+42)];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textColor = UIColorBlackTheme;
        self.alertContentLabel.font = UIFontSystem13;
        [self addSubview:self.alertContentLabel];
        /*! 设置对齐方式 */
        self.alertContentLabel.textAlignment = self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        contentHight = self.alertContentLabel.frame.size.height;
        
        /*! 横分割线 */
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, Alertheigth+contentHight - XWbuttonbttomgap - XWbuttonHeigth+1, Alertwidth, 1)];
        lineView.backgroundColor = UIColorLineTheme;
        [self addSubview:lineView];
        /*! 竖分割线 */
        UIView *vlineView = [[UIView alloc]initWithFrame:CGRectMake(Alertwidth/2, Alertheigth+contentHight - XWbuttonbttomgap - XWbuttonHeigth+1, 1, XWbuttonHeigth+8)];
        vlineView.backgroundColor = UIColorLineTheme;
        [self addSubview:vlineView];
        
        CGRect rightBtnFrame;
        CGRect leftBtnFrame;
        
        if (!leftTitle) {
            leftBtnFrame = CGRectMake(Alertwidth/2, Alertheigth+contentHight - XWbuttonbttomgap - XWbuttonHeigth+2, Alertwidth/2, XWbuttonHeigth+8);
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn.frame = leftBtnFrame;
            
        }else {
            rightBtnFrame = CGRectMake(0, Alertheigth+contentHight - XWbuttonbttomgap - XWbuttonHeigth+2, Alertwidth/2-1, XWbuttonHeigth+8);
            
            leftBtnFrame = CGRectMake(Alertwidth/2+1, Alertheigth+contentHight - XWbuttonbttomgap - XWbuttonHeigth+2, Alertwidth/2-1, XWbuttonHeigth+8);
            self.leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftbtn.frame = leftBtnFrame;
            self.rightbtn.frame = rightBtnFrame;
        }
       
        [self.leftbtn setBackgroundColor:UIColorWhite];
        [self.rightbtn setBackgroundColor:UIColorWhite];

        [self.rightbtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftbtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftbtn.titleLabel.font = self.rightbtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.leftbtn setTitleColor:UIColorRedTheme forState:UIControlStateNormal];
        [self.rightbtn setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
        [self.leftbtn addTarget:self action:@selector(leftbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightbtn addTarget:self action:@selector(rightbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftbtn.layer.masksToBounds = self.rightbtn.layer.masksToBounds = YES;
        self.leftbtn.layer.cornerRadius = self.rightbtn.layer.cornerRadius = 5.0;
        [self addSubview:self.leftbtn];
        [self addSubview:self.rightbtn];
        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
  centerButtonTitle:(NSString *)centerTitle
{
    if (self = [super init]) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Alertwidth, 35)];
        self.alertTitleLabel.font = UIFontSystem15;
        self.alertTitleLabel.textColor=[UIColor whiteColor];
        self.alertTitleLabel.backgroundColor = UIColorRedTheme;
        [self addSubview:self.alertTitleLabel];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.alertTitleLabel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.alertTitleLabel.bounds;
        maskLayer.path = maskPath.CGPath;
        self.alertTitleLabel.layer.mask = maskLayer;
        
        CGFloat contentLabelWidth = Alertwidth - 16-20;
        CGFloat contentStrHight = [content heightWithLabelFont:UIFontSystem14 withLabelWidth:Alertwidth];
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((Alertwidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame)+8, contentLabelWidth, contentStrHight+34)];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textColor = UIColorBlackTheme;
        self.alertContentLabel.font = UIFontSystem14;
        [self addSubview:self.alertContentLabel];
        /*! 设置对齐方式 */
        self.alertContentLabel.textAlignment = self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        contentHight = self.alertContentLabel.frame.size.height+10;
        
        /*! 分割线 */
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, Alertheigth+contentHight - XWbuttonHeigth-1, Alertwidth, 1)];
        lineView.backgroundColor = ColorWithRGB(213, 214, 215);
        [self addSubview:lineView];

        /*! 中心按钮 */
        CGRect rightBtnFrame;
        if (!self.centerbtn) {
        self.centerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtnFrame = CGRectMake(0, Alertheigth+contentHight - XWbuttonHeigth, Alertwidth, XWbuttonHeigth);
        self.centerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.centerbtn.frame = rightBtnFrame;
        [self.centerbtn setBackgroundColor:[UIColor whiteColor]];
        self.centerbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.centerbtn setTitle:centerTitle forState:UIControlStateNormal];
        [self.centerbtn setTitleColor:ColorWithRGB(41, 142, 251) forState:UIControlStateNormal];
        [self.centerbtn addTarget:self action:@selector(centerbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        self.centerbtn.layer.cornerRadius = 5;
        [self addSubview:self.centerbtn];
        }
        
        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;

}


- (void)leftbtnclicked:(id)sender
{
    
    if (self.leftBlock) {
        self.rightBlock();
    }
    [self dismissAlert];
}

- (void)rightbtnclicked:(id)sender
{
    
    if (self.rightBlock) {
        self.leftBlock();
    }
    [self dismissAlert];
}

- (void)centerbtnclicked:(id)sender
{
    
    if (self.centerBlock) {
        self.centerBlock();
    }
    [self dismissAlert];
}

- (void)show
{   /*! 获取第一响应视图视图 */
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((Main_Screen_Width - Alertwidth) * 0.5, (Main_Screen_Height - (Alertheigth+contentHight)) * 0.5, Alertwidth, Alertheigth+contentHight);
    self.alpha=0;
    [topVC.view addSubview:self];
}

+(void)showMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)dismissAlert
{
    
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{

    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)removeFromSuperview
{
        UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame =CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - (Alertheigth+contentHight)) * 0.5, Alertwidth, Alertheigth+contentHight);

    self.transform = CGAffineTransformMakeScale(0.97, 0.97);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.frame = afterFrame;
        self.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
        [self.backimageView removeFromSuperview];
        self.backimageView = nil;
        
    }];
}

/** 添加新视图时调用（在一个子视图将要被添加到另一个视图的时候发送此消息） */
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    /*! 获取根控制器 */
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backimageView) {
        self.backimageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backimageView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.5];
        self.backimageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    /*! 加载背景背景图,防止重复点击 */
    [topVC.view addSubview:self.backimageView];
        CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - (Alertheigth+contentHight)) * 0.5, Alertwidth, Alertheigth+contentHight);
    
    self.transform = CGAffineTransformMakeScale(0.97, 0.97);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0f;
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
        
    }];
    
    [super willMoveToSuperview:newSuperview];}

@end

