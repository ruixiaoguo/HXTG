//
//  HXMyBindCartController.m
//  HXTG
//
//  Created by grx on 2017/3/31.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMyBindCartController.h"
#import "UILabel+ContentSize.h"
#import "NSString+TxtHeight.h"

@interface HXMyBindCartController ()

@end

@implementation HXMyBindCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员中心";
    self.backButton.hidden = NO;
    self.view.backgroundColor = UIColorBgLightTheme;
    [self markView];

}

-(void)markView
{
    /*! 内容 */
    NSString *userName = self.memberArray[0];
    NSString *grade = self.memberArray[1];
    NSString *memNub = self.memberArray[2];
    NSArray *contentArray = @[userName,grade,memNub];
    /*! 背景层 */
    UIView *bgView = [UIView new];
    bgView.backgroundColor = UIColorWhite;
    [self.view addSubview:bgView];
    bgView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,64).heightIs(390);
    /*! 会员卡 */
    UIImageView *cartImageView = [UIImageView new];
    if ([grade isEqualToString:@"水晶"]) {
        cartImageView.image = [UIImage imageNamed:@"shuijingka"];
    }else if ([grade isEqualToString:@"黑钻"]){
        cartImageView.image = [UIImage imageNamed:@"heizuanka"];
    }else if ([grade isEqualToString:@"黄钻"]){
        cartImageView.image = [UIImage imageNamed:@"huangjinka"];
    }else{
        cartImageView.image = [UIImage imageNamed:@"huangjinka"];
    }
    [bgView addSubview:cartImageView];
    cartImageView.sd_layout.centerXEqualToView(bgView).topSpaceToView(bgView,30).widthIs(187).heightIs(120);
    /*! 标题 */
    NSArray *titleArray = @[@"用户名:",@"会员等级:",@"会员卡号:",@"会员特权:"];
    for (int i=0; i<4; i++) {
        UILabel *titleLable = [UILabel new];
        titleLable.font = UIFontSystem14;
        titleLable.textColor = UIColorBlackTheme;
        titleLable.text = titleArray[i];
        [bgView addSubview:titleLable];
        titleLable.sd_layout.leftSpaceToView(bgView,15).topSpaceToView(cartImageView,30+i*30).widthIs(80).heightIs(20);
    }
    
    for (int i=0; i<3; i++) {
        UILabel *contentLable = [UILabel new];
        contentLable.font = UIFontSystem14;
        contentLable.textColor = UIColorBlackTheme;
        contentLable.text = contentArray[i];
        [bgView addSubview:contentLable];
        contentLable.sd_layout.leftSpaceToView(bgView,90).topSpaceToView(cartImageView,31+i*30).rightSpaceToView(bgView,15).heightIs(20);
    }
    /*! 会员特权 */
    NSString *content;
    if ([grade isEqualToString:@"水晶"]){
        content = @"尊享实体水晶卡片\n专属客服通道\n账户周年日好礼\n不定期定向活动\n购买华讯服务享折扣\n";
    }else if ([grade isEqualToString:@"黑钻"]){
        content = @"尊享实体黑钻卡片\n尊享投资策略报告\n俱乐部线下活动机会\n专属客服通道\n账户周年日好礼\n不定期定向活动\n购买华讯服务享折扣\n";
    }else if ([grade isEqualToString:@"黄钻"]){
        content = @"尊享实体黄金卡片\n俱乐部线下活动机会\n专属客服通道\n账户周年日好礼\n不定期定向活动\n购买华讯服务享折扣\n";
    }else{
        content = @"尊享实体黄金卡片\n俱乐部线下活动机会\n专属客服通道\n账户周年日好礼\n不定期定向活动\n购买华讯服务享折扣\n";
    }
    UILabel *privilegeLable = [UILabel new];
    privilegeLable.font = UIFontSystem14;
    privilegeLable.textColor = UIColorBlackTheme;
    privilegeLable.numberOfLines = 0;
    privilegeLable.text = content;
    [bgView addSubview:privilegeLable];
    CGFloat contentStrHight = [content heightWithLabelFont:UIFontSystem14 withLabelWidth:Main_Screen_Width-105];
    if ([grade isEqualToString:@"黑钻"]){
    privilegeLable.sd_layout.leftSpaceToView(bgView,90).topSpaceToView(cartImageView,119).rightSpaceToView(bgView,15).heightIs(contentStrHight+14);
    }else if ([grade isEqualToString:@"黄钻"]){
        privilegeLable.sd_layout.leftSpaceToView(bgView,90).topSpaceToView(cartImageView,119).rightSpaceToView(bgView,15).heightIs(contentStrHight+10);
    }else{
        privilegeLable.sd_layout.leftSpaceToView(bgView,90).topSpaceToView(cartImageView,122).rightSpaceToView(bgView,15).heightIs(contentStrHight);
    }
    bgView.sd_layout.heightIs(300+contentStrHight);
    [self setLabelSpace:privilegeLable withValue:content withFont:UIFontSystem14];
    
}

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    /*! 设置行间距 */
    paraStyle.lineSpacing = 4;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    /*! 设置字间距 NSKernAttributeName:@1.5f */
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}


-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
