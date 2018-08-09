//
//  HXRelatCartController.m
//  HXTG
//
//  Created by grx on 2017/3/31.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXRelatCartController.h"
#import "BindCartRequestModel.h"

@interface HXRelatCartController (){
    UITextField *cartField;
}

@end

@implementation HXRelatCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关联会员卡";
    self.backButton.hidden = NO;
    self.view.backgroundColor = UIColorBgLightTheme;
    [self markView];
}

-(void)markView
{
    /*! 卡号 */
    UIView *bgFieldView = [UIView new];
    bgFieldView.backgroundColor = UIColorWhite;
    [self.view addSubview:bgFieldView];
    bgFieldView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,navBarHeight+20).heightIs(44);
    /*! 标题 */
    cartField = [UITextField new];
    cartField.textColor = UIColorBlackTheme;
    cartField.font = UIFontSystem14;
    cartField.placeholder = @"请输入卡号*";
    cartField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgFieldView addSubview:cartField];
    cartField.sd_layout.leftSpaceToView(bgFieldView,15).topSpaceToView(bgFieldView,0).rightSpaceToView(bgFieldView,15).heightIs(44);
    /*! 立即关联 */
    UIButton *relatCartBtn = [UIButton new];
    [relatCartBtn setTitle:@"立即关联" forState:UIControlStateNormal];
    relatCartBtn.titleLabel.font = UIFontSystem16;
    [relatCartBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    relatCartBtn.backgroundColor = UIColorRedTheme;
    relatCartBtn.layer.cornerRadius = 5;
    [relatCartBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [relatCartBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:relatCartBtn];
    [relatCartBtn addTarget:self action:@selector(relatCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    relatCartBtn.sd_layout.leftSpaceToView(self.view,30).rightSpaceToView(self.view,30).topSpaceToView(bgFieldView,100).heightIs(40);
    /*! 会员卡 */
    UIImageView *cartImageView = [UIImageView new];
    cartImageView.image = [UIImage imageNamed:@"heizuanka"];
    [self.view addSubview:cartImageView];
    cartImageView.sd_layout.centerXEqualToView(self.view).topSpaceToView(relatCartBtn,60).widthIs(187).heightIs(120);
    /*! 文字说明 */
    UILabel *discriLable = [UILabel new];
    discriLable.font = UIFontSystem12;
    discriLable.textColor = UIColorBlackTheme;
    discriLable.textAlignment = NSTextAlignmentCenter;
    discriLable.text = @"会员卡样式，仅供参考";
    [self.view addSubview:discriLable];
    discriLable.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(cartImageView,0).heightIs(30);
}

#pragma mark - 立即关联会员卡
-(void)relatCartBtnClick:(UIButton *)sender
{
    DDLog(@"立即联会员卡=========");
    if (cartField.text.length==0) {
        [HXProgressHUD showMessage:self.view labelText:@"会员卡号不能为空" mode:MBProgressHUDModeText];
        return;
    }
    [self gaintMemberBindUser];
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

#pragma mark - 关联会员信息网络请求
-(void)gaintMemberBindUser
{
    [HXLoadingView show];
    BindCartRequestModel *model = [[BindCartRequestModel alloc]init];
    model.user_login = USERNAME;
    model.cardno = cartField.text;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"member/MemberBindUser" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [HXProgressHUD showMessage:self.view labelText:responseDict[@"msg"] mode:MBProgressHUDModeText];
            [HXLoadingView hide];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [HXProgressHUD showMessage:self.view labelText:responseDict[@"msg"] mode:MBProgressHUDModeText];
            [HXLoadingView hide];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];
}

#pragma mark - 收回键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [cartField resignFirstResponder];
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
