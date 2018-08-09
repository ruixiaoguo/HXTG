//
//  HXTgReferenceCell.m
//  HXTG
//
//  Created by grx on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXTgReferenceCell.h"

@implementation HXTgReferenceCell

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
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,8).rightSpaceToView(self.contentView,25).heightIs(20);
    /*! 时间 */
    self.timeLable = [UILabel new];
    self.timeLable.font = UIFontSystem12;
    self.timeLable.textColor = UIColorLightTheme;
    self.timeLable.numberOfLines = 2;
    [self.contentView addSubview:self.timeLable];
    self.timeLable.sd_layout.leftEqualToView(self.titleLable).rightEqualToView(self.titleLable).bottomSpaceToView(downLineViwe,0).heightIs(35);
    
}

-(void)setModel:(HXTgRefeModel *)model
{
    self.titleLable.text = model.post_title;
    self.timeLable.text = model.post_date;
}

@end
