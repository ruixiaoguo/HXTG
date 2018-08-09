//
//  HXSystemCell.m
//  HXTG
//
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXSystemCell.h"

@implementation HXSystemCell

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
    self.titleLable.font = [UIFont systemFontOfSize:14];
    self.titleLable.textColor = UIColorBlackTheme;
    self.titleLable.text = @"致用户的一封信";
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,100).heightIs(52);
    /*! 时间 */
    self.timeLable = [UILabel new];
    self.timeLable.font = [UIFont systemFontOfSize:14];
    self.timeLable.textColor = UIColorLineTheme;
    self.timeLable.textAlignment = NSTextAlignmentRight;
    self.timeLable.text = @"14: 42";
    [self.contentView addSubview:self.timeLable];
    self.timeLable.sd_layout.rightSpaceToView(self.contentView,15).topSpaceToView(self.contentView,0).widthIs(80).heightIs(52);

}


@end
