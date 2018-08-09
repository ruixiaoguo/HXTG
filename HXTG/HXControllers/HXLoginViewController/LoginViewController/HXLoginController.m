//
//  HXLoginController.m
//  HXTG
//
//  Created by grx on 2017/2/27.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXLoginController.h"
#import "HXForgetPswController.h"
#import "HXRegistController.h"
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
#import <RongIMKit/RongIMKit.h>
#import "AuthcodeView.h"
#import "HXNavigationBar.h"
#import "LoginRequestManager.h"
#import "UserInfoRequestModel.h"
#import "UserInfoModel.h"
#import "JPUSHService.h"
#import "RYTokenRequestModel.h"
#import "UMMobClick/MobClick.h"

@interface HXLoginController ()<UITextFieldDelegate>{
    LoginRequestManager *loginManager;
    UITextField *loginTextField;
    UIImageView *proImage;
    AuthcodeView *authcodeView;
    UIButton * loginBtn;
    UIButton *registBtn;
    UIButton *forgetBtn;
    BOOL isSelect;       /*! 是否选择阅读协议 */
}

@property(nonatomic,strong) UIView *xyBgView;

@end

@implementation HXLoginController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    [self refreshYzPicViewUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorWithRGB(237, 237, 237);
    /*! 自定义导航 */
    HXNavigationBar *navBar =[[HXNavigationBar alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, VIEW_OFFSET+kNavigationBarHeight)];
    [navBar setBarTintColor:ColorWithRGB(234, 57, 69)];
    [self.view addSubview:navBar];

    /*! 登录 */
    UILabel *loginLable=[UILabel new];
    [loginLable setText:@"登录"];
    loginLable.font=[UIFont systemFontOfSize:18];
    loginLable.textAlignment=NSTextAlignmentCenter;
    loginLable.textColor=[UIColor whiteColor];
    [navBar addSubview:loginLable];
    loginLable.sd_layout.leftSpaceToView(navBar,20).rightSpaceToView(navBar,20).topSpaceToView(navBar,NAV_OFFSET).heightIs(45);
    /*! 返回 */
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [backBtn addTarget:self action:@selector(backClickBtn) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *bgView=[[UIImageView alloc]initWithFrame:CGRectMake(16, 13, 12, 20)];
    bgView.image=[UIImage imageNamed:@"home_back"];
    [backBtn addSubview:bgView];
    [navBar addSubview:backBtn];
    backBtn.sd_layout.leftSpaceToView(navBar,0).topSpaceToView(navBar,NAV_OFFSET).heightIs(40).widthIs(100);
    /*! 创建UI */
    [self creatLoginUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JumpToMeClick:) name:RegistToMeNotification object:nil];
}

