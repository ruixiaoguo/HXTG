//
//  HXOperatePlanCell.m
//  HXTG
//
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXOperatePlanCell.h"

@implementation HXOperatePlanCell

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
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,100).heightIs(55);
    /*! 时间 */
    self.timeLable = [UILabel new];
    self.timeLable.font = UIFontSystem14;
    self.timeLable.textColor = UIColorLightTheme;
    self.timeLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLable];
    self.timeLable.sd_layout.rightSpaceToView(self.contentView,15).topSpaceToView(self.contentView,0).widthIs(150).heightIs(55);
    
}

-(void)setModel:(HXTraderPlanModel *)model
{
    self.titleLable.text = model.post_title;
    self.timeLable.text = model.post_date;
}

@end
