//
//  HXModiBindTelController.m
//  HXTG
//
//  Created by grx on 2017/4/5.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXModiBindTelController.h"
#import "HXBindIDCartController.h"

@interface HXModiBindTelController ()

@end

@implementation HXModiBindTelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改绑定手机号码";
    self.backButton.hidden = NO;
    /*! 背景View */
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    bgView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,75).heightIs(44);
    /*! 手势 */
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgBtnClickTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [bgView addGestureRecognizer:singleRecognizer];
    /*! 标题 */
    UILabel *titleLable = [UILabel new];
    [bgView addSubview:titleLable];
    titleLable.font = UIFontSystem(14);
    titleLable.textColor = UIColorBlackTheme;
    titleLable.text = @"原手机号能接受验证码";
    titleLable.sd_layout.leftSpaceToView(bgView,18).topSpaceToView(bgView,2).widthIs(150).heightIs(bgView.frame.size.height);
    /*! 箭头 */
    UIImageView *tipImage = [UIImageView new];
    tipImage.image = [UIImage imageNamed:@"arrow"];
    [bgView addSubview:tipImage];
    tipImage.sd_layout.rightSpaceToView(bgView,15).centerYEqualToView(bgView).widthIs(8).heightIs(15);
    
    /*! 描述 */
    UIImageView *tishiImage = [UIImageView new];
    tishiImage.image = [UIImage imageNamed:@"tishi"];
    [self.view addSubview:tishiImage];
    tishiImage.sd_layout.leftSpaceToView(self.view,17).topSpaceToView(bgView,15).widthIs(15).heightIs(15);
    UILabel *discritLable = [UILabel new];
    [self.view addSubview:discritLable];
    discritLable.font = UIFontSystem(11);
    discritLable.textColor = ColorWithHexRGB(0xef3540);
    discritLable.text = @"如无法进行自助修改手机号码,请拨打人工客服400-098-7966，由客服协助您修改!";
    discritLable.text = [discritLable.text stringByAppendingString:@"\n "];
    discritLable.lineBreakMode = 1;
    discritLable.numberOfLines = 0;
    discritLable.sd_layout.leftSpaceToView(tishiImage,5).topSpaceToView(bgView,15).rightSpaceToView(self.view,15).heightIs(40);
}

-(void)bgBtnClickTap:(UITapGestureRecognizer *)recognizer
{
    HXBindIDCartController *bindVC = [[HXBindIDCartController alloc]init];
    [self.navigationController pushViewController:bindVC animated:YES];
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
