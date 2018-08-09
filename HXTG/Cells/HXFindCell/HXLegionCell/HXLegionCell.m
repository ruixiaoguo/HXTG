//
//  HXLegionCell.m
//  HXTG
//
//  Created by grx on 2017/5/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXLegionCell.h"

@implementation HXLegionCell

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
    CGFloat mePicHight = 98 ;
    self.picImageView = [UIImageView new];
    [self.contentView addSubview:self.picImageView];
    self.picImageView.clipsToBounds = YES;
    self.picImageView.contentMode = UIViewContentModeScaleAspectFill;

    self.picImageView.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,10).widthIs(mePicHight).heightIs(mePicHight);
    /*! 军团名称 */
    self.titleLable = [UILabel new];
    self.titleLable.font =  UIFontSystem15;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.picImageView,12).topEqualToView(self.picImageView).rightSpaceToView(self.contentView, 15).heightIs(15);
    /*! 带头人 */
    self.lrvingName = [UILabel new];
    self.lrvingName.font = UIFontSystem12;
    self.lrvingName.textColor = UIColorLightTheme;
    [self.contentView addSubview:self.lrvingName];
    self.lrvingName.sd_layout.leftEqualToView(self.titleLable).topSpaceToView(self.titleLable, 2).rightSpaceToView(self.contentView, 5).heightIs(20);
    /*! 风格 */
    self.lrvingStyle = [UILabel new];
    self.lrvingStyle.font = UIFontSystem12;
    self.lrvingStyle.textColor = UIColorLightTheme;
    [self.contentView addSubview:self.lrvingStyle];
    self.lrvingStyle.sd_layout.leftEqualToView(self.titleLable).topSpaceToView(self.lrvingName, 0).rightSpaceToView(self.contentView, 5).heightIs(15);
    /*! 职业资格证编号 */
    self.certificateNum = [UILabel new];
    self.certificateNum.font = UIFontSystem12;
    self.certificateNum.textColor = UIColorLightTheme;
    [self.contentView addSubview:self.certificateNum];
    self.certificateNum.sd_layout.leftEqualToView(self.titleLable).topSpaceToView(self.lrvingStyle, 2).rightSpaceToView(self.contentView, 0).heightIs(15);
    /*! 简介 */
    self.introduction = [UILabel new];
    self.introduction.font = UIFontSystem12;
    self.introduction.textColor = UIColorLightTheme;
    self.introduction.numberOfLines = 2;
    [self.contentView addSubview:self.introduction];
    self.introduction.sd_layout.leftEqualToView(self.titleLable).topSpaceToView(self.certificateNum, 0).rightSpaceToView(self.contentView, 15).heightIs(35);
    
}

-(void)setModel:(HXLrvingListModel *)model
{
    NSString *picStr = [NSString stringWithFormat:@"%@",model.lrving_img];
    picStr = [picStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:[UIImage imageNamed:@"banner"]];
    DDLog(@"picStr======%@",picStr);
    self.titleLable.text = model.lrving_name;
    self.lrvingName.text = [NSString stringWithFormat:@"带头人: %@",model.lrving_username];
    self.lrvingStyle.text = [NSString stringWithFormat:@"投资风格: %@",model.lrving_style];
    self.certificateNum.text = [NSString stringWithFormat:@"资格证编号: %@",model.lrving_dictate];
    self.introduction.text = [NSString stringWithFormat:@"简介: %@",model.legion_info];
}


@end
