//
//  HXMeInfoCell.m
//  HXTG
//
//  Created by grx on 2017/4/5.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMeInfoCell.h"

@implementation HXMeInfoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView=[[UIView alloc]initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor=UIColorBgLightTheme;
        self.backgroundColor = [UIColor whiteColor];
        UIView *upLine=[UIView new];
        upLine.backgroundColor=UIColorBgLightTheme;
        [self.contentView addSubview:upLine];
        upLine.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(1);
        [self markCell];
    }
    return self;
}

-(void)markCell
{
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = UIFontSystem14;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,18).topSpaceToView(self.contentView,13).widthIs(100).heightIs(20);
    /*! 内容 */
    self.discritLable = [UILabel new];
    self.discritLable.font = UIFontSystem14;
    self.discritLable.textColor = UIColorLightTheme;
    self.discritLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.discritLable];
    self.discritLable.sd_layout.leftSpaceToView(self.contentView, 100).rightSpaceToView(self.contentView,32).topSpaceToView(self.contentView,13).heightIs(20);
    /*! 箭头 */
    UIImageView *tipImage = [UIImageView new];
    tipImage.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:tipImage];
    tipImage.sd_layout.rightSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(8).heightIs(15);
    
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    self.titleLable.text = infoDic[@"title"];
    self.discritLable.text = infoDic[@"discrit"];
}


@end
