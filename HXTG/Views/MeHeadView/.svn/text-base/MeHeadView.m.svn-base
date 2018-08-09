//
//  MeHeadView.m
//  HXTG
//
//  Created by grx on 2017/3/1.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "MeHeadView.h"

@implementation MeHeadView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = UIColorBgLightTheme;
    
        [self markeHeadView];
    }
    return self;
}

/*! 创建MeView */
-(void)markeHeadView
{
    /*! 背景图片 */
    self.bgImage = [UIImageView new];
    self.bgImage.image = [UIImage imageNamed:@"bg"];
    self.bgImage.userInteractionEnabled = YES;
    [self addSubview:self.bgImage];
    /*! 手势 */
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgImageClickTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self.bgImage addGestureRecognizer:singleRecognizer];
    /*! 头像 */
    self.headImage = [UIImageView new];
    self.headImage.layer.cornerRadius = self.headImage.frame.size.height/2;
    self.headImage.image = [UIImage imageNamed:@"touxiang"];
    [self.bgImage addSubview:self.headImage];
    /*! 用户名 */
    self.userName = [UILabel new];
    self.userName.text = @"点击登录";
    self.userName.font = [UIFont systemFontOfSize:14];
    self.userName.textColor = [UIColor whiteColor];
    self.userName.textAlignment = NSTextAlignmentCenter;
    [self.bgImage addSubview:self.userName];
    
    lineView = [UIView new];
    lineView.backgroundColor = ColorWithRGB(237, 237, 237);
    [self.bgImage addSubview:lineView];
    /*! 约束布局 */
    [self layoutFrame];
}

-(void)layoutFrame
{
    CGFloat meHeadHight = Main_Screen_Height*0.33 ;
    
    self.bgImage.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).
    heightIs(meHeadHight);
    self.headImage.sd_layout.centerXEqualToView(self.bgImage).topSpaceToView(self.bgImage,meHeadHight/2-48).widthIs(meHeadHight*0.36).heightIs(meHeadHight*0.36);
    self.userName.sd_layout.leftSpaceToView(self.bgImage, 0).topSpaceToView(self.headImage,5).rightSpaceToView(self.bgImage,0).heightIs(25);
    lineView.sd_layout.leftSpaceToView(self.bgImage,0).rightSpaceToView(self.bgImage,0).bottomSpaceToView(self.bgImage,0).heightIs(10);
}

-(void)bgImageClickTap:(UITapGestureRecognizer *)recognizer
{
    if (self.bgImageClickBlock) {
        self.bgImageClickBlock();
    }
}

@end
