//
//  HXRegistController.m
//  HXTG
//
//  Created by grx on 2017/2/27.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXRegistController.h"
#import "HXRegistNextController.h"
#import "HXServerProtocolController.h"
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "RegistRequestManager.h"
#import "WPHotspotLabel.h"
#import "HXAlterview.h"
#import "UtilityFunction.h"

@interface HXRegistController ()<UITextFieldDelegate>{
    UITextField *registTextField;
    RegistRequestManager *registmanager;
    UIImageView *proImage;
    UIButton * nextBtn;
    BOOL isSelect;       /*! 是否选择阅读协议 */
}

@end

@implementation HXRegistController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorWithRGB(237, 237, 237);
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
    NSArray *titleArray = @[@"用户名",@"密码",@"确认密码",@"邀请码"];
    NSArray *placeArray = @[@"字母或数字组合",@"6位以上字母、数字或字符组合",@"请再次输入密码确认",@"请输入邀请码"];
    CGFloat fieldHight = 45;
    for (int i=0; i<titleArray.count; i++) {
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
        registTextField = [UITextField new];
        registTextField.backgroundColor = [UIColor whiteColor];
        registTextField.tag = i+20;
        registTextField.font = UIFontSystem(14);
        registTextField.delegate = self;
        [bgView addSubview:registTextField];
        [registTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        registTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        registTextField.sd_layout.leftSpaceToView(titleLable,5).topSpaceToView(bgView,6).rightSpaceToView(bgView,20).heightIs(bgView.frame.size.height-8);
        registTextField.placeholder = placeArray[registTextField.tag-20];
        [registTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        if (registTextField.tag==21 || registTextField.tag==22) {
            registTextField.secureTextEntry = YES;
        }
    }
    /*! 阅读协议 */
    /*! 协议按钮 */
    isSelect = NO; /*! 默认非选中 */
    UIView *lastBgView = (UIView *)[self.view viewWithTag:103];
    UIButton *protocolBtn = [UIButton new];
    [self.view addSubview:protocolBtn];
    [protocolBtn addTarget:self action:@selector(protocolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    protocolBtn.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(lastBgView,3).widthIs(60).heightIs(40);
    proImage = [UIImageView new];
    [self.view addSubview:proImage];
    proImage.image = [UIImage imageNamed:@"bank_bg"];
    proImage.sd_layout.leftSpaceToView(self.view,17).topSpaceToView(lastBgView,15).widthIs(13).heightIs(13);
    /*! 协议内容 */
    WPHotspotLabel *xyLable=[WPHotspotLabel new];
    xyLable.numberOfLines=2;
    xyLable.textAlignment=NSTextAlignmentLeft;
    xyLable.textColor = ColorWithRGB(98, 99, 100);
    [self.view addSubview:xyLable];
    xyLable.sd_layout.leftSpaceToView(proImage,5).rightSpaceToView(self.view,10).topSpaceToView(lastBgView,11).heightIs(20);
    NSDictionary* style = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:12.0],
                            @"pro":[WPAttributedStyleAction styledActionWithAction:^{
                                /*! 用户协议 */
                                HXServerProtocolController *proVC = [[HXServerProtocolController alloc]init];
                                [self.navigationController pushViewController:proVC animated:YES];
                            }],@"link": [UIColor redColor]};
    xyLable.attributedText = [@"我已阅读并同意<pro>《华讯投资用户服务协议》</pro>" attributedStringWithStyleBook:style];
    /*! 下一步 */
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
    nextBtn.sd_layout.leftSpaceToView(self.view,25).topSpaceToView(proImage,80).rightSpaceToView(self.view,25).heightIs(45);
    /*! 已有账号登录 */
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"已有账号？立即登录"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [loginBtn setAttributedTitle:title
                        forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    loginBtn.titleLabel.textColor = ColorWithRGB(41, 142, 251);
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.sd_layout.rightSpaceToView(self.view,20).topSpaceToView(nextBtn,0).widthIs(120).heightIs(40);
}

#pragma mark - 阅读协议
-(void)protocolBtnClick:(UIButton *)sender
{
    if (isSelect==NO) {
        proImage.image = [UIImage imageNamed:@"bank_selectd"];
        isSelect = YES;
    }else{
        proImage.image = [UIImage imageNamed:@"bank_bg"];
        isSelect = NO;
    }
}

#pragma mark - 下一步事件
-(void)nextBtnClick:(UIButton *)sender
{
    UITextField *userName = (UITextField *)[self.view viewWithTag:20];
    UITextField *pwsfield = (UITextField *)[self.view viewWithTag:21];
    UITextField *rePwsfield = (UITextField *)[self.view viewWithTag:22];
    UITextField *invitationfield = (UITextField *)[self.view viewWithTag:23];

    /*! 验证用户名格式 */
    if ([UtilityFunction validateUserName:userName.text]==NO) {
        [HXProgressHUD showMessage:self.view labelText:@"用户名不能包含特殊符号" mode:MBProgressHUDModeText];
        return;
    }
    
    /*! 验证密码(要求数字、字母、字符，至少包含两种,6位以上) */
    if ([UtilityFunction validatePassword:pwsfield.text]==NO) {
        [HXProgressHUD showMessage:self.view labelText:@"密码格式不正确" mode:MBProgressHUDModeText];
        return;
    }
    
    if (![pwsfield.text isEqualToString:rePwsfield.text]) {
        [HXProgressHUD showMessage:self.view labelText:@"密码输入不一致,请重新输入" mode:MBProgressHUDModeText];
        return;
    }

    if (isSelect==NO) {
        HXAlterview *view = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"请先勾选同意阅读协议" centerButtonTitle:@"我知道了"];
        [view show];
        return;
    }
    
    /*! 验证用户名是否存在 */
    registmanager = [[RegistRequestManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [registmanager setBlockWithReturnBlock:^(id returnValue) {
        DDLog(@"returnValue======%@",returnValue);
        NSString *states = [NSString stringWithFormat:@"%@",returnValue[@"status"]];
        if ([states isEqualToString:@"1"]) {
            HXRegistNextController *registNextVC = [[HXRegistNextController alloc]initWithUserName:userName.text userPws:pwsfield.text Invitation:invitationfield.text];
            [weakSelf.navigationController pushViewController:registNextVC animated:YES];
            [HXLoadingView hide];
        }else{
            [HXProgressHUD showMessage:weakSelf.view labelText:returnValue[@"msg"] mode:MBProgressHUDModeText];
            [HXLoadingView hide];
        }
    } WithErrorBlock:^(id errorCode) {
        DDLog(@"errorCode======%@",errorCode);
        [HXLoadingView hide];
    } WithFailureBlock:^{
        DDLog(@"网络异常");
        [HXLoadingView hide];
    }];
    UITextField *userfield = (UITextField *)[self.view viewWithTag:20];
    NSDictionary *parameter = @{@"user_login": userfield.text};
    /*! 验证用户名是否存在 */
    [registmanager requestIsExistUserInterface:parameter];
    [HXLoadingView show];
}

#pragma mark - 返回登录事件
-(void)loginBtnClick:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 收回键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (int i=0; i<3; i++) {
        UITextField *loginfield = (UITextField *)[self.view viewWithTag:i+20];
        [loginfield resignFirstResponder];
    }
}

#pragma mark - 输入框输入结束后焦点
- (void) textFieldDidChange:(id) sender {
        UITextField *userfield = (UITextField *)[self.view viewWithTag:20];
        UITextField *pswfield = (UITextField *)[self.view viewWithTag:21];
        UITextField *rePswfield = (UITextField *)[self.view viewWithTag:22];
        if (![[userfield text] isEqual:@""] && ![[pswfield text] isEqual:@""] && ![[rePswfield text] isEqual:@""]) {
            [nextBtn setBackgroundColor:UIColorRedTheme];
            nextBtn.enabled=YES;
        }else{
            [nextBtn setBackgroundColor:UIColorLineTheme];
            nextBtn.enabled=NO;
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
