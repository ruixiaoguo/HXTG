//
//  HXForgetPswController.m
//  HXTG
//
//  Created by grx on 2017/2/27.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXForgetPswController.h"
#import "HXForgetSecController.h"
#import "RegistRequestManager.h"
#import "HXCountDownButotn.h"
#import "RegistRequestModel.h"

@interface HXForgetPswController ()<UITextFieldDelegate>{
    RegistRequestManager *registmanager;
    UITextField *forgetTextField;
    UIButton * nextBtn;
}

@end

@implementation HXForgetPswController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorWithRGB(236, 237, 238);
    self.navigationItem.title = @"重置密码";
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self.navigationController.navigationBar setBarTintColor: ColorWithRGB(234, 57, 69)];
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

    NSArray *titleArray = @[@"中国+86",@"验证码"];
    NSArray *placeArray = @[@"注册时的手机号码",@"请输入短信验证码"];
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
        [bgView addSubview:forgetTextField];
        forgetTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        forgetTextField.sd_layout.leftSpaceToView(titleLable,15).topSpaceToView(bgView,6).rightSpaceToView(bgView,20).heightIs(bgView.frame.size.height-8);
        forgetTextField.placeholder = placeArray[forgetTextField.tag-20];
        [forgetTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [forgetTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        if (forgetTextField.tag == 21) {
            forgetTextField.sd_layout.leftSpaceToView(titleLable,15).topSpaceToView(bgView,6).rightSpaceToView(bgView,100).heightIs(bgView.frame.size.height-8);
        }
        if (bgView.tag == 100) {
            /*! 分割线 */
            UIView *lineView = [UIView new];
            [bgView addSubview:lineView];
            lineView.backgroundColor = ColorWithRGB(231, 231, 232);
            lineView.sd_layout.leftSpaceToView(bgView,80).topSpaceToView(bgView,9).widthIs(1).heightIs(fieldHight-18);

        }else if (bgView.tag == 101) {
            /*! 分割线 */
            UIView *lineView = [UIView new];
            [bgView addSubview:lineView];
            lineView.backgroundColor = UIColorLineTheme;
            lineView.sd_layout.rightSpaceToView(bgView,90).topSpaceToView(bgView,9).widthIs(1).heightIs(fieldHight-18);
            /*! SNS验证 */
            [self senderSNS:bgView];
        }
    }
    /*! 下一步 */
    UIView *lastBgView = (UIView *)[self.view viewWithTag:101];
    nextBtn = [UIButton new];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.backgroundColor = UIColorLineTheme;
    nextBtn.layer.cornerRadius = 5;
    nextBtn.enabled = NO;
    [nextBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [nextBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];

    [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    nextBtn.sd_layout.leftSpaceToView(self.view,25).topSpaceToView(lastBgView,160).rightSpaceToView(self.view,25).heightIs(45);
}

-(void)nextBtnClick:(UIButton *)sender
{
    UITextField *codeField = (UITextField *)[self.view viewWithTag:21];
    /*! 验证短信验证码 */
    registmanager = [[RegistRequestManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [registmanager setBlockWithReturnBlock:^(id returnValue) {
        DDLog(@"returnValue======%@",returnValue);
        NSString *states = [NSString stringWithFormat:@"%@",returnValue[@"status"]];
        if ([states isEqualToString:@"1"]) {
            [HXLoadingView hide];
            UITextField *mobileField = (UITextField *)[weakSelf.view viewWithTag:20];
            HXForgetSecController *secVC = [[HXForgetSecController alloc]init];
            secVC.mobileStr = mobileField.text;
            [weakSelf.navigationController pushViewController:secVC animated:YES];
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
    NSDictionary *parameter = @{@"code": codeField.text};
    /*! 验证短信验证码 */
    [registmanager requestCheckSNSInterface:parameter];
    [HXLoadingView show];
}

-(void)senderSNS:(UIView *)superView
{
    UITextField *mobileField = (UITextField *)[self.view viewWithTag:20];
    HXCountDownButotn *button = [HXCountDownButotn buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:ColorWithRGB(41, 142, 251) forState:UIControlStateNormal];
    [superView addSubview:button];
    button.sd_layout.rightSpaceToView(superView,0).topSpaceToView(superView,0).heightIs(45).widthIs(89);
    [button addToucheHandler:^(HXCountDownButotn*sender, NSInteger tag) {
        /*! 验证手机号 */
        if ([UtilityFunction isMobileNumber:mobileField.text]==NO) {
            
            [HXProgressHUD showMessage:self.view labelText:@"请输入正确手机号" mode:MBProgressHUDModeText];

            return;
        }
        /*! 验证手机号是否存在 */
        [self checkMobileRegister:sender MobileField:mobileField];
    }];
}

#pragma mark - 验证手机号是否存在
-(void)checkMobileRegister:(HXCountDownButotn *)sender MobileField:(UITextField *)mobileField
{
    
    RegistRequestModel *model = [[RegistRequestModel alloc]init];
    model.mobile = mobileField.text;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/checkMobileRegister" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        [HXLoadingView show];
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [HXLoadingView hide];
            [HXProgressHUD showMessage:self.view labelText:responseDict[@"msg"] mode:MBProgressHUDModeText];
        }else{
            [HXLoadingView hide];
            /*! 发送验证码 */
            [self sendSNSInterface:sender MobileField:mobileField];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];
}

-(void)sendSNSInterface:(HXCountDownButotn *)sender MobileField:(UITextField *)mobileField
{
    WeakSelf(weakSelf);
    /*! 发送短信验证码 */
    registmanager = [[RegistRequestManager alloc] init];
    [registmanager setBlockWithReturnBlock:^(id returnValue) {
        DDLog(@"returnValue======%@",returnValue);
        NSString *states = [NSString stringWithFormat:@"%@",returnValue[@"status"]];
        if ([states isEqualToString:@"1"]) {
            
            sender.enabled = NO;
            [sender startWithSecond:60.0];
            [HXLoadingView hide];
        }else{
            [HXProgressHUD showMessage:weakSelf.view labelText:returnValue[@"msg"] mode:MBProgressHUDModeText];
            [HXLoadingView hide];
        }
    } WithErrorBlock:^(id errorCode) {
        [HXLoadingView hide];
        [HXProgressHUD showMessage:weakSelf.view labelText:@"发送失败" mode:MBProgressHUDModeText];
    } WithFailureBlock:^{
        DDLog(@"网络异常");
        [HXLoadingView hide];
    }];
    
    NSDictionary *parameter = @{@"mobile": mobileField.text,@"type":@"2"};
    /*! 发送短信验证码 */
    [registmanager requestSendSNSInterface:parameter];
    [HXLoadingView show];
    [sender didChange:^NSString *(HXCountDownButotn *countDownButton,int second) {
        [sender setTitleColor:ColorWithRGB(178,178,178) forState:UIControlStateNormal];
        NSString *title = [NSString stringWithFormat:@"倒计时%ds",second];
        return title;
    }];
    [sender didFinished:^NSString *(HXCountDownButotn *countDownButton, int second) {
        [sender setTitleColor:ColorWithRGB(41, 142, 251) forState:UIControlStateNormal];
        countDownButton.enabled = YES;
        return @"重新获取";
        
    }];
    
}


#pragma mark - 输入框输入结束后焦点
- (void) textFieldDidChange:(id) sender {
    UITextField *mobilefield = (UITextField *)[self.view viewWithTag:20];
    UITextField *codefield = (UITextField *)[self.view viewWithTag:21];
    if (![[mobilefield text] isEqual:@""] && ![[codefield text] isEqual:@""]) {
        [nextBtn setBackgroundColor:UIColorRedTheme];
        nextBtn.enabled=YES;
    }else{
        [nextBtn setBackgroundColor:UIColorLineTheme];
        nextBtn.enabled=NO;
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
