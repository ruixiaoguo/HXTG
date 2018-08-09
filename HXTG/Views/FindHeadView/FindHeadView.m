//
//  FindHeadView.m
//  HXTG
//
//  Created by grx on 2017/3/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "FindHeadView.h"

@implementation FindHeadView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self markeHeadView];
    }
    return self;
}

/*! 创建MeView */
-(void)markeHeadView
{
    for (int i=0; i<2; i++) {
        UIView *bgView = [UIView new];
        [self addSubview:bgView];
        bgView.tag = 10+i*1;
        bgView.sd_layout.leftSpaceToView(self,i*Main_Screen_Width/2).topSpaceToView(self,0).widthIs(Main_Screen_Width/2).heightIs(self.frame.size.height-30);
        /*! 手势 */
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClickTap:)];
        singleRecognizer.numberOfTapsRequired = 1;
        [bgView addGestureRecognizer:singleRecognizer];

        /*! 图片 */
        UIImageView *picImageView = [UIImageView new];
        [bgView addSubview:picImageView];
        CGFloat headHight = Main_Screen_Height/4.73;
        picImageView.tag = i+10;
        picImageView.sd_layout.centerXEqualToView(bgView).topSpaceToView(bgView,headHight/2-45).widthIs(headHight*0.28).heightIs(headHight*0.25);
        if (picImageView.tag==10) {
            picImageView.image = [UIImage imageNamed:@"guanyuwomen"];
        }else{
            picImageView.image = [UIImage imageNamed:@"kehufuwu"];
        }
        /*! 标题 */
        NSArray *titleArray = @[@"关于我们",@"客户服务"];
        UILabel *titleLable = [UILabel new];
        titleLable.font = UIFontSystem13;
        titleLable.textColor = ColorWithRGB(107, 107, 107);
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.tag = 100+i*1;
        titleLable.text = titleArray[titleLable.tag-100];
        [bgView addSubview:titleLable];
        titleLable.sd_layout.leftSpaceToView(bgView,0).rightSpaceToView(bgView,0).topSpaceToView(picImageView,0).heightIs(25);
        /*! 描述 */
        NSArray *discreArray = @[@"首批投顾,新三板挂牌",@"满意多一点"];
        UILabel *discreLable = [UILabel new];
        discreLable.font = UIFontSystem11;
        discreLable.textColor = ColorWithRGB(183, 183, 183);
        discreLable.textAlignment = NSTextAlignmentCenter;
        discreLable.tag = 200+i*1;
        discreLable.text = discreArray[discreLable.tag-200];
        [bgView addSubview:discreLable];
        discreLable.sd_layout.leftSpaceToView(bgView,0).rightSpaceToView(bgView,0).topSpaceToView(titleLable,-5).heightIs(20);
    }
    /*! 分割线 */
    UIView *lineView = [UIView new];
    lineView.backgroundColor = ColorWithRGB(237, 237, 237);
    [self addSubview:lineView];
    lineView.sd_layout.centerXEqualToView(self).topSpaceToView(self,15).heightIs(self.frame.size.height-55).widthIs(1);
    /*! 更多发现 */
    UIView *moreView = [UIView new];
    moreView.backgroundColor = ColorWithRGB(237, 237, 237);
    [self addSubview:moreView];
    moreView.sd_layout.leftSpaceToView(self,0).bottomSpaceToView(self,0).rightSpaceToView(self,0).heightIs(25);
    UILabel *moreLable = [UILabel new];
    moreLable.text = @"更多发现";
    moreLable.font = [UIFont systemFontOfSize:13];
    moreLable.textColor = ColorWithRGB(107, 107, 107);
    [moreView addSubview:moreLable];
    moreLable.sd_layout.leftSpaceToView(moreView,15).rightSpaceToView(moreView,0).topEqualToView(moreView).heightIs(25);
}

#pragma mark - 炒股攻略手势事件
-(void)bgViewClickTap:(UITapGestureRecognizer *)recognizer
{
    if (self.bgViewClickTapClickBlock) {
        self.bgViewClickTapClickBlock(recognizer.view.tag);
    }
}


@end
