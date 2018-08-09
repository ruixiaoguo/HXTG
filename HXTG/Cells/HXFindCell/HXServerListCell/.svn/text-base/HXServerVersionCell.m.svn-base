//
//  HXServerListCell.m
//  HXTG
//
//  Created by grx on 2017/5/4.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXServerVersionCell.h"

@implementation HXServerVersionCell

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
    downLineViwe.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(10);
    /*! 图片 */
    CGFloat mePicHight = 43;
    self.picImageView = [UIImageView new];
    [self.contentView addSubview:self.picImageView];
    self.picImageView.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,12).widthIs(mePicHight).heightIs(38);
    /*! 标题 */
    self.titleLable = [UILabel new];
    //self.titleLable.font =  [UIFont fontWithName:@"Helvetica-Bold" size:14];
    self.titleLable.font = UIFontSystem14;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.picImageView,10).topEqualToView(self.picImageView).rightSpaceToView(self.contentView, 15).heightIs(23);
    /*! 副标题 */
    self.disLable = [UILabel new];
    self.disLable.font = UIFontSystem12;
    self.disLable.textColor = ColorWithRGB(139, 136, 134);
    [self.contentView addSubview:self.disLable];
    self.disLable.sd_layout.leftEqualToView(self.titleLable).topSpaceToView(self.titleLable, 0).rightSpaceToView(self.contentView, 15).heightIs(20);
    
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    self.picImageView.image = [UIImage imageNamed:infoDic[@"pic"]];
    self.titleLable.text = infoDic[@"title"];
    self.disLable.text = infoDic[@"dis"];
}


@end
