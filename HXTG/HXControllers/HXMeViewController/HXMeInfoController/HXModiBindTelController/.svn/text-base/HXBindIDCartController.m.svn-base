//
//  HXBindIDCartController.m
//  HXTG
//
//  Created by grx on 2017/4/10.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBindIDCartController.h"
#import "HXBindNewTelController.h"
#import "RegistRequestManager.h"
#import "AuthentRequestModel.h"

@interface HXBindIDCartController ()<UITextFieldDelegate>{
    RegistRequestManager *registmanager;
    UITextField *cartTextField;
    UIButton *nextBtn;
}

@end

@implementation HXBindIDCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份验证";
    self.backButton.hidden = NO;
    [self creatBindUI];
    /*! 发送验证码 */
    [self sendSNSCode];
}

#pragma mark - 创建视图
-(void)creatBindUI
{
    NSArray *placeArray = @[@"请输入原手机号验证码",@"请输入身份证号"];
    CGFloat fieldHight = 44;
    for (int i=0; i<2; i++) {
        /*! 背景View */
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        bgView.tag = 100+i;
        bgView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,80+i*(fieldHight+10)).heightIs(fieldHight);
        /*! 输入框 */
        cartTextField = [UITextField new];
        cartTextField.backgroundColor = [UIColor whiteColor];
        cartTextField.tag = i+20;
        cartTextField.font = UIFontSystem(14);
        cartTextField.delegate = self;
        [bgView addSubview:cartTextField];
        cartTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        cartTextField.sd_layout.leftSpaceToView(bgView,15).topSpaceToView(bgView,6).rightSpaceToView(bgView,15).heightIs(bgView.frame.size.height-8);
        cartTextField.placeholder = placeArray[cartTextField.tag-20];
        [cartTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [cartTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        /*! 设置placeholderLabel颜色 */
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSForegroundColorAttributeName] = UIColorBlackTheme;
        NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:cartTextField.placeholder attributes:dict];
        [cartTextField setAttributedPlaceholder:attribute];
    }
    /*! 确定 */
    UIView *lastBgView = (UIView *)[self.view viewWithTag:101];
    nextBtn = [UIButton new];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.backgroundColor = ColorWithRGB(201, 202, 203);
    nextBtn.layer.cornerRadius = 5;
    nextBtn.enabled = NO;
    [nextBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [nextBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    
    [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    nextBtn.sd_layout.leftSpaceToView(self.view,25).topSpaceToView(lastBgView,160).rightSpaceToView(self.view,25).heightIs(42);
    
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

#pragma mark - 下一步
-(void)nextBtnClick:(UIButton *)sender
{
    UITextField *codefield = (UITextField *)[self.view viewWithTag:21];
    /*! 验证身份证号 */
    if ([UtilityFunction verifyIDCardNumber:codefield.text]==NO) {
        [HXProgressHUD showMessage:self.view labelText:@"身份证号不合法" mode:MBProgressHUDModeText];
        return;
    }
    /*! 验证验证码是否正确 */
    [self verifyPhoneCode];
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

#pragma mark - 发送短信验证码
-(void)sendSNSCode
{
    registmanager = [[RegistRequestManager alloc] init];
    WeakSelf(weakSelf);
    [registmanager setBlockWithReturnBlock:^(id returnValue) {
        DDLog(@"returnValue======%@",returnValue);
        NSString *states = [NSString stringWithFormat:@"%@",returnValue[@"status"]];
        if ([states isEqualToString:@"1"]) {
            [HXProgressHUD showMessage:weakSelf.view
                             labelText:returnValue[@"msg"]
                                  mode:MBProgressHUDModeText];
            [HXLoadingView hide];
        }else{
            [HXProgressHUD showMessage:weakSelf.view
                             labelText:returnValue[@"msg"]
                                  mode:MBProgressHUDModeText];
            [HXLoadingView hide];
        }
    } WithErrorBlock:^(id errorCode) {
        [HXLoadingView hide];
        
    } WithFailureBlock:^{
        DDLog(@"网络异常");
        [HXLoadingView hide];
    }];
    
    NSDictionary *parameter = @{@"mobile": USERPHONE,@"type":@"2"};
    /*! 发送短信验证码 */
    [registmanager requestSendSNSInterface:parameter];
    [HXLoadingView show];
}

#pragma mark - 验证短信验证码
-(void)verifyPhoneCode
{
    UITextField *mobilefield = (UITextField *)[self.view viewWithTag:20];
    /*! 验证短信验证码 */
    registmanager = [[RegistRequestManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [registmanager setBlockWithReturnBlock:^(id returnValue) {
        DDLog(@"returnValue======%@",returnValue);
        NSString *states = [NSString stringWithFormat:@"%@",returnValue[@"status"]];
        if ([states isEqualToString:@"1"]) {
            /*! 验证身份证 */
            [weakSelf verifyIDCart];
        }else{
            [HXProgressHUD showMessage:weakSelf.view
                             labelText:returnValue[@"msg"]
                                  mode:MBProgressHUDModeText];
            [HXLoadingView hide];
        }
    } WithErrorBlock:^(id errorCode) {
        [HXLoadingView hide];
    } WithFailureBlock:^{
        DDLog(@"网络异常");
        [HXLoadingView hide];
    }];
    NSDictionary *parameter = @{@"code": mobilefield.text};
    /*! 验证短信验证码 */
    [registmanager requestCheckSNSInterface:parameter];
}

#pragma mark - 验证身份证
-(void)verifyIDCart
{
    UITextField *codefield = (UITextField *)[self.view viewWithTag:21];
    AuthentRequestModel *model = [[AuthentRequestModel alloc]init];
    model.user_id = USERID;
    model.realname = USERREALNAME;
    model.unumber = codefield.text;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/certification" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            HXBindNewTelController *bindVC = [[HXBindNewTelController alloc]init];
            bindVC.isPush = @"yes";

            [self.navigationController pushViewController:bindVC animated:YES];
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
    for (int i=0; i<2; i++) {
        UITextField *registField = (UITextField *)[self.view viewWithTag:i+20];
        [registField resignFirstResponder];
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
