//
//  HXRegistNextController.m
//  HXTG
//
//  Created by grx on 2017/2/28.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXRegistNextController.h"
#import "HXCountDownButotn.h"
#import "RegistRequestManager.h"
#import "HXAlterview.h"
#import <RongIMKit/RongIMKit.h>
#import "RegistRequestModel.h"
#import "UserInfoRequestModel.h"
#import "UserInfoModel.h"
#import "JPUSHService.h"
#import "RYTokenRequestModel.h"
#import "UMMobClick/MobClick.h"

@interface HXRegistNextController ()<UITextFieldDelegate>{
    UITextField *registTextField;
    RegistRequestManager *registmanager;
    UIButton *registBtn;
}

@end

@implementation HXRegistNextController

-(instancetype)initWithUserName:(NSString *)userName userPws:(NSString *)passWord Invitation:(NSString *)invitation
{
    if (self = [super init]) {
        self.userName = userName;
        self.userPws = passWord;
        self.invitation = invitation;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorWithRGB(236, 237, 238);
    self.navigationItem.title = @"注册华讯通行证";
    
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
    [self creatRegistUI];
}


#pragma mark - 创建视图
-(void)creatRegistUI
{
    NSArray *titleArray = @[@"手机号",@"验证码"];
    NSArray *placeArray = @[@"请输入手机号码",@"短信中6位数字"];
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
        titleLable.sd_layout.leftSpaceToView(bgView,15).topSpaceToView(bgView,6).widthIs(50).heightIs(bgView.frame.size.height-8);
        /*! 输入框 */
        registTextField = [UITextField new];
        registTextField.backgroundColor = [UIColor whiteColor];
        registTextField.tag = i+20;
        registTextField.font = UIFontSystem(14);
        registTextField.delegate = self;
        registTextField.keyboardType = UIKeyboardTypeNumberPad;
        [bgView addSubview:registTextField];
        registTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        registTextField.sd_layout.leftSpaceToView(titleLable,5).topSpaceToView(bgView,6).rightSpaceToView(bgView,20).heightIs(bgView.frame.size.height-8);
        registTextField.placeholder = placeArray[registTextField.tag-20];
        [registTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [registTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        /*! 验证码 */
        if (bgView.tag == 101) {
            /*! 分割线 */
            UIView *lineView = [UIView new];
            [bgView addSubview:lineView];
            lineView.backgroundColor = ColorWithRGB(231, 231, 232);
            lineView.sd_layout.rightSpaceToView(bgView,90).topSpaceToView(bgView,8).widthIs(1).heightIs(fieldHight-16);
            registTextField.sd_layout.leftSpaceToView(titleLable,5).topSpaceToView(bgView,6).rightSpaceToView(bgView,90).heightIs(bgView.frame.size.height-8);
            /*! SNS验证 */
            [self senderSNS:bgView];
        }
    }
    /*! 注册 */
    UIView *lastBgView = (UIView *)[self.view viewWithTag:101];
    registBtn = [UIButton new];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registBtn.backgroundColor = ColorWithRGB(201, 202, 203);
    registBtn.layer.cornerRadius = 5;
    registBtn.enabled = NO;
    [registBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [registBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];

    [registBtn addTarget:self action:@selector(registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    registBtn.sd_layout.leftSpaceToView(self.view,25).topSpaceToView(lastBgView,160).rightSpaceToView(self.view,25).heightIs(45);
    
}

#pragma mark - 注册事件
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
            [weakSelf requestRegistInterface];
        }else{
            [HXProgressHUD showMessage:weakSelf.view labelText:returnValue[@"msg"] mode:MBProgressHUDModeText];
        }
    } WithErrorBlock:^(id errorCode) {
        DDLog(@"errorCode======%@",errorCode);
        
    } WithFailureBlock:^{
        DDLog(@"网络异常");
        [[HXNetBoxView getInstance]showTitle:weakSelf.view withTitle:@"网络开小差了,请检查网络状况!!"];
    }];
    NSDictionary *parameter = @{@"code": codeField.text};
    /*! 验证短信验证码 */
    [registmanager requestCheckSNSInterface:parameter];

}


#pragma mark - 开始注册新用户
-(void)requestRegistInterface
{
        __weak typeof(self) weakSelf = self;
    UITextField *mobileField = (UITextField *)[self.view viewWithTag:20];
    UITextField *codeField = (UITextField *)[self.view viewWithTag:21];
        /*! 注册新用户 */
        registmanager = [[RegistRequestManager alloc] init];
        [registmanager setBlockWithReturnBlock:^(id returnValue) {
            NSString *states = [NSString stringWithFormat:@"%@",returnValue[@"status"]];
        
            if ([states isEqualToString:@"1"]) {
                NSString *business_id = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"business_id"]];
                NSString *userName = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"user_login"]];
                NSString *userId = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"id"]];
                NSString *userPhone = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"mobile"]];
                NSString *sign = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"sign"]];
                
                [StandardUserDefaults  setBool:YES forKey:ISLOGIN];
                [StandardUserDefaults  setObject:userName forKey:@"user_name"];
                [StandardUserDefaults  setObject:business_id forKey:@"business_id"];
                [StandardUserDefaults  setObject:sign forKey:@"sign"];
            
                [StandardUserDefaults  setObject:userId forKey:@"user_Id"];
                [StandardUserDefaults  setObject:userPhone forKey:@"user_phone"];
                [StandardUserDefaults  setBool:NO forKey:@"isShowPic"];
                /*! 用于绑定极光Alias */
                [JPUSHService setAlias:userName callbackSelector:nil object:weakSelf];
                /*! 保存用户信息 */
                [weakSelf gaintUserInfomation];
                
            }else{
                
                [HXProgressHUD showMessage:weakSelf.view labelText:returnValue[@"msg"] mode:MBProgressHUDModeText];
                [HXLoadingView hide];
            }
        } WithErrorBlock:^(id errorCode) {
            DDLog(@"errorCode======%@",errorCode);
            [HXProgressHUD showMessage:weakSelf.view labelText:@"服务器异常" mode:MBProgressHUDModeText];
            [HXLoadingView hide];
        } WithFailureBlock:^{
            DDLog(@"网络异常");
            [HXLoadingView hide];
        }];
    
        NSDictionary *parameter = @{@"user_login": self.userName,@"user_pass":self.userPws,@"user_repass":self.userPws,@"mobile":mobileField.text,@"code":codeField.text,@"invitation":self.invitation};
        DDLog(@"parameter======%@",parameter);
        /*! 注册新用户 */
        [registmanager requestRigistInterface:parameter];
        [HXLoadingView show];
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
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            /*! 发送验证码 */
            [self sendSNSInterface:sender MobileField:mobileField];
        }else{
            HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:responseDict[@"msg"] rightButtonTitle:@"登录" leftButtonTitle:@"返回"];
            [alter show];
            alter.rightBlock=^()
            {
                /*! 登录 */
                [self.navigationController popToRootViewControllerAnimated:YES];
            };
            alter.leftBlock=^()
            {
                
            };
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
    } WithFailureBlock:^{
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
            [HXProgressHUD showMessage:weakSelf.view labelText:@"验证码已发送至您的手机" mode:MBProgressHUDModeText];
            sender.enabled = NO;
            [sender startWithSecond:60.0];
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
    
    NSDictionary *parameter = @{@"mobile": mobileField.text,@"type":@"1"};
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

#pragma mark - 获取保存用户信息
-(void)gaintUserInfomation
{
    UserInfoRequestModel *model = [[UserInfoRequestModel alloc]init];
    model.user_login = USERNAME;
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/UserInfomation" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            /*! 保存用户信息 */
            NSDictionary *userInfoDic=responseDict[@"data"];
            UserInfoModel *infoModel = [UserInfoModel mj_objectWithKeyValues:userInfoDic];
            /*! 写入本地 */
            NSString *loginUserPath = [GlobalFile directoryPathWithFileName:USERINFO_KEY];
            [NSKeyedArchiver archiveRootObject:infoModel toFile:loginUserPath];
            /*! 获取融云token */
            [self gaintGetToken];
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

#pragma mark - 获取融云客服信息
-(void)gaintGetToken
{
    RYTokenRequestModel *model = [[RYTokenRequestModel alloc]init];
    model.user_login = USERNAME;
    model.user_id = USERID;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/getToken" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            NSString *token = [NSString stringWithFormat:@"%@",responseDict[@"token"][@"token"]];
            [StandardUserDefaults setObject:token forKey:@"user_rytoken"];
            /*! 登录融云 */
            [self loginRongYunServer:token];
            /*! 跳转到登录 */
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:RegistToMeNotification object:nil];
            /*! 发送通知刷新首页 */
            [[NSNotificationCenter defaultCenter]postNotificationName:RefreshHomeNotification object:nil];
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

#pragma mark - 登录融云
-(void)loginRongYunServer:(NSString *)tokenStr
{
    NSString *token = tokenStr;
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        
        DDLog(@"userId=======%@",userId);
        /*! 设置当前用户信息 */
        RCUserInfo *currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:USERNAME portrait:nil];
        [RCIMClient sharedRCIMClient].currentUserInfo = currentUserInfo;
        /*! 友盟账号统计 */
        [MobClick profileSignInWithPUID:userId];
        

    } error:^(RCConnectErrorCode status) {
        [HXProgressHUD showMessage:self.view
                         labelText:@"融云Token无效"
                              mode:MBProgressHUDModeText];
    } tokenIncorrect:^{
        [HXProgressHUD showMessage:self.view
                         labelText:@"融云TokenID已过期，请重新获取"
                              mode:MBProgressHUDModeText];
    }];
}


#pragma mark - 输入框输入结束后焦点
- (void) textFieldDidChange:(id) sender {
    UITextField *mobilefield = (UITextField *)[self.view viewWithTag:20];
    UITextField *codefield = (UITextField *)[self.view viewWithTag:21];
        if (![[mobilefield text] isEqual:@""] && ![[codefield text] isEqual:@""]) {
            [registBtn setBackgroundColor:UIColorRedTheme];
            registBtn.enabled=YES;
        }else{
            [registBtn setBackgroundColor:UIColorLineTheme];
            registBtn.enabled=NO;
        }
}

#pragma mark - 返回登录事件
-(void)toLoginBtnClick:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - 收回键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self handleKeyBoad];
}

-(void)handleKeyBoad
{
    for (int i=0; i<2; i++) {
        UITextField *loginfield = (UITextField *)[self.view viewWithTag:i+20];
        [loginfield resignFirstResponder];
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
