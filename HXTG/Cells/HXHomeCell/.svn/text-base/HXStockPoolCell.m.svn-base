//
//  HXStockPoolCell.m
//  HXTG
//
//  Created by grx on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXStockPoolCell.h"

@implementation HXStockPoolCell

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
    downLineViwe.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(5);
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = UIFontSystem14;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,8).rightSpaceToView(self.contentView,15).heightIs(20);
    /*! 时间 */
    self.timeLable = [UILabel new];
    self.timeLable.font = UIFontSystem12;
    self.timeLable.textColor = UIColorLightTheme;
    [self.contentView addSubview:self.timeLable];
    self.timeLable.sd_layout.leftEqualToView(self.titleLable).widthIs(100).bottomSpaceToView(downLineViwe,0).heightIs(30);
    /*! 风格 */
    self.styleLable = [UILabel new];
    self.styleLable.font = UIFontSystem12;
    self.styleLable.textColor = UIColorLightTheme;
    [self.contentView addSubview:self.styleLable];
    self.styleLable.sd_layout.leftSpaceToView(self.timeLable,20).widthIs(60).bottomSpaceToView(downLineViwe,0).heightIs(30);
    /*! 评价 */
    self.gradeLable = [UILabel new];
    self.gradeLable.font = UIFontSystem12;
    self.gradeLable.textColor = UIColorLightTheme;
    [self.contentView addSubview:self.gradeLable];
    self.gradeLable.sd_layout.leftSpaceToView(self.styleLable,14).rightSpaceToView(self.contentView,10).bottomSpaceToView(downLineViwe,0).heightIs(30);
}

-(void)setModel:(HXStockPoolModel *)model
{
    self.titleLable.text = [NSString stringWithFormat:@"%@ (%@) ",model.stock_title,model.stock_code];
    self.timeLable.text = model.stock_addtime;
    self.styleLable.text = [NSString stringWithFormat:@"风格:  %@",model.stock_type];
    self.gradeLable.text = [NSString stringWithFormat:@"评级:  %@",model.stock_opert_state];

}

@end