#pragma mark - 创建视图
-(void)creatLoginUI
{
    NSArray *imageArray = @[@"yonghuming",@"mima",@"yanzhengma"];
    NSArray *placeArray = @[@"请输入用户名/手机号码",@"请输入密码",@"请输入右图验证码"];
    CGFloat fieldHight = 45;
    for (int i=0; i<3; i++) {
        /*! 背景View */
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        bgView.tag = 100+i;
        bgView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,80+i*(fieldHight+10)).heightIs(fieldHight);
        /*! 图片 */
        UIImageView *imageView = [UIImageView new];
        [bgView addSubview:imageView];
        imageView.tag = i+10;
        imageView.image = [UIImage imageNamed:imageArray[i]];
        imageView.sd_layout.leftSpaceToView(bgView,15).topSpaceToView(bgView,13).widthIs(17).heightIs(20);
        /*! 输入框 */
        loginTextField = [UITextField new];
        loginTextField.backgroundColor = [UIColor whiteColor];
        loginTextField.tag = i+20;
        loginTextField.font = UIFontSystem(14);
        [bgView addSubview:loginTextField];
        loginTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        loginTextField.sd_layout.leftSpaceToView(imageView,12).topSpaceToView(bgView,6).rightSpaceToView(bgView,20).heightIs(bgView.frame.size.height-8);
        loginTextField.placeholder = placeArray[loginTextField.tag-20];
        [loginTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        loginTextField.delegate = self;
        [loginTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        if (bgView.tag == 101) {
           /*! 密码可见 */
            loginTextField.sd_layout.leftSpaceToView(imageView,12).topSpaceToView(bgView,6).rightSpaceToView(bgView,50).heightIs(bgView.frame.size.height-8);
            loginTextField.secureTextEntry = YES;
            [self createPsdSwitchBtn:bgView];
        }else if (bgView.tag == 102){
           /*! 图片验证码 */
            loginTextField.sd_layout.leftSpaceToView(imageView,12).topSpaceToView(bgView,6).rightSpaceToView(bgView,120).heightIs(bgView.frame.size.height-8);
            [self createAuthcodeView:bgView];
        }
    }
    /*! 登录 */
    loginBtn = [UIButton new];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = UIFontSystem16;
    [loginBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    loginBtn.backgroundColor = UIColorLineTheme;

    loginBtn.layer.cornerRadius = 5;
    loginBtn.enabled = NO;
    [loginBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [loginBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];

    [loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:loginBtn];
    /*! 没有账号注册 */
    registBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"还没有账号？注册"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [registBtn setAttributedTitle:title
                        forState:UIControlStateNormal];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    registBtn.titleLabel.textColor = ColorWithRGB(41, 142, 251);
    [self.view addSubview:registBtn];
    [registBtn addTarget:self action:@selector(registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    /*! 忘记密码 */
    forgetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    NSMutableAttributedString *forgetTitle = [[NSMutableAttributedString alloc] initWithString:@"忘记密码？"];
    NSRange forgetTitleRange = {0,[forgetTitle length]};
    [forgetTitle addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:forgetTitleRange];
    [forgetBtn setAttributedTitle:forgetTitle
                         forState:UIControlStateNormal];
    [forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    forgetBtn.titleLabel.textColor = ColorWithRGB(41, 142, 251);
    [self.view addSubview:forgetBtn];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 密码隐藏可见状态
-(void)createPsdSwitchBtn:(UIView *)superView{

    UIButton *psdSwitchBtn = [UIButton new];
    [psdSwitchBtn setImage:[UIImage imageNamed:@"login_menu_uncheck"] forState:UIControlStateNormal];
    [psdSwitchBtn setImage:[UIImage imageNamed:@"login_menu_check"] forState:UIControlStateSelected];
    [psdSwitchBtn addTarget:self action:@selector(isShowPw:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:psdSwitchBtn];
    psdSwitchBtn.sd_layout.rightSpaceToView(superView,0).topSpaceToView(superView,2).widthIs(50).heightIs(superView.frame.size.height);

}

#pragma mark - 密码是否可见
-(void)isShowPw:(UIButton *)sender
{
    sender.selected = !sender.selected;
    UITextField *passwordField = (UITextField *)[self.view viewWithTag:21];
    passwordField.secureTextEntry = !sender.selected;
}

#pragma mark - 图片验证码
-(void)createAuthcodeView:(UIView *)superView{
    authcodeView = [AuthcodeView new];
    [superView addSubview:authcodeView];
    authcodeView.sd_layout.rightSpaceToView(superView,48).topSpaceToView(superView,8).widthIs(60).heightIs(superView.frame.size.height-15);
    UIButton *changeBtn = [UIButton new];
    [changeBtn setTitle:@"换一换" forState:UIControlStateNormal];
    [changeBtn setTitleColor:ColorWithRGB(41, 142, 251) forState:UIControlStateNormal];
    changeBtn.titleLabel.font = UIFontSystem(11);
    [superView addSubview:changeBtn];
    [changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    changeBtn.sd_layout.rightSpaceToView(superView,0).topSpaceToView(superView,0).widthIs(48).heightIs(superView.frame.size.height);
}


#pragma mark - 用户登录事件
-(void)loginClick:(UIButton *)sender
{
    [HXLoadingView show];
    /*! 如果存在图片验证码 */
    if ([[StandardUserDefaults objectForKey:@"isShowPic"]boolValue]) {
        UITextField *yzString = (UITextField *)[self.view viewWithTag:22];
        if (![yzString.text isEqualToString:authcodeView.authCodeStr]) {
            [HXProgressHUD showMessage:self.view labelText:@"图片验证码错误,请重新输入！" mode:MBProgressHUDModeText];
            return;
        }
    }
    /*! 请求登录接口 */
    loginManager = [[LoginRequestManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [loginManager setBlockWithReturnBlock:^(id returnValue) {
        DDLog(@"loginInfo======%@",returnValue);
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
            [StandardUserDefaults setObject:sign forKey:@"sign"];

            [StandardUserDefaults  setObject:userId forKey:@"user_Id"];
            [StandardUserDefaults  setObject:userPhone forKey:@"user_phone"];
            [StandardUserDefaults  setBool:NO forKey:@"isShowPic"];
            
            /*! 老师信息 */
            NSString *legionLid = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"legion"][@"lid"]];
            NSString *lrvinName = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"legion"][@"lrving_name"]];
            NSString *teacherID = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"legion"][@"tech_id"]];
            NSString *teacherName = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"legion"][@"tech_username"]];
            NSString *teacherNiceName = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"legion"][@"user_nicename"]];
            NSString *teacherNum = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"legion"][@"card_number"]];
            NSString *teacherHead = [NSString stringWithFormat:@"%@",returnValue[@"data"][@"legion"][@"user_pic"]];

            [StandardUserDefaults  setObject:legionLid forKey:@"legionLid"];
            [StandardUserDefaults  setObject:lrvinName forKey:@"lrvinName"];
            [StandardUserDefaults  setObject:teacherID forKey:@"teacherID"];
            [StandardUserDefaults  setObject:teacherName forKey:@"teacherName"];
            [StandardUserDefaults  setObject:teacherNiceName forKey:@"teacherNiceName"];
            [StandardUserDefaults  setObject:teacherNum forKey:@"teacherNum"];
            [StandardUserDefaults  setObject:teacherHead forKey:@"teacherHead"];
            /*! 用于绑定极光Alias */
//            [JPUSHService setAlias:userName callbackSelector:nil object:weakSelf];
            /*! 保存用户信息 */
            [weakSelf gaintUserInfomation];
            
        }else{
            [HXProgressHUD showMessage:weakSelf.view labelText:returnValue[@"msg"] mode:MBProgressHUDModeText];
            NSString *retry_count = [NSString stringWithFormat:@"%@",returnValue[@"retry_count"]];
            if ([retry_count isEqualToString:@"1"]) {
                [StandardUserDefaults setBool:YES forKey:@"isShowPic"];
                [weakSelf refreshYzPicViewUI];
            }
            DDLog(@"retry_count=======%@",returnValue[@"retry_count"]);
            [HXLoadingView hide];
        }
    } WithErrorBlock:^(id errorCode) {
        DDLog(@"errorCode======%@",errorCode);
        [HXLoadingView hide];
        [[HXNetBoxView getInstance]showTitle:weakSelf.view withTitle:@"服务器异常,请检查服务器!!"];

    } WithFailureBlock:^{
        [HXLoadingView hide];
        [[HXNetBoxView getInstance]showTitle:weakSelf.view withTitle:@"网络开小差了,请检查网络状况!!"];
        DDLog(@"网络异常");
    }];
    UITextField *userfield = (UITextField *)[self.view viewWithTag:20];
    UITextField *pswfield = (UITextField *)[self.view viewWithTag:21];
    NSDictionary *parameter = @{@"user_login": userfield.text,@"user_pass":pswfield.text};
    
    [loginManager requestLoginInterface:parameter];
}

