//
//  HXServerDetailCell.m
//  HXTG
//
//  Created by grx on 2017/5/5.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXServerDetailVerCell.h"

@implementation HXServerDetailVerCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorWhite;
        [self markCell];
    }
    return self;
}

-(void)markCell
{
    
    /*! 标题 */
    self.bgPriceView = [UIView new];
    [self.contentView addSubview:self.bgPriceView];
    self.bgPriceView.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).rightSpaceToView(self.contentView, 0).heightIs(44);
    /*! 分割线 */
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColorLineTheme;
    [self.bgPriceView addSubview:lineView];
    lineView.sd_layout.centerXEqualToView(self.bgPriceView).topSpaceToView(self.bgPriceView,0).heightIs(44).widthIs(1);
    /*! 季度价格 */
    self.monPriceLable = [UILabel new];
    self.monPriceLable.textColor = UIColorBlackTheme;
    self.monPriceLable.textAlignment = NSTextAlignmentCenter;
    self.monPriceLable.font = UIFontSystem15;
    [self.bgPriceView addSubview:self.monPriceLable];
    self.monPriceLable.text = @"12.8万元/季度";
    self.monPriceLable.sd_layout.leftSpaceToView(self.bgPriceView,0).topSpaceToView(self.bgPriceView,0).rightSpaceToView(self.bgPriceView, Main_Screen_Width/2).heightIs(44);
    /*! 半年价格 */
    self.yearPriceLable = [UILabel new];
    self.yearPriceLable.textColor = UIColorBlackTheme;
    self.yearPriceLable.textAlignment = NSTextAlignmentCenter;
    self.yearPriceLable.font = UIFontSystem15;
    [self.bgPriceView addSubview:self.yearPriceLable];
    self.yearPriceLable.text = @"24.8万元/半年";
    self.yearPriceLable.sd_layout.leftSpaceToView(self.bgPriceView,Main_Screen_Width/2).topSpaceToView(self.bgPriceView,0).rightSpaceToView(self.bgPriceView, 0).heightIs(44);
    /*! 图片 */
    self.picImageView = [UIImageView new];
    [self.contentView addSubview:self.picImageView];
    self.picImageView.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.bgPriceView,0).widthIs(Main_Screen_Width).heightIs(Main_Screen_Height*0.535-44);
    [self.picImageView setImage:[UIImage imageNamed:@"zy"]];
    
}
//
//-(void)setInfoDic:(NSDictionary *)infoDic
//{
//    self.picImageView.image = [UIImage imageNamed:infoDic[@"pic"]];
//    self.titleLable.text = infoDic[@"title"];
//    self.disLable.text = infoDic[@"dis"];
//}



@end
