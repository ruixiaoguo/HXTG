//
//  HXPoolDetailHeadView.m
//  HXTG
//
//  Created by grx on 2017/3/27.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXPoolDetailHeadView.h"

#pragma mark - 头部视图
@implementation HXPoolDetailTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorHigRedTheme;
        [self markeView];
    }
    return self;
}

-(void)markeView
{
    /*! 背景图片 */
    UIImageView *bgImgView = [UIImageView new];
    bgImgView.image = [UIImage imageNamed:@"chi"];
    bgImgView.layer.masksToBounds = YES;
    bgImgView.userInteractionEnabled = YES;
    bgImgView.alpha = 0.9;
    [self addSubview:bgImgView];
    bgImgView.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).topSpaceToView(self,0).heightIs(self.frame.size.height);
    /*! 垂直分割线 */
    UIView *verView = [UIView new];
    verView.backgroundColor = ColorWithHexRGB(0xffc554);
    verView.alpha = 0.5;
    [bgImgView addSubview:verView];
    verView.sd_layout.leftSpaceToView(bgImgView,22).widthIs(1).topSpaceToView(bgImgView,12).heightIs(bgImgView.frame.size.height-24);
    /*! 股票标题 */
    self.stockTitle = [UILabel new];
    self.stockTitle.textColor = UIColorWhite;
    self.stockTitle.font = UIFontSystem14;
    [bgImgView addSubview:self.stockTitle];
    self.stockTitle.sd_layout.leftSpaceToView(verView,8).rightSpaceToView(bgImgView,80).topEqualToView(verView).heightIs(25);
    /*! 横向分割线 */
    UIView *herView = [UIView new];
    herView.backgroundColor = ColorWithHexRGB(0xffc554);
    herView.alpha = 0.5;
    [bgImgView addSubview:herView];
    herView.sd_layout.leftSpaceToView(verView,0).topSpaceToView(self.stockTitle,0).rightSpaceToView(bgImgView,Main_Screen_Width/2-12).heightIs(1);
    UIView *circleView = [UIView new];
    circleView.backgroundColor = ColorWithHexRGB(0xffc554);
    circleView.layer.cornerRadius = 2;
    circleView.alpha = 0.5;
    [bgImgView addSubview:circleView];
    circleView.sd_layout.leftSpaceToView(bgImgView,20.5).topSpaceToView(herView,-2.5).widthIs(4).heightIs(4);
    /*! 买入卖出 */
    self.sealTitle = [UILabel new];
    self.sealTitle.textColor = ColorWithHexRGB(0xffc554);
    self.sealTitle.font = UIFontSystem14;
    [bgImgView addSubview:self.sealTitle];
    self.sealTitle.sd_layout.leftEqualToView(self.stockTitle).rightEqualToView(self.stockTitle).topSpaceToView(self.stockTitle,0).heightIs(25);
    /*! 描述 */
    self.discrTitle = [UILabel new];
    self.discrTitle.textColor = UIColorWhite;
    self.discrTitle.font = UIFontSystem14;
    [bgImgView addSubview:self.discrTitle];
    self.discrTitle.sd_layout.leftEqualToView(self.stockTitle).rightEqualToView(self.stockTitle).topSpaceToView(self.sealTitle,0).heightIs(25);
    /*! 关注背景层 */
    UIView *followBgView = [UIView new];
    [bgImgView addSubview:followBgView];
    followBgView.sd_layout.rightSpaceToView(bgImgView,0).topSpaceToView(bgImgView,0).widthIs(100).heightIs(bgImgView.frame.size.height);
    /*! 关注按钮 */
    self.followImg = [UIImageView new];
    [followBgView addSubview:self.followImg];
    self.followImg.sd_layout.rightSpaceToView(followBgView,30).topSpaceToView(followBgView,followBgView.frame.size.height/2-20).widthIs(25).heightIs(25);
    /*! 关注文字 */
    self.followTitle = [UILabel new];
    self.followTitle.textColor = UIColorWhite;
    self.followTitle.font = UIFontSystem12;
    self.followTitle.textAlignment = NSTextAlignmentCenter;
    [followBgView addSubview:self.followTitle];
    self.followTitle.sd_layout.centerXEqualToView(self.followImg).topSpaceToView(self.followImg,0).widthIs(50).heightIs(20);
    /*! 手势 */
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(followBgViewClickTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [followBgView addGestureRecognizer:singleRecognizer];

}

#pragma mark - 炒股攻略手势事件
-(void)followBgViewClickTap:(UITapGestureRecognizer *)recognizer
{
    
    if (self.followClickBlock) {
        self.followClickBlock();
    }
}

-(void)setStockModel:(HXStockPoolModel *)stockModel
{
    self.stockTitle.text = [NSString stringWithFormat:@"%@ %@",stockModel.stock_name,stockModel.stock_code];
    self.sealTitle.text = stockModel.stock_opert_state;

    if ([stockModel.isconcern isEqualToString:@"0"]) {
        /*! 未关注 */
        self.followImg.image = [UIImage imageNamed:@"unguanzhu-"];
        self.followTitle.text = @"关注";
        self.followTitle.textColor = UIColorWhite;
    }else{
        self.followImg.image = [UIImage imageNamed:@"guanzhu-"];
        self.followTitle.text = @"已关注";
        self.followTitle.textColor = UIColorWhite;
    }
}

-(void)setStock_oper_desc:(NSString *)stock_oper_desc
{
    self.discrTitle.text = stock_oper_desc;
    
}

@end

#pragma mark - tableViewHeader视图
@implementation HXPoolDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorBlackTheme;
        [self markeView];
    }
    return self;
}

-(void)markeView
{
    /*! 背景框 */
    self.bgView = [UIView new];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.backgroundColor = ColorWithRGB(153, 153, 153);
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = ColorWithRGB(153, 153, 153).CGColor;
    [self addSubview:self.bgView];
    /*! 内容 */
    self.contentLable = [UILabel new];
    self.contentLable.textColor = ColorWithHexRGB(0xf5e297);
    self.contentLable.font = UIFontSystem13;
    self.contentLable.numberOfLines = 0;
    [self.bgView addSubview:self.contentLable];

}

-(void)setHeadViewHight:(CGFloat)headViewHight
{
    self.bgView.sd_layout.leftSpaceToView(self,15).topSpaceToView(self,15).rightSpaceToView(self,15).heightIs(headViewHight);
    self.contentLable.sd_layout.leftSpaceToView(self.bgView,12).rightSpaceToView(self.bgView,12).topSpaceToView(self.bgView,5).heightIs(self.bgView.frame.size.height-10);

}

@end




