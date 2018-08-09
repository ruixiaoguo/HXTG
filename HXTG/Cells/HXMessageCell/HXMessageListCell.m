//
//  HXMessageListCell.m
//  HXTG
//
//  Created by grx on 2017/3/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMessageListCell.h"

@implementation HXMessageListCell

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
    /*! 图片 */
    CGFloat mePicHight = 30 ;
    self.picImageView = [UIImageView new];
    [self.contentView addSubview:self.picImageView];
    self.picImageView.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,11).widthIs(mePicHight).heightIs(mePicHight);
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = [UIFont systemFontOfSize:14];
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.picImageView,10).topSpaceToView(self.contentView,0).widthIs(200).heightIs(52);
    /*! 箭头 */
    UIImageView *tipImage = [UIImageView new];
    tipImage.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:tipImage];
    tipImage.sd_layout.rightSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(8).heightIs(15);
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    self.picImageView.image = [UIImage imageNamed:infoDic[@"pic"]];
    self.titleLable.text = infoDic[@"title"];
    
}

@end
