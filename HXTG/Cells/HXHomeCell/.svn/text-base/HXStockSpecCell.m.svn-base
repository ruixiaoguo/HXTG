//
//  HXStockSpecCell.m
//  HXTG
//
//  Created by grx on 2017/3/24.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXStockSpecCell.h"

@implementation HXStockSpecCell

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
    self.titleLable.font = UIFontSystem13;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,7).rightSpaceToView(self.contentView,15).heightIs(20);
    /*! 内容 */
    self.contentLable = [UILabel new];
    self.contentLable.font = UIFontSystem13;
    self.contentLable.textColor = UIColorLightTheme;
    [self.contentView addSubview:self.contentLable];
    self.contentLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.titleLable,2).rightSpaceToView(self.contentView,15).heightIs(20);
    /*! 时间 */
    self.timeLable = [UILabel new];
    self.timeLable.font = UIFontSystem12;
    self.timeLable.textColor = UIColorLightTheme;
    self.timeLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLable];
    self.timeLable.sd_layout.rightSpaceToView(self.contentView,15).topSpaceToView(self.contentLable,2).widthIs(100).heightIs(20);
    
}

-(void)setModel:(HXHomeCellModel *)model
{
    self.titleLable.text = model.post_title;
    self.contentLable.text = model.post_content;
    self.timeLable.text = model.post_date;
}


@end
