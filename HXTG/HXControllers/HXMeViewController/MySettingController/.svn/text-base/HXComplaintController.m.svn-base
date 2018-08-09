//
//  HXComplaintController.m
//  HXTG
//
//  Created by grx on 2017/3/31.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXComplaintController.h"
#import "ComplaintRequestModel.h"
#import "UILabel+ContentSize.h"
#import "NSString+TxtHeight.h"
#import "HXPhotoWall.h"
#import "HXAddImage.h"

@interface HXComplaintController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>{
    UILabel *placeholderLable;
    UIButton *submitBtn;
    UIScrollView *comPlainScrView;
}

@property (strong, nonatomic) HXAddImage *photoWall;

@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) UITextView *complainFeild;
@property (strong, nonatomic) UITextField *userNameFeild;
@property (strong, nonatomic) UITextField *phoneNumFeild;

@end

@implementation HXComplaintController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉反馈";
    self.backButton.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.imageArray = [NSMutableArray arrayWithCapacity:0];
    comPlainScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    comPlainScrView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    comPlainScrView.delegate = self;
    comPlainScrView.bounces = NO;
    comPlainScrView.showsHorizontalScrollIndicator = NO;
    comPlainScrView.showsVerticalScrollIndicator = NO;
    comPlainScrView.backgroundColor = [UIColor whiteColor];
    comPlainScrView.contentSize = CGSizeMake(0, Main_Screen_Height+120);
    comPlainScrView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:comPlainScrView];
    [self markComplaintView];
}

