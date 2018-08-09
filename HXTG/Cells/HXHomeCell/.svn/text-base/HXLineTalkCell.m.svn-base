//
//  HXLineTalkCell.m
//  HXTG
//
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXLineTalkCell.h"
#import "HXCountDownButotn.h"

@implementation HXLineTalkCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorWhite;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self markCell];
    }
    return self;
}

-(void)markCell
{
    /*! 姓名/身份证/手机号/验证码/ */
    NSArray *infoArray = @[@"您的姓名：",@"身份证号码：",@"手机号码：",@"验证码："];
    NSArray *placehArray = @[@"请输入您的姓名",@"请输入身份证号码",@"请输入手机号",@"请输入验证码"];

    for (int i=0; i<4; i++) {
        UILabel *titleLable = [UILabel new];
        titleLable.textColor = UIColorBlackTheme;
        titleLable.font = UIFontSystem14;
        titleLable.text = infoArray[i];
        titleLable.tag = i+100;
        [self.contentView addSubview:titleLable];
        titleLable.sd_layout.leftSpaceToView(self.contentView,14).topSpaceToView(self.contentView,8+i*40).widthIs(86).heightIs(35);
        /*! 分割线 */
        UIView *lineViwe = [UIView new];
        lineViwe.backgroundColor = UIColorBgLightTheme;
        [self.contentView addSubview:lineViwe];
        lineViwe.sd_layout.leftSpaceToView(self.contentView,14).rightSpaceToView(self.contentView,14).topSpaceToView(titleLable,0).heightIs(1);
        /*! 输入框 */
        self.talkFeild = [UITextField new];
        self.talkFeild.font = UIFontSystem14;
        self.talkFeild.placeholder = placehArray[i];
        [self.talkFeild setValue:UIFontSystem14 forKeyPath:@"_placeholderLabel.font"];
        self.talkFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.talkFeild.tag = i+10;
        [self.talkFeild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:self.talkFeild];
        self.talkFeild.sd_layout.leftSpaceToView(titleLable,0).rightSpaceToView(self.contentView,14).topSpaceToView(self.contentView,8+i*40).heightIs(35);
        if (self.talkFeild.tag==13) {
            self.talkFeild.sd_layout.leftSpaceToView(titleLable,0).rightSpaceToView(self.contentView,100).topSpaceToView(self.contentView,8+i*40).heightIs(35);
            /*! 分割线 */
            UIView *lineView = [UIView new];
            [self.contentView addSubview:lineView];
            lineView.backgroundColor = UIColorBgLightTheme;
            UITextField *feild = (UITextField *)[self.contentView viewWithTag:12];
            lineView.sd_layout.rightSpaceToView(self.contentView,90).topSpaceToView(feild,9).widthIs(1).heightIs(self.contentView.frame.size.height-20);
            /*! SNS验证 */
            [self senderSNS:self.contentView];
        }
    }
    
    /*! 创建期望日期标题 */
    UILabel *expectLable = [UILabel new];
    expectLable.textColor = UIColorBlackTheme;
    expectLable.font = UIFontSystem14;
    expectLable.text = @"期望日期：";
    [self.contentView addSubview:expectLable];
    UILabel *yzText = (UILabel *)[self.contentView viewWithTag:103];
    expectLable.sd_layout.leftSpaceToView(self.contentView,14).topSpaceToView(yzText,5).widthIs(86).heightIs(35);
    /*! 期望日期选择器 */
    self.expectFeild = [UILabel new];
    self.expectFeild.font = UIFontSystem14;
    self.expectFeild.textColor = UIColorLineTheme;
    self.expectFeild.userInteractionEnabled=YES;
    self.expectFeild.text = @"请选择期望日期";
    [self.contentView addSubview:self.expectFeild];
    UITextField *feild = (UITextField *)[self.contentView viewWithTag:13];
    self.expectFeild.sd_layout.leftSpaceToView(expectLable,0).rightSpaceToView(self.contentView,14).topSpaceToView(feild,5).heightIs(35);
    /*! 期望日期分割线 */
    UIView *lineview = [UIView new];
    lineview.backgroundColor = UIColorBgLightTheme;
    [self.contentView addSubview:lineview];
    lineview.sd_layout.leftSpaceToView(self.contentView,14).rightSpaceToView(self.contentView,14).topSpaceToView(expectLable,0).heightIs(1);
    /*! 手势 */
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expectFeildClickTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self.expectFeild addGestureRecognizer:singleRecognizer];
    /*! 创建留言 */
    UILabel *messageLable = [UILabel new];
    messageLable.textColor = UIColorBlackTheme;
    messageLable.font = UIFontSystem14;
    messageLable.text = @"留言：";
    [self.contentView addSubview:messageLable];
    messageLable.sd_layout.leftSpaceToView(self.contentView,14).topSpaceToView(expectLable,2).widthIs(86).heightIs(35);
    /*! 留言输入框 */
    self.messageFeild = [UITextView new];
    self.messageFeild.font = UIFontSystem14;
    self.messageFeild.textColor = UIColorBlackTheme;
    self.messageFeild.layer.borderWidth = 1;
    self.messageFeild.layer.cornerRadius = 5;
    self.messageFeild.delegate = self;
    self.messageFeild.layer.borderColor = UIColorLineTheme.CGColor;
    [self.contentView addSubview:self.messageFeild];
    self.messageFeild.sd_layout.leftEqualToView(messageLable).rightSpaceToView(self.contentView,14).topSpaceToView(messageLable,0).heightIs(100);
    placeholderLable = [UILabel new];
    placeholderLable.text = @"请输入留言,300字以内";
    placeholderLable.font = UIFontSystem14;
    placeholderLable.textColor = UIColorLineTheme;
    [self.messageFeild addSubview:placeholderLable];
    placeholderLable.sd_layout.leftSpaceToView(self.messageFeild,5).topSpaceToView(self.messageFeild,2).widthIs(200).heightIs(30);
    /*! 提交申请按钮 */
    UIView *bgView = [UIView new];
    bgView.backgroundColor = UIColorBgLightTheme;
    [self.contentView addSubview:bgView];
    bgView.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.messageFeild,10).rightSpaceToView(self.contentView,0).heightIs(120);

    submitBtn = [UIButton new];
    [submitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = UIFontSystem16;
    [submitBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    submitBtn.backgroundColor = UIColorLineTheme;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.enabled = NO;
    [submitBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [submitBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:submitBtn];
    submitBtn.sd_layout.leftSpaceToView(bgView,25).topSpaceToView(bgView,40).rightSpaceToView(bgView,25).heightIs(40);
    
}


-(void)expectFeildClickTap:(UITapGestureRecognizer *)recognizer
{
    
    if (_datePickview.frame.origin.y>=Main_Screen_Height || !_datePickview) {
        _datePickview=[[HXDatePickView alloc] initDatePickWithDate:nil datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _datePickview.delegate=self;
        [_datePickview show];
    }
}

#pragma mark -ZKPickViewDelegate
-(void)toobarDonBtnHaveClick:(HXDatePickView *)pickView resultString:(NSString *)resultString
{
    self.expectFeild.text = [resultString substringToIndex:10];
    self.expectFeild.textColor = UIColorBlackTheme;

}

-(void)senderSNS:(UIView *)superView
{
    UITextField *mobileField = (UITextField *)[self.contentView viewWithTag:12];
    HXCountDownButotn *button = [HXCountDownButotn buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:ColorWithRGB(41, 142, 251) forState:UIControlStateNormal];
    [superView addSubview:button];
    button.sd_layout.rightSpaceToView(superView,5).topSpaceToView(mobileField,2).heightIs(self.contentView.frame.size.height-6).widthIs(89);
    [button addToucheHandler:^(HXCountDownButotn*sender, NSInteger tag) {
        /*! 验证手机号 */
        if ([UtilityFunction isMobileNumber:mobileField.text]==NO) {
            [HXProgressHUD showMessage:self.contentView.superview labelText:@"请输入正确手机号" mode:MBProgressHUDModeText];
            return;
        }
        /*! 发送短信验证码 */
        registmanager = [[RegistRequestManager alloc] init];
        __weak typeof(self) weakSelf = self;
        [registmanager setBlockWithReturnBlock:^(id returnValue) {
            NSString *states = [NSString stringWithFormat:@"%@",returnValue[@"status"]];
            if ([states isEqualToString:@"1"]) {
                [sender startWithSecond:60.0];
                [HXLoadingView hide];
            }else{
                [HXProgressHUD showMessage:weakSelf.contentView.superview labelText:returnValue[@"msg"] mode:MBProgressHUDModeText];
                [HXLoadingView hide];
            }
        } WithErrorBlock:^(id errorCode) {
            [HXLoadingView hide];
            [HXProgressHUD showMessage:weakSelf.contentView.superview labelText:@"发送失败" mode:MBProgressHUDModeText];
        } WithFailureBlock:^{
            DDLog(@"网络异常");
        }];
        
        NSDictionary *parameter = @{@"mobile": mobileField.text,@"type":@"2"};
        /*! 发送短信验证码 */
        [registmanager requestSendSNSInterface:parameter];
        [HXLoadingView show];
        [sender didChange:^NSString *(HXCountDownButotn *countDownButton,int second) {
            
            [sender setTitleColor:ColorWithRGB(178,178,178) forState:UIControlStateNormal];
            NSString *title = [NSString stringWithFormat:@"倒计时%ds",second];
            sender.enabled = NO;
            return title;
        }];
        [sender didFinished:^NSString *(HXCountDownButotn *countDownButton, int second) {
            [sender setTitleColor:ColorWithRGB(41, 142, 251) forState:UIControlStateNormal];
            sender.enabled = YES;
            return @"获取验证码";
        }];
    }];
}

#pragma mark - 用户提交申请事件
-(void)submitClick
{
    UITextField *idCartfield = (UITextField *)[self.contentView viewWithTag:11];
    UITextField *yzfield = (UITextField *)[self.contentView viewWithTag:13];
    if ([UtilityFunction verifyIDCardNumber:idCartfield.text]==NO) {
        [HXProgressHUD showMessage:self.contentView.superview labelText:@"身份证号不合法" mode:MBProgressHUDModeText];
        return;
    }
    if (self.expectFeild.text.length==0||[self.expectFeild.text isEqualToString:@"请选择期望日期"]) {
        [HXProgressHUD showMessage:self.contentView.superview labelText:@"请选择日期" mode:MBProgressHUDModeText];
        return;
    }
    if (self.messageFeild.text.length==0) {
        [HXProgressHUD showMessage:self.contentView.superview labelText:@"请输入留言" mode:MBProgressHUDModeText];
        return;
    }
    
    /*! 验证短信验证码 */
    registmanager = [[RegistRequestManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [registmanager setBlockWithReturnBlock:^(id returnValue) {
        DDLog(@"returnValue======%@",returnValue);
        NSString *states = [NSString stringWithFormat:@"%@",returnValue[@"status"]];
        if ([states isEqualToString:@"1"]) {
            /*! 提交申请 */
            [weakSelf gaintLineTalkList];
        }else{
            [HXProgressHUD showMessage:weakSelf.contentView.superview labelText:returnValue[@"msg"] mode:MBProgressHUDModeText];
            [HXLoadingView hide];
        }
    } WithErrorBlock:^(id errorCode) {
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];
    NSDictionary *parameter = @{@"code": yzfield.text};
    /*! 验证短信验证码 */
    [registmanager requestCheckSNSInterface:parameter];
}


#pragma mark - 输入框输入结束后焦点
- (void) textFieldDidChange:(id) sender {
    UITextField *userfield = (UITextField *)[self.contentView viewWithTag:10];
    UITextField *idCartfield = (UITextField *)[self.contentView viewWithTag:11];
    UITextField *phonefield = (UITextField *)[self.contentView viewWithTag:12];
    UITextField *yzfield = (UITextField *)[self.contentView viewWithTag:13];

    if (![[userfield text] isEqual:@""] && ![[idCartfield text] isEqual:@""]&& ![[phonefield text] isEqual:@""]&& ![[yzfield text] isEqual:@""]) {
            [submitBtn setBackgroundColor:UIColorRedTheme];
            submitBtn.enabled=YES;
        }else{
            [submitBtn setBackgroundColor:UIColorLineTheme];
            submitBtn.enabled=NO;
        }
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

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.keyBoadShow) {
        self.keyBoadShow();
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

#pragma mark - 提交申请网络请求
-(void)gaintLineTalkList
{
    UITextField *userfield = (UITextField *)[self.contentView viewWithTag:10];
    UITextField *idCartfield = (UITextField *)[self.contentView viewWithTag:11];
    UITextField *phonefield = (UITextField *)[self.contentView viewWithTag:12];
    OfflineTalksReqModel *model = [[OfflineTalksReqModel alloc]init];
    model.user_id = USERID;
    model.realname = userfield.text;
    model.carded = idCartfield.text;
    model.telphone = phonefield.text;
    model.message = self.messageFeild.text;
    model.talk_time = self.expectFeild.text;
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"app/OfflineTalks" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {    [HXLoadingView show];
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [HXProgressHUD showMessage:self.contentView.superview
                             labelText:responseDict[@"msg"]
                                  mode:MBProgressHUDModeText];
             [HXLoadingView hide];
            if (self.popToUpViewController) {
                self.popToUpViewController();
            }
        }else{
            [HXProgressHUD showMessage:self.contentView.superview
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

@end
