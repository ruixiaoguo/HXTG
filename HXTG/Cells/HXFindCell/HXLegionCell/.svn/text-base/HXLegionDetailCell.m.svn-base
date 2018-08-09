//
//  HXLegionDetailCell.m
//  HXTG
//
//  Created by grx on 2017/5/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXLegionDetailCell.h"

@implementation HXLegionDetailCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
    downLineViwe.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(1);
    /*! 图片 */
    CGFloat mePicHight = 70;
    self.picImageView = [UIImageView new];
    self.picImageView.clipsToBounds = YES;
    self.picImageView.contentMode = UIViewContentModeScaleAspectFill;

    [self.contentView addSubview:self.picImageView];
    self.picImageView.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,14).widthIs(mePicHight).heightIs(mePicHight);
    /*! 带头人 */
    self.lrvingName = [UILabel new];
    self.lrvingName.font = UIFontSystem14;
    self.lrvingName.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.lrvingName];
    self.lrvingName.sd_layout.leftSpaceToView(self.picImageView,14).topSpaceToView(self.contentView, 14).rightSpaceToView(self.contentView, 15).heightIs(20);
    /*! 受聘机构 */
    self.lrvingStyle = [UILabel new];
    self.lrvingStyle.font = UIFontSystem14;
    self.lrvingStyle.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.lrvingStyle];
    self.lrvingStyle.sd_layout.leftEqualToView(self.lrvingName).topSpaceToView(self.lrvingName, 5).rightSpaceToView(self.contentView, 15).heightIs(20);
    /*! 职业资格证编号 */
    self.certificateNum = [UILabel new];
    self.certificateNum.font = UIFontSystem14;
    self.certificateNum.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.certificateNum];
    self.certificateNum.sd_layout.leftEqualToView(self.lrvingName).topSpaceToView(self.lrvingStyle, 5).rightSpaceToView(self.contentView, 0).heightIs(20);
    /*! 投资风格 */
//    self.introduction = [UILabel new];
//    self.introduction.font = UIFontSystem12;
//    self.introduction.textColor = UIColorBlackTheme;
//    self.introduction.text = @"投资风格：助攻绩优高成长品种";
//    [self.contentView addSubview:self.introduction];
//    self.introduction.sd_layout.leftEqualToView(self.lrvingName).topSpaceToView(self.certificateNum, 2).rightSpaceToView(self.contentView, 15).heightIs(15);
    
}

-(void)setModel:(HXLrvingDetailModel *)model
{
    NSString *picStr = [NSString stringWithFormat:@"%@",model.user_pic];
    picStr = [picStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:[UIImage imageNamed:@"banner"]];
    self.lrvingName.text = [NSString stringWithFormat:@"姓名: %@",model.user_nicename];
    self.lrvingStyle.text = [NSString stringWithFormat:@"受聘机构: %@",model.mechanism];
    if (model.card_number==nil) {
        self.certificateNum.text = [NSString stringWithFormat:@"资格证编号: "];
    }else{
        self.certificateNum.text = [NSString stringWithFormat:@"资格证编号: %@",model.card_number];
    }
}

@end