#pragma mark - 用户注册事件
-(void)registBtnClick:(UIButton *)sender
{
    HXRegistController *registVC = [[HXRegistController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}

#pragma mark - 用户忘记密码事件
-(void)forgetBtnClick:(UIButton *)sender
{
    HXForgetPswController *forgetVC = [[HXForgetPswController alloc]init];
    
    [self.navigationController pushViewController:forgetVC animated:YES];
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
//            [self dismissViewControllerAnimated:YES completion:nil];
            /*! 发送通知刷新首页 */
            [[NSNotificationCenter defaultCenter]postNotificationName:RefreshHomeNotification object:nil];
            /*! 发送通知刷新我的 */
            [[NSNotificationCenter defaultCenter]postNotificationName:RefreshMeNotification object:nil];
//            [HXLoadingView hide];

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
        
        /*! 友盟账号统计 */
        [MobClick profileSignInWithPUID:userId];
        [self dismissViewControllerAnimated:YES completion:nil];
//        /*! 发送通知刷新首页 */
//        [[NSNotificationCenter defaultCenter]postNotificationName:RefreshHomeNotification object:nil];
//        /*! 发送通知刷新我的 */
//        [[NSNotificationCenter defaultCenter]postNotificationName:RefreshMeNotification object:nil];
        [HXLoadingView hide];
    
    } error:^(RCConnectErrorCode status) {
        DDLog(@"TokenID无效，请重新获取");
        [HXProgressHUD showMessage:self.view
                         labelText:@"Token无效，请重新获取"
                              mode:MBProgressHUDModeText];
        [HXLoadingView hide];

    } tokenIncorrect:^{
        DDLog(@"TokenID已过期，请重新获取");
        [HXProgressHUD showMessage:self.view
                         labelText:@"TokenID已过期，请重新获取"
                              mode:MBProgressHUDModeText];
        [HXLoadingView hide];

    }];
}

