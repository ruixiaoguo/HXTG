//
//  HXCustomCell.m
//  HXTG
//
//  Created by grx on 2017/5/4.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXCustomCell.h"

@implementation HXCustomCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView=[[UIView alloc]initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor=UIColorBgLightTheme;
        self.backgroundColor = UIColorWhite;
        UIView *upLine=[UIView new];
        upLine.backgroundColor = ColorWithRGB(237, 237, 237);
        [self.contentView addSubview:upLine];
        upLine.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(4);
        [self markCell];
    }
    return self;
}

-(void)markCell
{
    
    /*! 图片 */
    CGFloat mePicHight = 30;
    self.iconImage = [UIImageView new];
    [self.contentView addSubview:self.iconImage];
    self.iconImage.sd_layout.leftSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(mePicHight).heightIs(mePicHight);
    /*! 标题 */
    self.titlelable = [UILabel new];
    self.titlelable.font = UIFontSystem14;
    self.titlelable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titlelable];
    self.titlelable.sd_layout.leftSpaceToView(self.iconImage,10).centerYEqualToView(self.contentView).widthIs(60).heightIs(20);
    /*! 副标题 */
    self.disLable = [UILabel new];
    self.disLable.font = UIFontSystem14;
    self.disLable.textColor = UIColorLightTheme;
    [self.contentView addSubview:self.disLable];
    self.disLable.sd_layout.leftSpaceToView(self.titlelable,10).centerYEqualToView(self.contentView).widthIs(200).heightIs(20);
    /*! 箭头 */
    tipImage = [UIImageView new];
    tipImage.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:tipImage];
    tipImage.sd_layout.rightSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(8).heightIs(15);
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    self.iconImage.image = [UIImage imageNamed:infoDic[@"pic"]];
    self.titlelable.text = infoDic[@"title"];
    self.disLable.text = infoDic[@"dis"];
    if ([infoDic[@"title"] isEqualToString:@"客服邮箱"]) {
        tipImage.hidden = YES;
    }
}



@end
