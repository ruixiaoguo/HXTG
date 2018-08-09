//
//  HXModifyAdressController.m
//  HXTG
//
//  Created by grx on 2017/4/5.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXModifyAdressController.h"
#import "HZAreaPickerView.h"
#import "UpdateInfoRequestModel.h"
#import "RequestAreaAlnit.h"
#import "UserInfoModel.h"

@interface HXModifyAdressController ()<UITextFieldDelegate,HZAreaPickerDelegate>{
    UILabel *titleLable;
    UITextField *contentField;
    UITextField *adressField;
    UITextField *adressInfoField;
}

@property (strong, nonatomic) HZAreaPickerView *locatePicker;

@end

@implementation HXModifyAdressController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*! 获取所在地 */
    [[RequestAreaAlnit shareInstance]getAreaAlnit];
    self.title = @"编辑地址";
    self.backButton.hidden = NO;
    NSArray *titleArray = [NSArray arrayWithObjects:@"用户姓名:",@"联系方式:",@"所在地区:",@"详细地址:",nil];
    NSString *telStr = USERPHONE;
    NSString *phoneStr = [telStr stringByReplacingOccurrencesOfString:[telStr substringWithRange:NSMakeRange(3,telStr.length-7)]withString:@"****"];
    NSArray *userArray = [NSArray arrayWithObjects:USERNAME,phoneStr,nil];

    for (int i=0; i<4; i++) {
        /*! 背景View */
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        bgView.tag = i+10;
        bgView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,74+i*45).heightIs(44);
        /*! 标题 */
        titleLable = [UILabel new];
        titleLable.text = titleArray[i];
        titleLable.font = UIFontSystem14;
        titleLable.textColor = UIColorBlackTheme;
        [bgView addSubview:titleLable];
        titleLable.sd_layout.leftSpaceToView(bgView,16).topSpaceToView(bgView,1).widthIs(70).heightIs(44);
        if (bgView.tag==12) {
            /*! 选择地区显示文本 */
            adressField = [UITextField new];
            adressField.delegate = self;
            [bgView addSubview:adressField];
            adressField.enabled = NO;
            adressField.font = UIFontSystem14;
            adressField.textColor = UIColorBlackTheme;
            if (self.provence.length==0) {
                adressField.placeholder = @"请选择所在地区";
            }else{
                NSString *address;
                    address = [NSString stringWithFormat:@"%@省%@市%@",self.provence,self.city,self.county];
                    
                    if ([self.provence isEqualToString:self.city]) {
                        address = [NSString stringWithFormat:@"%@%@",self.provence,self.county];
                    }
                    if ([self.county isEqualToString:self.city]) {
                        address = [NSString stringWithFormat:@"%@",self.city];
                    }

                adressField.text = address;
            }
            [adressField setValue:UIFontSystem14 forKeyPath:@"_placeholderLabel.font"];
            adressField.sd_layout.leftSpaceToView(titleLable,4).topSpaceToView(bgView,2).rightSpaceToView(bgView,32).heightIs(44);
            /*! 选择地区按钮 */
            UIButton *adressBtn = [UIButton new];
            [bgView addSubview:adressBtn];
            adressBtn.sd_layout.leftSpaceToView(titleLable,4).topSpaceToView(bgView,0).rightSpaceToView(bgView,0).heightIs(44);
            [adressBtn addTarget:self action:@selector(selectAdressClick:) forControlEvents:UIControlEventTouchUpInside];
            /*! 箭头 */
            UIImageView *tipImage = [UIImageView new];
            tipImage.image = [UIImage imageNamed:@"arrow"];
            [bgView addSubview:tipImage];
            tipImage.sd_layout.rightSpaceToView(bgView,15).centerYEqualToView(bgView).widthIs(8).heightIs(15);
        }else if (bgView.tag==13){
            /*! 详细地址显示文本 */
            adressInfoField = [UITextField new];
            adressInfoField.delegate = self;
            [bgView addSubview:adressInfoField];
            if (self.adressInfo.length==0) {
                adressInfoField.placeholder = @"请输入详细地址";
            }else{
                adressInfoField.text = self.adressInfo;
            }
            adressInfoField.font = UIFontSystem14;
            adressInfoField.textColor = UIColorBlackTheme;
            [adressInfoField setValue:UIFontSystem14 forKeyPath:@"_placeholderLabel.font"];
            adressInfoField.sd_layout.leftSpaceToView(titleLable,4).topSpaceToView(bgView,2).rightSpaceToView(bgView,32).heightIs(44);
        }
    }
    for (int i=0; i<2; i++) {
        /*! 用户名/手机号 */
        contentField = [UITextField new];
        contentField.text = userArray[i];
        contentField.font = UIFontSystem14;
        contentField.textColor = UIColorBlackTheme;
        contentField.enabled = NO;
        [self.view addSubview:contentField];
        contentField.sd_layout.leftSpaceToView(titleLable,4).topSpaceToView(self.view,76+i*45).rightSpaceToView(self.view,32).heightIs(44);
    }
    
    /*! 保存按钮 */
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, Main_Screen_Height-90, Main_Screen_Width-60, 44)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = UIFontSystem16;
    [saveBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    saveBtn.backgroundColor = UIColorRedTheme;
    saveBtn.layer.cornerRadius = 5;
    [saveBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [saveBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    self.provence = picker.locate.province;
    self.provenceId = picker.locate.provinceId;
    self.city = picker.locate.city;
    self.cityId = picker.locate.cityId;
    self.county = picker.locate.district;
    self.countyId = picker.locate.megelId;
    if ([self.provence isEqualToString:self.city]) {
    if ([self.county isEqualToString:self.city]) {
    adressField.text = [NSString stringWithFormat:@"%@",self.provence];
        return;
    }
    adressField.text = [NSString stringWithFormat:@"%@%@",self.provence,self.county];
        return;
    }
    adressField.text = [NSString stringWithFormat:@"%@省%@市%@",self.provence,self.city,self.county];
}


/*! 选择地区 */
-(void)selectAdressClick:(UIButton *)sender
{
    DDLog(@"选择地区");
    [self cancelLocatePicker];
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
    [self.locatePicker showInView:self.view];

}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
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


#pragma mark - 保存
-(void)saveBtnClick:(UIButton *)sender
{
    DDLog(@"保存地址");
    if (adressField.text.length==0) {
        [HXProgressHUD showMessage:self.view labelText:@"请选择所在地区" mode:MBProgressHUDModeText];
        return;
    }
    if (adressInfoField.text.length==0) {
        [HXProgressHUD showMessage:self.view labelText:@"请输入详细地址" mode:MBProgressHUDModeText];
        return;
    }
    [self gaintUpdateUserAddress];
}

#pragma mark - 修改地址网络请求
-(void)gaintUpdateUserAddress
{
    [HXLoadingView show];
    UpdateInfoRequestModel *model = [[UpdateInfoRequestModel alloc]init];
    model.user_id = USERID;
    model.mobile = USERPHONE;
    model.province = self.provenceId;
    model.city = self.cityId;
    model.county = self.countyId;
    model.address = adressInfoField.text;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/updateUserinfo" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            /*! 更新本地缓存 */
            NSString *infoPath = [GlobalFile directoryPathWithFileName:USERINFO_KEY];
            UserInfoModel *infoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:infoPath];
            infoModel.province = [NSString stringWithFormat:@"%@",self.provence];
            infoModel.provinceId = [NSString stringWithFormat:@"%@",self.provenceId];
            infoModel.cityId = [NSString stringWithFormat:@"%@",self.cityId];
            infoModel.countyId = [NSString stringWithFormat:@"%@",self.countyId];

            infoModel.city = [NSString stringWithFormat:@"%@",self.city];
            infoModel.county = [NSString stringWithFormat:@"%@",self.county];
            infoModel.address = [NSString stringWithFormat:@"%@",adressInfoField.text];
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
    [adressInfoField resignFirstResponder];
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
