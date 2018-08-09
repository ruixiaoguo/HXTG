//
//  HXBaseViewController.m
//  HXTG
//
//  Created by grx on 2017/2/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseViewController.h"

@interface HXBaseViewController ()

@end

@implementation HXBaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*! 显示小红点 */
    if (ISSERVERMESSAGE || ISRYCHATMESSAGE ||ISSOFFICIALMESSAGE) {
        [self.messageBtn showWhiteBadge];
    }else{
        [self.messageBtn clearBadge];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*! 前台接收到推送显示小红点 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeHomeMessage) name:ChangeHomeMessageNotification object:nil];
    /*! 接收到融云在线消息 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRongYChatMessage:) name:RYGetChatNotification object:nil];

    /*! 导航字颜色 */
    UIColor * color = UIColorBgWhiteTheme;
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    /*! 导航颜色 */
    [self.navigationController.navigationBar setBarTintColor:UIColorRedTheme];
    /*! 背景色 */
    self.view.backgroundColor = UIColorBgLightTheme;
    /*! 滑动返回 */
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"home_back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.frame = CGRectMake(0, 0, 40, 40);
    self.backButton.hidden = YES;
    UIBarButtonItem *backSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    backSpacer.width = -15;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:backSpacer,backItem,nil];

    
    /*! 导航消息 */
    self.messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.messageBtn.frame = CGRectMake(0,0,60,30);
    [self.messageBtn setImage:[UIImage imageNamed:@"home_xiaoxi"] forState:UIControlStateNormal];
    [self.messageBtn addTarget:self action:@selector(doMessageAction:) forControlEvents:UIControlEventTouchUpInside];
    self.messageBtn.hidden = YES;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -18;
    
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.messageBtn];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightButtonItem, nil];
    
}

- (void)setBarTintColorWithRed:(double)red green:(double)green blue:(double)blue alpha:(double)alpha {
    UIColor *tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    self.navigationController.navigationBar.barTintColor = tintColor;
    
//    const CGFloat *components = CGColorGetComponents(tintColor.CGColor);
    
//    self.redValue.text = [NSString stringWithFormat:@"%d", (int)((components[0] / 1.0f) * 255)];
//    self.greenValue.text = [NSString stringWithFormat:@"%d", (int)((components[1] / 1.0f) * 255)];
//    self.blueValue.text = [NSString stringWithFormat:@"%d", (int)((components[2] / 1.0f) * 255)];
//    self.alphaValue.text = [NSString stringWithFormat:@"%d%%", (int)((CGColorGetAlpha(tintColor.CGColor) / 1.0f) * 100)];
}


-(void)backClick
{
    
}


-(void)doMessageAction:(UIButton *)sender
{
    DDLog(@"跳转消息");
}


#pragma mark - 初始化异常界面
-(void)initEmptyView:(UIView *)superView
{
    self.noView = [[HXNoDataView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) showView:superView Stype:HXNoDataType];
}

-(void)initEmptyView:(UIView *)superView withFrame:(CGRect)frame
{
    self.noView = [[HXNoDataView alloc]initWithFrame:frame showView:superView Stype:HXNoDataType];
    self.noView.imageview.centerY = (Main_Screen_Height-Main_Screen_Height/3.28-125)/2+40;
    self.noView.label.frame = CGRectMake(0, CGRectGetMaxY(self.noView.imageview.frame),Main_Screen_Width, 85);

}

#pragma mark - 显示无数据界面
-(void)showNoDataView:(NSMutableArray *)allArray
{
    self.noView.stype = HXNoDataType;
    if (allArray.count==0||allArray==nil) {
        self.noView.hidden = NO;
    }else{
        self.noView.hidden = YES;
    }
}

#pragma mark - 显示无服务界面
-(void)showNoServerView:(NSMutableArray *)allArray
{
    self.noView.stype = HXNoServerType;
    if (allArray.count==0 || allArray==nil) {
        self.noView.hidden = NO;
    }else{
        self.noView.hidden = YES;
    }
}
#pragma mark - 显示无网络界面
-(void)showNoNetView:(NSMutableArray *)allArray
{
    self.noView.stype = HXNoNetType;
    if (allArray.count==0) {
        self.noView.hidden = NO;
        
    }else{
        self.noView.hidden = YES;
    }
}

#pragma mark - 直播未开始界面
-(void)showNoPlarView:(bool)isHave
{
    self.noView.stype = HXNoPlayType;
    if (isHave==NO) {
        self.noView.hidden = NO;
    }else{
        self.noView.hidden = YES;
    }
}

#pragma mark - 前台接收到推送显示小红点
-(void)changeHomeMessage
{
    /*! 显示小红点 */
    if (ISSERVERMESSAGE || ISRYCHATMESSAGE ||ISSOFFICIALMESSAGE) {
        [self.messageBtn showWhiteBadge];
    }else{
        [self.messageBtn clearBadge];
    }
}

-(void)getRongYChatMessage:(NSNotification *)notification
{
    DDLog(@"notification=====%@",notification.object);
    NSDictionary *dic = notification.object;
    if ([dic isKindOfClass:[NSDictionary class]]) {

    if ([dic[@"allunread"] isEqualToString:@"0"]&&!ISSERVERMESSAGE&&!ISSOFFICIALMESSAGE) {
        [self.messageBtn clearBadge];
        [StandardUserDefaults setBool:NO forKey:@"isRYChatMessage"];
    }else{
        /*! 融云消息显示小红点 */
        [self.messageBtn showWhiteBadge];
        [StandardUserDefaults setBool:YES forKey:@"isRYChatMessage"];
    }
    }
}


-(void)dealloc
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