-(void)markComplaintView
{
    WeakSelf(weakSelf);
    /*! 用户姓名 */
    UIView *bgNameView = [UIView new];
    bgNameView.backgroundColor = UIColorWhite;
    [comPlainScrView addSubview:bgNameView];
    bgNameView.sd_layout.leftSpaceToView(comPlainScrView,0).topSpaceToView(comPlainScrView,74).rightSpaceToView(comPlainScrView,0).heightIs(42);
    /*! lable */
    UILabel *nameLable = [UILabel new];
    nameLable.font = UIFontSystem14;
    nameLable.textColor = UIColorBlackTheme;
    nameLable.text = @"用户姓名";
    [bgNameView addSubview:nameLable];
    nameLable.sd_layout.leftSpaceToView(bgNameView, 15).topSpaceToView(bgNameView, 0).widthIs(60).heightIs(42);
    self.userNameFeild = [UITextField new];
    self.userNameFeild.font = UIFontSystem14;
    self.userNameFeild.textColor = UIColorBlackTheme;
    self.userNameFeild.placeholder = @"请输入用户姓名";
    self.userNameFeild.delegate = self;
    self.userNameFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgNameView addSubview:self.userNameFeild];
    self.userNameFeild.sd_layout.leftSpaceToView(nameLable, 10).topSpaceToView(bgNameView, 1).rightSpaceToView(bgNameView, 15).heightIs(42);
    /*! 联系方式 */
    UIView *bgPhoneView = [UIView new];
    bgPhoneView.backgroundColor = UIColorWhite;
    [comPlainScrView addSubview:bgPhoneView];
    bgPhoneView.sd_layout.leftSpaceToView(comPlainScrView,0).topSpaceToView(bgNameView,10).rightSpaceToView(comPlainScrView,0).heightIs(42);
    /*! lable */
    UILabel *phoneLable = [UILabel new];
    phoneLable.font = UIFontSystem14;
    phoneLable.textColor = UIColorBlackTheme;
    phoneLable.text = @"联系方式";
    [bgPhoneView addSubview:phoneLable];
    phoneLable.sd_layout.leftSpaceToView(bgPhoneView, 15).topSpaceToView(bgPhoneView, 0).widthIs(60).heightIs(42);
    self.phoneNumFeild = [UITextField new];
    self.phoneNumFeild.font = UIFontSystem14;
    self.phoneNumFeild.textColor = UIColorBlackTheme;
    self.phoneNumFeild.placeholder = @"请输入联系方式";
    self.phoneNumFeild.delegate = self;
    self.phoneNumFeild.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgPhoneView addSubview:self.phoneNumFeild];
    self.phoneNumFeild.sd_layout.leftSpaceToView(phoneLable, 10).topSpaceToView(bgPhoneView, 1).rightSpaceToView(bgPhoneView, 15).heightIs(42);
    /*! 背景 */
    UIView *bgView = [UIView new];
    bgView.backgroundColor = UIColorWhite;
    [comPlainScrView addSubview:bgView];
    bgView.sd_layout.leftSpaceToView(comPlainScrView,0).topSpaceToView(bgPhoneView,10).rightSpaceToView(comPlainScrView,0).heightIs(250);
    /*! lable */
    UILabel *tipLable = [UILabel new];
    tipLable.font = UIFontSystem14;
    tipLable.textColor = UIColorBlackTheme;
    tipLable.text = @"投诉建议:";
    [bgView addSubview:tipLable];
    tipLable.sd_layout.leftSpaceToView(bgView, 15).topSpaceToView(bgView, 0).widthIs(65).heightIs(35);
    /*! 留言输入框 */
    self.complainFeild = [UITextView new];
    self.complainFeild.font = UIFontSystem14;
    self.complainFeild.textColor = UIColorBlackTheme;
    self.complainFeild.delegate = self;
    self.complainFeild.layer.borderColor = UIColorLineTheme.CGColor;
    [bgView addSubview:self.complainFeild];
    self.complainFeild.sd_layout.leftSpaceToView(bgView,10).rightSpaceToView(bgView,15).topSpaceToView(bgView,26).heightIs(140);
    placeholderLable = [UILabel new];
    placeholderLable.font = UIFontSystem14;
    NSString *placeStr = @"请详细描述你的问题或建议，我们将及时跟进与解决。(建议300字以内添加相关截图，单张图片大小不超过5M，最多5张)";
    CGFloat contentStrHight = [placeStr heightWithLabelFont:UIFontSystem14 withLabelWidth:Main_Screen_Width-30];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:placeStr];
    NSRange range = NSMakeRange(24, placeStr.length-24);
    [attString addAttribute:NSFontAttributeName value:UIFontSystem12 range:range];
    placeholderLable.attributedText = attString;

    placeholderLable.textColor = UIColorLineTheme;
    placeholderLable.numberOfLines = 0;
    [self.complainFeild addSubview:placeholderLable];
    placeholderLable.sd_layout.leftSpaceToView(self.complainFeild,5).topSpaceToView(self.complainFeild,5).rightSpaceToView(self.complainFeild,0).heightIs(contentStrHight);
    /*! 照片墙 */
    self.photoWall = [[HXAddImage alloc]initWithFrame:CGRectMake(0, 170, Main_Screen_Width, 70)];
    [bgView addSubview:self.photoWall];
    
    self.photoWall.gaintSelectImageArray = ^(NSMutableArray *selectArray){
        weakSelf.imageArray = selectArray;
    };
    /*! 投诉电话 */
    UILabel *complaintPhone = [UILabel new];
    complaintPhone.font = UIFontSystem13;
    complaintPhone.textColor = UIColorLightTheme;
    complaintPhone.numberOfLines = 2;
    complaintPhone.textAlignment = NSTextAlignmentCenter;
    complaintPhone.text = @"投诉服务时间：周一到周五 9:00-18:00, 周日 14:00-18:00";
    [comPlainScrView addSubview:complaintPhone];
    complaintPhone.sd_layout.leftSpaceToView(comPlainScrView,0).rightSpaceToView(comPlainScrView,0).topSpaceToView(bgView,35).heightIs(35);
    UILabel *complaintTel = [UILabel new];
    complaintTel.font = UIFontSystem13;
    complaintTel.textColor = UIColorLightTheme;
    complaintTel.textAlignment = NSTextAlignmentCenter;
    complaintTel.text = @"投诉热线：010-53821559 或 400-098-7966";
    [comPlainScrView addSubview:complaintTel];
    complaintTel.sd_layout.leftSpaceToView(comPlainScrView,0).rightSpaceToView(comPlainScrView,0).topSpaceToView(complaintPhone,0).heightIs(20);
    /*! 确认提交按钮 */
    submitBtn = [UIButton new];
    [submitBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = UIFontSystem16;
    [submitBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    submitBtn.backgroundColor = UIColorRedTheme;
    submitBtn.layer.cornerRadius = 5;
    [submitBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [submitBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [comPlainScrView addSubview:submitBtn];
    submitBtn.sd_layout.leftSpaceToView(comPlainScrView,25).topSpaceToView(complaintTel,60).rightSpaceToView(comPlainScrView,25).heightIs(42);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.userNameFeild resignFirstResponder];
    [self.phoneNumFeild resignFirstResponder];
    [self.complainFeild resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""]) {
        placeholderLable.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        placeholderLable.hidden = NO;
    }
    return YES;
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

#pragma mark -确认提交
-(void)submitClick:(UIButton *)sender
{
    if (self.userNameFeild.text.length==0) {
        [HXProgressHUD showMessage:comPlainScrView
                         labelText:@"请输入用户名"
                              mode:MBProgressHUDModeText];
        return;
    }
    if (self.phoneNumFeild.text.length==0) {
        [HXProgressHUD showMessage:comPlainScrView
                         labelText:@"请输入联系方式"
                              mode:MBProgressHUDModeText];
        return;
    }
    if ([UtilityFunction isMobileNumber:self.phoneNumFeild.text]==NO) {
        [HXProgressHUD showMessage:self.view labelText:@"请输入正确手机号" mode:MBProgressHUDModeText];
        return;
    }

    if (self.complainFeild.text.length==0) {
        [HXProgressHUD showMessage:comPlainScrView
                         labelText:@"请输入反馈信息"
                              mode:MBProgressHUDModeText];
        return;
    }
    [self gaintComplain];
}


#pragma mark - 投诉反馈网络请求
-(void)gaintComplain
{
    [HXLoadingView show];
    ComplaintRequestModel *model = [[ComplaintRequestModel alloc]init];
    model.user_login = USERNAME;
    model.username = self.userNameFeild.text;
    model.phone = self.phoneNumFeild.text;
    model.content = self.complainFeild.text;
    model.phone_type = [UtilityFunction gaintDeviceName];
    model.client_type = [UtilityFunction gaintDeviceVersion];
    model.client_version = [UtilityFunction gaintVersion];
    NSDictionary *dict = [model mj_keyValues];

    [[HXNetClient sharedInstance]NetRequestPOSTMoreImgWithRequestURL:@"app/ComplainFeedback" WithParameter:dict WithUpLoadImg:self.imageArray WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [HXProgressHUD showMessage:comPlainScrView
                             labelText:responseDict[@"msg"]
                                  mode:MBProgressHUDModeText];
            [HXLoadingView hide];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [HXProgressHUD showMessage:comPlainScrView
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
