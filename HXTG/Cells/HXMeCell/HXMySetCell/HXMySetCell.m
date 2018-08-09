//
//  HXMySetCell.m
//  HXTG
//
//  Created by grx on 2017/3/31.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMySetCell.h"

@implementation HXMySetCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView=[[UIView alloc]initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor=UIColorBgLightTheme;
        UIView *upLine=[UIView new];
        upLine.backgroundColor = UIColorBgLightTheme;
        [self.contentView addSubview:upLine];
        upLine.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(5);
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
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,15).widthIs(200).heightIs(20);
    /*! 版本 */
    self.versionLable = [UILabel new];
    self.versionLable.font = UIFontSystem14;
    self.versionLable.textColor = UIColorLightTheme;
    self.versionLable.textAlignment = NSTextAlignmentRight;
    /*! 当前版本号 */
    NSString *version=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    self.versionLable.text = [NSString stringWithFormat:@"V%@",version];
    [self.contentView addSubview:self.versionLable];
    self.versionLable.sd_layout.rightSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(100).heightIs(55);
    /*! 箭头 */
    tipImage = [UIImageView new];
    tipImage.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:tipImage];
    tipImage.sd_layout.rightSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(8).heightIs(15);
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    self.titleLable.text = infoDic[@"title"];
    if ([infoDic[@"title"] isEqualToString:@"当前版本"]) {
        self.versionLable.hidden = NO;
        tipImage.hidden = YES;
    }else{
        self.versionLable.hidden = YES;
        tipImage.hidden = NO;
    }
}


@end
