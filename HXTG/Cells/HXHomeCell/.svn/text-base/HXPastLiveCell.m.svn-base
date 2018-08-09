//
//  PastLiveCell.m
//  HXTG
//
//  Created by grx on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXPastLiveCell.h"

@implementation HXPastLiveCell

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
    downLineViwe.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(5);
    /*! 视频图片 */
    self.picImageView = [UIImageView new];
    [self.contentView addSubview:self.picImageView];
    self.picImageView.image = [UIImage imageNamed:@"meBg"];
    self.picImageView.clipsToBounds = YES;
    self.picImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,12).widthIs(48).heightIs(38);
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = UIFontSystem14;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.picImageView,10).topSpaceToView(self.contentView,8).rightSpaceToView(self.contentView,25).heightIs(20);
    /*! 主播 */
    self.contentLable = [UILabel new];
    self.contentLable.font = UIFontSystem13;
    self.contentLable.textColor = UIColorBlackTheme;
    self.contentLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.contentLable];
    self.contentLable.sd_layout.rightSpaceToView(self.contentView,15).bottomSpaceToView(self.contentView,10).widthIs(200).heightIs(20);
}

-(void)setModel:(HXLiveHistoryModel *)model
{
    
    self.titleLable.text = model.train_title;
    self.contentLable.text = [NSString stringWithFormat:@"主播:  %@",model.opert_user];
    NSString *picStr = [NSString stringWithFormat:@"%@",model.video_pic];
    picStr = [picStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:[UIImage imageNamed:@"banner"]];
}

@end
