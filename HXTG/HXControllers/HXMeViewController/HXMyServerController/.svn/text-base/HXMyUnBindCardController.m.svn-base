//
//  HXMyMemberCardController.m
//  HXTG
//
//  Created by grx on 2017/3/31.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMyUnBindCardController.h"
#import "HXRelatCartController.h"
#import "HXApplyCartController.h"
#import "RequestAreaAlnit.h"
@interface HXMyUnBindCardController (){
    UILabel *contentLable;
}

@end

@implementation HXMyUnBindCardController


- (void)viewDidLoad {
    [super viewDidLoad];
    /*! 获取所在地 */
    [[RequestAreaAlnit shareInstance]getAreaAlnit];
    self.title = @"会员中心";
    self.backButton.hidden = NO;
    self.view.backgroundColor = UIColorWhite;
    [self markView];
}

#pragma mark - 创建视图
-(void)markView
{
    /*! 背景图 */
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = [UIImage imageNamed:@"banner_cart"];
    [self.view addSubview:bgImageView];
    bgImageView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,64).heightIs(Main_Screen_Height*0.22);
    /*! 描述 */
    contentLable = [UILabel new];
    contentLable.font = UIFontSystem14;
    contentLable.textColor = UIColorBlackTheme;
    contentLable.numberOfLines = 0;
    [self.view addSubview:contentLable];
    contentLable.sd_layout.leftSpaceToView(self.view,15).topSpaceToView(bgImageView,0).rightSpaceToView(self.view,15).heightIs(130);
    NSString *textStr = @"财道俱乐部是华讯投资高端客户的专属社区，财道俱乐部会员限量招募，成为会员即享华讯投资提供的专享尊贵服务。财道俱乐部会员消费累积星星，可升级会员等级，等级越高，特权越多。";
    [self setLabelSpace:contentLable withValue:textStr withFont:UIFontSystem14];
    /*! 申请会员卡 */
    UIButton *applyCartBtn = [UIButton new];
    [applyCartBtn setTitle:@"申请会员卡" forState:UIControlStateNormal];
    applyCartBtn.titleLabel.font = UIFontSystem16;
    [applyCartBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    applyCartBtn.backgroundColor = UIColorRedTheme;
    applyCartBtn.layer.cornerRadius = 5;
    [applyCartBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [applyCartBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:applyCartBtn];
    [applyCartBtn addTarget:self action:@selector(applyCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    applyCartBtn.sd_layout.leftSpaceToView(self.view,30).rightSpaceToView(self.view,30).topSpaceToView(contentLable,40).heightIs(40);
    /*! 关联会员卡 */
    UIButton *relatCartBtn = [UIButton new];
    [relatCartBtn setTitle:@"关联会员卡" forState:UIControlStateNormal];
    relatCartBtn.titleLabel.font = UIFontSystem16;
    [relatCartBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    relatCartBtn.backgroundColor = UIColorBlueTheme;
    relatCartBtn.layer.cornerRadius = 5;
    [self.view addSubview:relatCartBtn];
    [relatCartBtn addTarget:self action:@selector(relatCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    relatCartBtn.sd_layout.leftSpaceToView(self.view,30).rightSpaceToView(self.view,30).topSpaceToView(applyCartBtn,30).heightIs(40);
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
    /*! 行首缩进 */
    paraStyle.headIndent = 0.0f;
    CGFloat emptylen = contentLable.font.pointSize * 2;
    paraStyle.firstLineHeadIndent = emptylen;
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

#pragma mark - 申请会员卡
-(void)applyCartBtnClick:(UIButton *)sender
{
    DDLog(@"申请会员卡=========");
    HXApplyCartController *applyVC = [[HXApplyCartController alloc]init];
    [self.navigationController pushViewController:applyVC animated:YES];
}

#pragma mark - 关联会员卡
-(void)relatCartBtnClick:(UIButton *)sender
{
    DDLog(@"关联会员卡=========");
    HXRelatCartController *relatVC = [[HXRelatCartController alloc]init];
    [self.navigationController pushViewController:relatVC animated:YES];
}

#pragma mark - 按钮高亮背景色设置
- (void)backGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = UIColorHigRedTheme;
}

-(void)backGroundNormal:(UIButton *)sender
{
    sender.backgroundColor = UIColorRedTheme;
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
