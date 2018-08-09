//
//  HXMyFollowCell.m
//  HXTG
//
//  Created by grx on 2017/3/31.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMyFollowCell.h"

@implementation HXMyFollowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView=[[UIView alloc]initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor=UIColorBgLightTheme;
        self.backgroundColor = UIColorWhite;
        [self markCell];
    }
    return self;
}

-(void)markCell
{
    /*! 分割线 */
    UIView *downLineViwe = [UIView new];
    downLineViwe.backgroundColor = UIColorBgLightTheme;
    [self.contentView addSubview:downLineViwe];
    downLineViwe.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(5);
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = UIFontSystem14;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.text = @"热点追踪---邦宝益智 (603398)";
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,8).rightSpaceToView(self.contentView,45).heightIs(20);
    /*! 风格 */
    self.styleLable = [UILabel new];
    self.styleLable.font = UIFontSystem13;
    self.styleLable.textColor = UIColorLightTheme;
    self.styleLable.numberOfLines = 1;
    self.styleLable.text = @"风格：中线";
    [self.contentView addSubview:self.styleLable];
    self.styleLable.sd_layout.rightSpaceToView(self.contentView,135).widthIs(70).bottomSpaceToView(downLineViwe,0).heightIs(35);

    /*! 时间 */
    self.timeLable = [UILabel new];
    self.timeLable.font = UIFontSystem13;
    self.timeLable.textColor = UIColorLightTheme;
    self.timeLable.numberOfLines = 1;
    self.timeLable.text = @"2017-3-8";
    [self.contentView addSubview:self.timeLable];
    self.timeLable.sd_layout.leftEqualToView(self.titleLable).rightSpaceToView(self.styleLable,10).bottomSpaceToView(downLineViwe,0).heightIs(35);
    /*! 评级 */
    self.rateLable = [UILabel new];
    self.rateLable.font = UIFontSystem13;
    self.rateLable.textColor = UIColorLightTheme;
    self.rateLable.numberOfLines = 1;
    self.rateLable.text = @"评级：买入";
    [self.contentView addSubview:self.rateLable];
    self.rateLable.sd_layout.leftSpaceToView(self.styleLable,0).widthIs(80).bottomSpaceToView(downLineViwe,0).heightIs(35);
    /*! 关注图片 */
    self.folowImage = [UIImageView new];
    self.folowImage.image = [UIImage imageNamed:@"quxiaoguanzhu-"];
    [self.contentView addSubview:self.folowImage];
    self.folowImage.sd_layout.rightSpaceToView(self.contentView,15).topSpaceToView(self.contentView,14).widthIs(25).heightIs(25);
    /*! 关注文本 */
    self.followLable = [UILabel new];
    self.followLable.font = UIFontSystem11;
    self.followLable.textColor = UIColorRedTheme;
    self.followLable.numberOfLines = 1;
    self.followLable.textAlignment = NSTextAlignmentCenter;
    self.followLable.text = @"取消关注";
    [self.contentView addSubview:self.followLable];
    self.followLable.sd_layout.centerXEqualToView(self.folowImage).widthIs(80).topSpaceToView(self.folowImage,0).heightIs(20);
    /*! 取消关注按钮 */
    self.followBtn = [UIButton new];
    [self.contentView addSubview:self.followBtn];
    self.followBtn.sd_layout.rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).widthIs(100).heightIs(70);
    [self.followBtn addTarget:self action:@selector(followBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)followBtnClick:(UIButton *)sender
{
    if (self.cancelFollowClick) {
        self.cancelFollowClick(sender.tag);
    }
}


-(void)setModel:(HXMyFollowModel *)model
{
    self.titleLable.text = [NSString stringWithFormat:@"%@ (%@) ",model.stock_title,model.stock_code];
    self.timeLable.text = model.stock_addtime;
    self.styleLable.text = [NSString stringWithFormat:@"风格:  %@",model.stock_type];
    self.rateLable.text = [NSString stringWithFormat:@"评级:  %@",model.stock_opert_state];
}

@end
