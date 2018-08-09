//
//  HXAskListCell.m
//  HXTG
//
//  Created by grx on 2017/6/8.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXAskListCell.h"

@implementation HXAskListCell

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
    self.titleLable.font = UIFontSystem15;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,0).widthIs(200).heightIs(55);
    /*! 未读消息 */
    self.unReadMessageLable = [UILabel new];
    self.unReadMessageLable.font = UIFontSystem13;
    self.unReadMessageLable.textColor = UIColorHigRedTheme;
    [self.contentView addSubview:self.unReadMessageLable];
    self.unReadMessageLable.textAlignment = NSTextAlignmentRight;
    self.unReadMessageLable.sd_layout.rightSpaceToView(self.contentView,40).topSpaceToView(self.contentView,0).widthIs(100).heightIs(55);
    /*! 箭头 */
    UIImageView *tipImage = [UIImageView new];
    tipImage.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:tipImage];
    tipImage.sd_layout.rightSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(8).heightIs(15);
}

-(void)setModel:(HXAskListModel *)model
{
    self.titleLable.text = [NSString stringWithFormat:@"%@老师",model.user_nicename];
    if ([model.unReadMessage isEqualToString:@"0"] ||model.unReadMessage.length==0) {
        self.unReadMessageLable.text = @"";
    }else{
        self.unReadMessageLable.text = [NSString stringWithFormat:@"%@条未读",model.unReadMessage];
    }
}

@end
