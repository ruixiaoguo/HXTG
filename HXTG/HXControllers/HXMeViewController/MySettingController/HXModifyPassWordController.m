//
//  HXModifyPassWordController.m
//  HXTG
//
//  Created by grx on 2017/3/31.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXModifyPassWordController.h"
#import "ModifyPwsRequestModel.h"

@interface HXModifyPassWordController ()<UITextFieldDelegate>{
    UITextField *modifyPwsTextField;
    UIButton *submitBtn;
}

@end

@implementation HXModifyPassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.backButton.hidden = NO;
    [self creatModifyUI];
}

#pragma mark - 创建视图
-(void)creatModifyUI
{
    NSArray *titleArray = @[@"旧密码",@"新密码",@"确认密码"];
    NSArray *placeArray = @[@"请输入你的旧密码",@"请输入你的新密码",@"请再次输入密码确认"];
    CGFloat fieldHight = 45;
    for (int i=0; i<3; i++) {
        /*! 背景View */
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        bgView.tag = 100+i;
        bgView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,80+i*(fieldHight+10)).heightIs(fieldHight);
        /*! 标题 */
        UILabel *titleLable = [UILabel new];
        [bgView addSubview:titleLable];
        titleLable.font = UIFontSystem(14);
        titleLable.textColor = UIColorBlackTheme;
        titleLable.tag = i+10;
        titleLable.text = titleArray[titleLable.tag-10];
        titleLable.sd_layout.leftSpaceToView(bgView,15).topSpaceToView(bgView,6).widthIs(60).heightIs(bgView.frame.size.height-8);
        /*! 输入框 */
        modifyPwsTextField = [UITextField new];
        modifyPwsTextField.backgroundColor = [UIColor whiteColor];
        modifyPwsTextField.tag = i+20;
        modifyPwsTextField.font = UIFontSystem(14);
        modifyPwsTextField.delegate = self;
        [bgView addSubview:modifyPwsTextField];
        [modifyPwsTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        modifyPwsTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        modifyPwsTextField.sd_layout.leftSpaceToView(titleLable,5).topSpaceToView(bgView,6).rightSpaceToView(bgView,20).heightIs(bgView.frame.size.height-8);
        modifyPwsTextField.placeholder = placeArray[modifyPwsTextField.tag-20];
        [modifyPwsTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        modifyPwsTextField.secureTextEntry = YES;
    }
    
    /*! 描述 */
    UIImageView *tishiImage = [UIImageView new];
    tishiImage.image = [UIImage imageNamed:@"tishi"];
    [self.view addSubview:tishiImage];
    tishiImage.sd_layout.leftSpaceToView(self.view,17).topSpaceToView(self.view,250).widthIs(15).heightIs(15);
    UILabel *discritLable = [UILabel new];
    [self.view addSubview:discritLable];
    discritLable.font = UIFontSystem(11);
    discritLable.textColor = ColorWithHexRGB(0xef3540);
    discritLable.text = @"密码要求数字、字母、字符，至少包含两种,且长度在6位以上\n";
    discritLable.lineBreakMode = 1;
    discritLable.numberOfLines = 0;
    discritLable.sd_layout.leftSpaceToView(tishiImage,5).topEqualToView(tishiImage).rightSpaceToView(self.view,15).heightIs(28);

    
    /*! 提交申请 */
    submitBtn = [UIButton new];
    [submitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = UIColorLineTheme;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.enabled = NO;
    [submitBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [submitBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    UIView *lastBgView = (UIView *)[self.view viewWithTag:102];
    submitBtn.sd_layout.leftSpaceToView(self.view,25).topSpaceToView(lastBgView,80).rightSpaceToView(self.view,25).heightIs(45);
}

#pragma mark - 输入框输入结束后焦点
- (void) textFieldDidChange:(id) sender {
    UITextField *userfield = (UITextField *)[self.view viewWithTag:20];
    UITextField *pswfield = (UITextField *)[self.view viewWithTag:21];
    UITextField *rePswfield = (UITextField *)[self.view viewWithTag:22];
    if (![[userfield text] isEqual:@""] && ![[pswfield text] isEqual:@""] && ![[rePswfield text] isEqual:@""]) {
        [submitBtn setBackgroundColor:UIColorRedTheme];
        submitBtn.enabled=YES;
    }else{
        [submitBtn setBackgroundColor:UIColorLineTheme];
        submitBtn.enabled=NO;
    }
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


#pragma mark - 提交申请网络请求
-(void)submitBtnClick:(UIButton *)sender
{
    UITextField *pswfield = (UITextField *)[self.view viewWithTag:21];
    UITextField *rePswfield = (UITextField *)[self.view viewWithTag:22];
    /*! 验证密码(要求数字、字母、字符，至少包含两种,6位以上) */
    if ([UtilityFunction validatePassword:pswfield.text]==NO) {
        [HXProgressHUD showMessage:self.view labelText:@"密码格式不对请重新输入" mode:MBProgressHUDModeText];
        return;
    }
    if (![pswfield.text isEqualToString:rePswfield.text]) {
        [HXProgressHUD showMessage:self.view labelText:@"密码两次输入不一致请重新输入" mode:MBProgressHUDModeText];
        return;
    }
    [self gaintUpdatepass];
}

#pragma mark - 修改密码网络请求
-(void)gaintUpdatepass
{
    UITextField *userfield = (UITextField *)[self.view viewWithTag:20];
    UITextField *pswfield = (UITextField *)[self.view viewWithTag:21];
    UITextField *rePswfield = (UITextField *)[self.view viewWithTag:22];

    [HXLoadingView show];
    ModifyPwsRequestModel *model = [[ModifyPwsRequestModel alloc]init];
    model.username = USERNAME;
    model.oldpass = userfield.text;
    model.password = pswfield.text;
    model.repassword = rePswfield.text;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/updatepass" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [self.navigationController popViewControllerAnimated:YES];
            [HXLoadingView hide];
        }else{
            [HXProgressHUD showMessage:self.view
                             labelText:responseDict[@"msg"]
                                  mode:MBProgressHUDModeText];
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
    for (int i=0; i<3; i++) {
        UITextField *loginfield = (UITextField *)[self.view viewWithTag:i+20];
        [loginfield resignFirstResponder];
    }
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
