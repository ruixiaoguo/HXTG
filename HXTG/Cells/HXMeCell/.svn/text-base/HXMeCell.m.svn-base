//
//  HXMeCell.m
//  HXTG
//
//  Created by grx on 2017/3/1.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMeCell.h"

@implementation HXMeCell

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
        upLine.sd_layout.leftSpaceToView(self.contentView,20).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(1);
        [self markCell];
    }
    return self;
}

-(void)markCell
{
    /*! 图片 */
    CGFloat mePicHight = 20 ;
    self.picImageView = [UIImageView new];
    [self.contentView addSubview:self.picImageView];
    self.picImageView.sd_layout.leftSpaceToView(self.contentView,25).topSpaceToView(self.contentView,12).widthIs(mePicHight).heightIs(mePicHight);
    
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = [UIFont systemFontOfSize:14];
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.picImageView,12).topSpaceToView(self.contentView,13).widthIs(100).heightIs(20);
    /*! 箭头 */
    UIImageView *tipImage = [UIImageView new];
    tipImage.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:tipImage];
    tipImage.sd_layout.rightSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(8).heightIs(15);

}

-(void)setCellTag:(NSInteger)cellTag
{
    if (cellTag==10) {
        self.picImageView.sd_layout.leftSpaceToView(self.contentView,25).topSpaceToView(self.contentView,13).widthIs(20).heightIs(18);
    }else if (cellTag==11){
        self.picImageView.sd_layout.leftSpaceToView(self.contentView,25).topSpaceToView(self.contentView,13).widthIs(20).heightIs(19);
    }else if (cellTag==12){
        self.picImageView.sd_layout.leftSpaceToView(self.contentView,25).topSpaceToView(self.contentView,15).widthIs(20).heightIs(15);
    }else if (cellTag==13){
        if ([picDic[@"isCheck"] isEqualToString:@"yes"]) {
            self.picImageView.sd_layout.leftSpaceToView(self.contentView,27).topSpaceToView(self.contentView,13).widthIs(19).heightIs(19);
        }else{
            self.picImageView.sd_layout.leftSpaceToView(self.contentView,27).topSpaceToView(self.contentView,13).widthIs(17).heightIs(19);
        }
    }else if (cellTag==14){
        if ([picDic[@"isCheck"] isEqualToString:@"yes"]) {
            self.picImageView.sd_layout.leftSpaceToView(self.contentView,27).topSpaceToView(self.contentView,12).widthIs(17).heightIs(19);
        }else{
            self.picImageView.sd_layout.leftSpaceToView(self.contentView,26).topSpaceToView(self.contentView,12).widthIs(20).heightIs(20);
        }
    }else if (cellTag==15){
        self.picImageView.sd_layout.leftSpaceToView(self.contentView,27).topSpaceToView(self.contentView,13).widthIs(17).heightIs(19);
    }
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    self.picImageView.image = [UIImage imageNamed:infoDic[@"pic"]];
    self.titleLable.text = infoDic[@"title"];
    picDic = infoDic;
}


@end