#pragma mark - 换一换
-(void)changeBtnClick:(UIButton *)sender
{
    [authcodeView getAuthcode];
}

#pragma mark - 返回事件
-(void)backClickBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 收回键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self handleKeyBoad];
}

#pragma mark - 输入框输入结束后焦点
- (void) textFieldDidChange:(id) sender {
    UITextField *userfield = (UITextField *)[self.view viewWithTag:20];
    UITextField *pswfield = (UITextField *)[self.view viewWithTag:21];
    UITextField *yzfield = (UITextField *)[self.view viewWithTag:22];
    if (![[StandardUserDefaults objectForKey:@"isShowPic"]boolValue]) {
        if (![[userfield text] isEqual:@""] && ![[pswfield text] isEqual:@""]) {
            [loginBtn setBackgroundColor:UIColorRedTheme];
            loginBtn.enabled=YES;
        }else{
            [loginBtn setBackgroundColor:UIColorLineTheme];
            loginBtn.enabled=NO;
        }
    }else{
    if (![[userfield text] isEqual:@""] && ![[pswfield text] isEqual:@""] && ![[yzfield text] isEqual:@""]) {
        [loginBtn setBackgroundColor:ColorWithRGB(234, 57, 69)];
        loginBtn.enabled=YES;
    }else{
        [loginBtn setBackgroundColor:ColorWithRGB(201, 202, 203)];
        loginBtn.enabled=NO;
    }
    }
}

-(void)refreshYzPicViewUI
{
    UIView *lastBgView;
    UIView *psdPicBgView = (UIView *)[self.view viewWithTag:102];
    if (![[StandardUserDefaults objectForKey:@"isShowPic"]boolValue]) {
        lastBgView = (UIView *)[self.view viewWithTag:101];
        psdPicBgView.hidden = YES;
    }else if([[StandardUserDefaults objectForKey:@"isShowPic"]boolValue]){
        lastBgView = (UIView *)[self.view viewWithTag:102];
        psdPicBgView.hidden = NO;
    }
    loginBtn.sd_layout.leftSpaceToView(self.view,25).topSpaceToView(lastBgView,92).rightSpaceToView(self.view,25).heightIs(42);
    registBtn.sd_layout.rightSpaceToView(self.view,14).topSpaceToView(loginBtn,0).widthIs(120).heightIs(40);
    forgetBtn.sd_layout.leftSpaceToView(self.view,1).topSpaceToView(loginBtn,0).widthIs(110).heightIs(40);

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

-(void)handleKeyBoad
{
        for (int i=0; i<3; i++) {
        UITextField *loginfield = (UITextField *)[self.view viewWithTag:i+20];
        [loginfield resignFirstResponder];
        }
}

#pragma mark - 注册成功直接跳转到我的界面
-(void)JumpToMeClick:(NSNotification *)text
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:RegistToMeNotification object:nil];
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
