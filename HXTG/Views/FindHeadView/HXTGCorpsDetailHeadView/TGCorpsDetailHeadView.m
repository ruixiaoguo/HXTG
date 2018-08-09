//
//  TGCorpsDetailHeadView.m
//  HXTG
//
//  Created by grx on 2017/5/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "TGCorpsDetailHeadView.h"
#import "UILabel+ContentSize.h"
#import "NSString+TxtHeight.h"

@implementation TGCorpsDetailHeadView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self markeHeadView];
    }
    return self;
}

/*! 创建MeView */
-(void)markeHeadView
{
    /*! 图片 */
    self.lrvingImage = [UIImageView new];
    [self addSubview:self.lrvingImage];
    self.lrvingImage.clipsToBounds = YES;
    self.lrvingImage.contentMode = UIViewContentModeScaleAspectFill;
    self.lrvingImage.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, 15).widthIs(90).heightIs(90);
    /*! 带头人 */
    self.lrvingName = [UILabel new];
    self.lrvingName.font = UIFontSystem14;
    self.lrvingName.textColor = UIColorBlackTheme;
    [self addSubview:self.lrvingName];
    self.lrvingName.sd_layout.leftSpaceToView(self.lrvingImage, 10).topEqualToView(self.lrvingImage).rightSpaceToView(self, 15).heightIs(25);
    /*! 职业资格证编号 */
    self.certificateNum = [UILabel new];
    self.certificateNum.font = UIFontSystem14;
    self.certificateNum.textColor = UIColorBlackTheme;
    [self addSubview:self.certificateNum];
    self.certificateNum.sd_layout.leftEqualToView(self.lrvingName).topSpaceToView(self.lrvingName, 3).rightSpaceToView(self, 0).heightIs(25);
    /*! 风格 */
    self.lrvingStyle = [UILabel new];
    self.lrvingStyle.font = UIFontSystem14;
    self.lrvingStyle.textColor = UIColorBlackTheme;
    self.lrvingStyle.numberOfLines = 0;
    [self addSubview:self.lrvingStyle];
    self.lrvingStyle.sd_layout.leftEqualToView(self.lrvingName).topSpaceToView(self.certificateNum, 0).rightSpaceToView(self, 5).heightIs(25);
    /*! 简介 */
    self.introduction = [UILabel new];
    self.introduction.font = UIFontSystem14;
    self.introduction.textColor = UIColorBlackTheme;
    self.introduction.numberOfLines = 3;
    [self addSubview:self.introduction];
    self.introduction.sd_layout.leftEqualToView(self.lrvingImage).topSpaceToView(self.lrvingImage, 5).rightSpaceToView(self, 15).heightIs(60);
    /*! 军团成员 */
    UIView *bgView = [UIView new];
    bgView.backgroundColor = UIColorBgLightTheme;
    [self addSubview:bgView];
    bgView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self.introduction, 10).heightIs(40);
    /*! 分割线 */
    UIView *lineViwe = [UIView new];
    lineViwe.backgroundColor = UIColorBlueTheme;
    lineViwe.frame = CGRectMake(6, 12, 4, 20);
    [bgView addSubview:lineViwe];
    /*! 文字标题 */
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorBlackTheme;
    label.font = UIFontSystem14;
    label.frame = CGRectMake(16, 2, 100, 40);
    label.text = @"军团成员";
    [bgView addSubview:label];

}

-(void)setIntroHight:(CGFloat)introHight
{
//    self.introduction.sd_layout.heightIs(introHight);
}

-(void)setHeadDic:(NSDictionary *)headDic
{
    NSString *picStr = [NSString stringWithFormat:@"%@",headDic[@"lrving_img"]];
    picStr = [picStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.lrvingImage sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:[UIImage imageNamed:@"banner"]];
    self.lrvingName.text = [NSString stringWithFormat:@"带头人: %@",headDic[@"lrving_username"]];
    self.certificateNum.text = [NSString stringWithFormat:@"资格证编号: %@",headDic[@"lrving_dictate"]];
    NSString *styleStr = headDic[@"lrving_style"];
    self.lrvingStyle.text = [NSString stringWithFormat:@"投资风格: %@",styleStr];
    CGFloat contentStrHight = [styleStr heightWithLabelFont:UIFontSystem14 withLabelWidth:Main_Screen_Width-120];
    self.lrvingStyle.sd_layout.heightIs(contentStrHight+20);
    self.introduction.text = [NSString stringWithFormat:@"简介: %@",headDic[@"intro"]];
}

@end
