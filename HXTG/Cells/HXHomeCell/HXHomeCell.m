//
//  HXHomeCell.m
//  HXTG
//
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXHomeCell.h"

@implementation HXHomeCell

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
    downLineViwe.sd_layout.leftSpaceToView(self.contentView,15).rightSpaceToView(self.contentView,15).topSpaceToView(self.contentView,0).heightIs(1);
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = UIFontSystem13;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,45).heightIs(20);
    /*! 内容 */
    self.contentLable = [UILabel new];
    self.contentLable.font = UIFontSystem12;
    self.contentLable.numberOfLines = 0;
    self.contentLable.textColor = UIColorLightTheme;
    [self.contentView addSubview:self.contentLable];
    self.contentLable.sd_layout.leftSpaceToView(self.contentView,15).bottomSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,25).heightIs(30);
    /*! 箭头 */
    UIImageView *tipImgView = [UIImageView new];
    tipImgView.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:tipImgView];
    tipImgView.sd_layout.rightSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(8).heightIs(15);
}

-(void)setCellModel:(HXHomeCellModel *)cellModel
{
    self.titleLable.text = cellModel.post_title;
    self.contentLable.text = cellModel.post_date;
}

@end
