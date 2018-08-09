//
//  HXModifyQQController.m
//  HXTG
//
//  Created by grx on 2017/4/5.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXModifyQQController.h"
#import "UpdateInfoRequestModel.h"
#import "UserInfoModel.h"

@interface HXModifyQQController ()<UITextFieldDelegate>{
    UITextField *qqTextField;
    UIButton *sureBtn;
}

@end

@implementation HXModifyQQController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善QQ号码";
    self.backButton.hidden = NO;
    /*! 背景View */
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    bgView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,80).heightIs(45);
    /*! 输入框 */
    qqTextField = [UITextField new];
    qqTextField.backgroundColor = [UIColor whiteColor];
    qqTextField.font = UIFontSystem(14);
    qqTextField.delegate = self;
    [bgView addSubview:qqTextField];
    qqTextField.keyboardType = UIKeyboardTypeNumberPad;
    qqTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    qqTextField.sd_layout.leftSpaceToView(bgView,15).topSpaceToView(bgView,0).rightSpaceToView(bgView,15).heightIs(45);
    qqTextField.placeholder = @"请输入qq号码";
    [qqTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    /*! 设置placeholderLabel颜色 */
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = UIColorBlackTheme;
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:qqTextField.placeholder attributes:dict];
    [qqTextField setAttributedPlaceholder:attribute];
    /*! 确定按钮 */
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(0,0,60,30);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = UIFontSystem15;
    [sureBtn setTintColor:UIColorWhite];
    [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -18;
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sureBtn];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightButtonItem, nil];
    
}


-(void)sureBtnAction:(UIButton *)sender
{
    if (qqTextField.text.length == 0) {
        [HXProgressHUD showMessage:self.view labelText:@"qq号码不能为空" mode:MBProgressHUDModeText];
        return;
    }
    /*! 验证QQ格式 */
    if ([UtilityFunction validateNum:qqTextField.text]==NO) {
        [HXProgressHUD showMessage:self.view labelText:@"QQ号码不合法" mode:MBProgressHUDModeText];
        return;
    }
    [self gaintUpdateUserQQ];
}


#pragma mark - 修改qq号码网络请求
-(void)gaintUpdateUserQQ
{
    [HXLoadingView show];
    UpdateInfoRequestModel *model = [[UpdateInfoRequestModel alloc]init];
    model.user_id = USERID;
    model.mobile = USERPHONE;
    model.qq = qqTextField.text;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/updateUserinfo" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            /*! 更新本地缓存 */
            NSString *infoPath = [GlobalFile directoryPathWithFileName:USERINFO_KEY];
            UserInfoModel *infoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:infoPath];
            infoModel.uqq=qqTextField.text;
            [NSKeyedArchiver archiveRootObject:infoModel toFile:infoPath];
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
    [qqTextField resignFirstResponder];
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
