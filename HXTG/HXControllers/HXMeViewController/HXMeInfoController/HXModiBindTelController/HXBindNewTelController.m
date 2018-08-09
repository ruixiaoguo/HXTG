//
//  HXBindNewTelController.m
//  HXTG
//
//  Created by grx on 2017/4/5.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBindNewTelController.h"
#import "HXCountDownButotn.h"
#import "RegistRequestModel.h"
#import "RegistRequestManager.h"
#import "UserInfoModel.h"
#import "HXNavigationBar.h"
#import "HXMeInfoController.h"

@interface HXBindNewTelController ()<UITextFieldDelegate>{
    RegistRequestManager *registmanager;
    UITextField *bindTextField;
    UIButton *bindBtn;
}

@end

@implementation HXBindNewTelController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.isPush isEqualToString:@"yes"]) {
        self.title = @"绑定新号码";
        self.backButton.hidden = NO;
    }else{
        /*! 自定义导航 */
        HXNavigationBar *navBar =[[HXNavigationBar alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, VIEW_OFFSET+kNavigationBarHeight)];
        [navBar setBarTintColor:ColorWithRGB(234, 57, 69)];
        [self.view addSubview:navBar];
        
        /*! 登录 */
        UILabel *loginLable=[UILabel new];
        [loginLable setText:@"绑定新手机号"];
        loginLable.font=[UIFont systemFontOfSize:17];
        loginLable.textAlignment=NSTextAlignmentCenter;
        loginLable.textColor=[UIColor whiteColor];
        [navBar addSubview:loginLable];
        loginLable.sd_layout.leftSpaceToView(navBar,20).rightSpaceToView(navBar,20).topSpaceToView(navBar,NAV_OFFSET).heightIs(45);
        /*! 返回 */
        UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        backBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [backBtn addTarget:self action:@selector(backClickBtn1) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *bgView=[[UIImageView alloc]initWithFrame:CGRectMake(16, 13, 12, 20)];
        bgView.image=[UIImage imageNamed:@"home_back"];
        [backBtn addSubview:bgView];
        [navBar addSubview:backBtn];
        backBtn.sd_layout.leftSpaceToView(navBar,0).topSpaceToView(navBar,NAV_OFFSET).heightIs(40).widthIs(100);

    }
    
    [self creatBindUI];
}

