//
//  HXModifyAuthentController.m
//  HXTG
//
//  Created by grx on 2017/4/5.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXModifyAuthentController.h"
#import "HXSuccesAuthentController.h"
#import "AuthentRequestModel.h"
#import "UserInfoModel.h"

@interface HXModifyAuthentController ()<UITextFieldDelegate>{
    UITextField *authentTextField;
    UIButton *submitBtn;
}

@end

@implementation HXModifyAuthentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    self.backButton.hidden = NO;
    [self creatAuthentUI];
}

#pragma mark - 创建视图
-(void)creatAuthentUI
{
    NSArray *titleArray = @[@"姓名",@"身份证号"];
    NSArray *placeArray = @[@"请输入您的真实姓名",@"请输入你的身份证号"];
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
        titleLable.textColor = UIColorBlackTheme;
        titleLable.tag = i+10;
        titleLable.text = titleArray[titleLable.tag-10];
        titleLable.sd_layout.leftSpaceToView(bgView,15).topSpaceToView(bgView,2).widthIs(60).heightIs(bgView.frame.size.height);
        /*! 输入框 */
        authentTextField = [UITextField new];
        authentTextField.backgroundColor = [UIColor whiteColor];
        authentTextField.tag = i+20;
        authentTextField.font = UIFontSystem(14);
        authentTextField.delegate = self;
        [bgView addSubview:authentTextField];
        if (authentTextField.tag==21) {
            authentTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        }
        [authentTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        authentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        authentTextField.sd_layout.leftSpaceToView(titleLable,7).topSpaceToView(bgView,6).rightSpaceToView(bgView,20).heightIs(bgView.frame.size.height-8);
        authentTextField.placeholder = placeArray[authentTextField.tag-20];
        [authentTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    }
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
    submitBtn.sd_layout.leftSpaceToView(self.view,25).bottomSpaceToView(self.view,46).rightSpaceToView(self.view,25).heightIs(44);
}

#pragma mark - 输入框输入结束后焦点
- (void) textFieldDidChange:(id) sender {
    UITextField *namefield = (UITextField *)[self.view viewWithTag:20];
    UITextField *idCartfield = (UITextField *)[self.view viewWithTag:21];
    if (![[namefield text] isEqual:@""] && ![[idCartfield text] isEqual:@""]) {
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
    UITextField *idCartfield = (UITextField *)[self.view viewWithTag:21];
    /*! 验证身份证号 */
    if ([UtilityFunction verifyIDCardNumber:idCartfield.text]==NO) {
        [HXProgressHUD showMessage:self.view labelText:@"身份证号不合法" mode:MBProgressHUDModeText];
        return;
    }
    [self gaintAuthent];
}

#pragma mark - 实名认证网络请求
-(void)gaintAuthent
{
    UITextField *namefield = (UITextField *)[self.view viewWithTag:20];
    UITextField *idCartfield = (UITextField *)[self.view viewWithTag:21];
    [HXLoadingView show];
    AuthentRequestModel *model = [[AuthentRequestModel alloc]init];
    model.user_id = USERID;
    model.realname = namefield.text;
    model.unumber = idCartfield.text;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/certification" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            /*! 更新本地缓存 */
            NSString *infoPath = [GlobalFile directoryPathWithFileName:USERINFO_KEY];
            UserInfoModel *infoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:infoPath];
            infoModel.ischeck = @"1";
            infoModel.unumber = idCartfield.text;
            infoModel.realname = namefield.text;
            [NSKeyedArchiver archiveRootObject:infoModel toFile:infoPath];
            [StandardUserDefaults  setObject:namefield.text forKey:@"user_realname"];

            HXSuccesAuthentController *succesVC = [[HXSuccesAuthentController alloc]init];
            [self.navigationController pushViewController:succesVC animated:YES];
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
