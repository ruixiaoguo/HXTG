//
//  HXFindCell.m
//  HXTG
//
//  Created by grx on 2017/3/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXFindCell.h"

@implementation HXFindCell

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
    CGFloat mePicHight = 30 ;
    self.picImageView = [UIImageView new];
    [self.contentView addSubview:self.picImageView];
    self.picImageView.sd_layout.leftSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(mePicHight).heightIs(mePicHight);
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = [UIFont systemFontOfSize:13];
    self.titleLable.textColor = ColorWithRGB(107, 107, 107);
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.picImageView,10).centerYEqualToView(self.contentView).widthIs(200).heightIs(20);
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
    picDic = infoDic;
}

-(void)setCellTag:(NSInteger)cellTag
{
    if (cellTag==100) {
        self.picImageView.sd_layout.leftSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(30).heightIs(24);
    }
    if (cellTag==101) {
        if ([picDic[@"isCheck"] isEqualToString:@"yes"]) {
            self.picImageView.sd_layout.leftSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(30).heightIs(29);
        }else{
            self.picImageView.sd_layout.leftSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(30).heightIs(25);
        }
    }
}


@end
