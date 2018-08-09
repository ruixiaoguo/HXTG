//
//  HXForgetSecController.m
//  HXTG
//
//  Created by grx on 2017/2/28.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXForgetSecController.h"
#import "ForgetPwsRequestManager.h"
#import "HXCountDownButotn.h"

@interface HXForgetSecController ()<UITextFieldDelegate>{
    ForgetPwsRequestManager *forgetPwsManaget;
    UITextField *forgetTextField;
    UIButton * sureBtn;
}

@end

@implementation HXForgetSecController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorWithRGB(237, 237, 237);
    self.navigationItem.title = @"重置密码";
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    /*! 返回按钮 */
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 12, 20);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"home_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClickBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self createUI];
}


-(void)createUI
{
    NSArray *titleArray = @[@"密码",@"确认密码"];
    NSArray *placeArray = @[@"请输入您的新密码",@"请再次输入密码确认"];
    CGFloat fieldHight = 45;
    for (int i=0; i<2; i++) {
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
        titleLable.textColor = ColorWithRGB(104, 104, 104);
        titleLable.tag = i+10;
        titleLable.text = titleArray[titleLable.tag-10];
        titleLable.sd_layout.leftSpaceToView(bgView,15).topSpaceToView(bgView,6).widthIs(60).heightIs(bgView.frame.size.height-8);
        /*! 输入框 */
        forgetTextField = [UITextField new];
        forgetTextField.backgroundColor = [UIColor whiteColor];
        forgetTextField.tag = i+20;
        forgetTextField.font = UIFontSystem(14);
        forgetTextField.delegate = self;
        forgetTextField.secureTextEntry = YES;

        [bgView addSubview:forgetTextField];
        forgetTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        forgetTextField.sd_layout.leftSpaceToView(titleLable,10).topSpaceToView(bgView,6).rightSpaceToView(bgView,20).heightIs(bgView.frame.size.height-8);
        forgetTextField.placeholder = placeArray[forgetTextField.tag-20];
        [forgetTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [forgetTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

}
    /*! 确定 */
    UIView *lastBgView = (UIView *)[self.view viewWithTag:101];
    sureBtn = [UIButton new];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.backgroundColor = UIColorLineTheme;
    sureBtn.layer.cornerRadius = 5;
    sureBtn.enabled = NO;
    [sureBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [sureBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];

    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    sureBtn.sd_layout.leftSpaceToView(self.view,25).topSpaceToView(lastBgView,160).rightSpaceToView(self.view,25).heightIs(42);

}

-(void)sureBtnClick:(UIButton *)sender
{
    UITextField *pwsName = (UITextField *)[self.view viewWithTag:20];
    UITextField *rePwsfield = (UITextField *)[self.view viewWithTag:21];
    /*! 验证密码(要求数字、字母、字符，至少包含两种,6位以上) */
    if ([UtilityFunction validatePassword:pwsName.text]==NO) {
        HXAlterview *view = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"您的密码需要6位以上字母、数字或标点符号组合，请重新输入" centerButtonTitle:@"我知道了"];
        [view show];
        return;
    }
    
    if (![pwsName.text isEqualToString:rePwsfield.text]) {
        HXAlterview *view = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"您的密码两次输入不一致，请重新输入" centerButtonTitle:@"我知道了"];
        [view show];
        return;
    }
    /*! 忘记密码 */
    forgetPwsManaget = [[ForgetPwsRequestManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [forgetPwsManaget setBlockWithReturnBlock:^(id returnValue) {
        DDLog(@"returnValue======%@",returnValue);
        NSString *states = [NSString stringWithFormat:@"%@",returnValue[@"status"]];
        if ([states isEqualToString:@"1"]) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            [HXLoadingView hide];
        }else{
            HXAlterview *view = [[HXAlterview alloc]initWithTitle:@"提示" contentText:returnValue[@"msg"] centerButtonTitle:@"我知道了"];
            [view show];
            [HXLoadingView hide];
        }
    } WithErrorBlock:^(id errorCode) {
        DDLog(@"errorCode======%@",errorCode);
        [HXLoadingView hide];
    } WithFailureBlock:^{
        DDLog(@"网络异常");
        [HXLoadingView hide];
    }];
    
    NSDictionary *parameter = @{@"mobile":self.mobileStr,@"password":pwsName.text,@"repassword":rePwsfield.text};
    /*! 重置密码 */
    [forgetPwsManaget requestResetPwsInterface:parameter];
    [HXLoadingView show];
}

#pragma mark - 输入框输入结束后焦点
- (void) textFieldDidChange:(id) sender {
    UITextField *mobilefield = (UITextField *)[self.view viewWithTag:20];
    UITextField *codefield = (UITextField *)[self.view viewWithTag:21];
    if (![[mobilefield text] isEqual:@""] && ![[codefield text] isEqual:@""]) {
        [sureBtn setBackgroundColor:UIColorRedTheme];
        sureBtn.enabled=YES;
    }else{
        [sureBtn setBackgroundColor:UIColorLineTheme];
        sureBtn.enabled=NO;
    }
}

#pragma mark - 收回键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (int i=0; i<2; i++) {
        UITextField *registField = (UITextField *)[self.view viewWithTag:i+20];
        [registField resignFirstResponder];
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


-(void)backClickBtn
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