#pragma mark - 创建视图
-(void)creatBindUI
{
    NSArray *titleArray = @[@"手机号",@"验证码"];
    NSArray *placeArray = @[@"请输入新手机号码",@"短信中6位数字"];
    CGFloat fieldHight = 44;
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
        titleLable.sd_layout.leftSpaceToView(bgView,15).topSpaceToView(bgView,2).widthIs(50).heightIs(bgView.frame.size.height);
        /*! 输入框 */
        bindTextField = [UITextField new];
        bindTextField.backgroundColor = [UIColor whiteColor];
        bindTextField.tag = i+20;
        bindTextField.font = UIFontSystem(14);
        bindTextField.delegate = self;
        [bgView addSubview:bindTextField];
        bindTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        bindTextField.sd_layout.leftSpaceToView(titleLable,5).topSpaceToView(bgView,6).rightSpaceToView(bgView,20).heightIs(bgView.frame.size.height-8);
        bindTextField.placeholder = placeArray[bindTextField.tag-20];
        [bindTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [bindTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        /*! 验证码 */
        if (bgView.tag == 101) {
            /*! 分割线 */
            UIView *lineView = [UIView new];
            [bgView addSubview:lineView];
            lineView.backgroundColor = ColorWithRGB(231, 231, 232);
            lineView.sd_layout.rightSpaceToView(bgView,90).topSpaceToView(bgView,8).widthIs(1).heightIs(fieldHight-16);
            bindTextField.sd_layout.leftSpaceToView(titleLable,5).topSpaceToView(bgView,6).rightSpaceToView(bgView,90).heightIs(bgView.frame.size.height-8);
            /*! SNS验证 */
            [self senderSNS:bgView];
        }
    }
    /*! 确定 */
    UIView *lastBgView = (UIView *)[self.view viewWithTag:101];
    bindBtn = [UIButton new];
    [bindBtn setTitle:@"确定" forState:UIControlStateNormal];
    bindBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bindBtn.backgroundColor = ColorWithRGB(201, 202, 203);
    bindBtn.layer.cornerRadius = 5;
    bindBtn.enabled = NO;
    [bindBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [bindBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    
    [bindBtn addTarget:self action:@selector(registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bindBtn];
    bindBtn.sd_layout.leftSpaceToView(self.view,25).topSpaceToView(lastBgView,160).rightSpaceToView(self.view,25).heightIs(42);
    
}

#pragma mark - 获取验证码
-(void)senderSNS:(UIView *)superView
{
    UITextField *mobileField = (UITextField *)[self.view viewWithTag:20];
    HXCountDownButotn *button = [HXCountDownButotn buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:ColorWithRGB(41, 142, 251) forState:UIControlStateNormal];
    [superView addSubview:button];
    button.sd_layout.rightSpaceToView(superView,0).topSpaceToView(superView,0).heightIs(42).widthIs(89);
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
            /*! 发送验证码 */
            [self sendSNSInterface:sender MobileField:mobileField];
            [HXLoadingView hide];
        }else{
            [HXLoadingView hide];
            [HXProgressHUD showMessage:self.view
                             labelText:responseDict[@"msg"]
                                  mode:MBProgressHUDModeText];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];
}

-(void)sendSNSInterface:(HXCountDownButotn *)sender MobileField:(UITextField *)mobileField
{
    /*! 发送短信验证码 */
    registmanager = [[RegistRequestManager alloc] init];
    WeakSelf(weakSelf);
    [registmanager setBlockWithReturnBlock:^(id returnValue) {
        DDLog(@"returnValue======%@",returnValue);
        NSString *states = [NSString stringWithFormat:@"%@",returnValue[@"status"]];
        if ([states isEqualToString:@"1"]) {
            
            sender.enabled = NO;
            [sender startWithSecond:60.0];
            [HXLoadingView hide];
        }else{
            [HXProgressHUD showMessage:weakSelf.view
                             labelText:returnValue[@"msg"]
                                  mode:MBProgressHUDModeText];
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


#pragma mark - 绑定新手机号事件
-(void)registBtnClick:(UIButton *)sender
{
    UITextField *codeField = (UITextField *)[self.view viewWithTag:21];
    /*! 验证短信验证码 */
    registmanager = [[RegistRequestManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [registmanager setBlockWithReturnBlock:^(id returnValue) {
        DDLog(@"returnValue======%@",returnValue);
        NSString *states = [NSString stringWithFormat:@"%@",returnValue[@"status"]];
        if ([states isEqualToString:@"1"]) {
            [weakSelf requestBindInterface];
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


#pragma mark - 开始绑定新手机号
-(void)requestBindInterface
{
    UITextField *mobileField = (UITextField *)[self.view viewWithTag:20];
    UITextField *codeField = (UITextField *)[self.view viewWithTag:21];
    RegistRequestModel *model = [[RegistRequestModel alloc]init];
    model.mobile = mobileField.text;
    model.code = codeField.text;
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/updateUserinfo" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [StandardUserDefaults  setObject:mobileField.text forKey:@"user_phone"];
            /*! 更新本地缓存 */
            NSString *infoPath = [GlobalFile directoryPathWithFileName:USERINFO_KEY];
            UserInfoModel *infoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:infoPath];
            infoModel.mobile=mobileField.text;
            [NSKeyedArchiver archiveRootObject:infoModel toFile:infoPath];
            [HXLoadingView hide];
            if ([self.isPush isEqualToString:@"yes"]) {
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[HXMeInfoController class]]) {
                        HXMeInfoController *infoVC =(HXMeInfoController *)controller;
                        [self.navigationController popToViewController:infoVC animated:YES];
                    }
                }
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        }else{
            [HXLoadingView hide];
            [HXProgressHUD showMessage:self.view
                             labelText:responseDict[@"msg"]
                                  mode:MBProgressHUDModeText];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];

}

#pragma mark - 输入框输入结束后焦点
- (void) textFieldDidChange:(id) sender {
    UITextField *mobilefield = (UITextField *)[self.view viewWithTag:20];
    UITextField *codefield = (UITextField *)[self.view viewWithTag:21];
    if (![[mobilefield text] isEqual:@""] && ![[codefield text] isEqual:@""]) {
        [bindBtn setBackgroundColor:UIColorRedTheme];
        bindBtn.enabled=YES;
    }else{
        [bindBtn setBackgroundColor:UIColorLineTheme];
        bindBtn.enabled=NO;
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


-(void)backClickBtn1
{
    NSString *telPhone = [NSString stringWithFormat:@"%@",USERPHONE];
    if (telPhone.length==0) {
        [HXProgressHUD showMessage:self.view labelText:@"请先绑定手机号" mode:MBProgressHUDModeText];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
