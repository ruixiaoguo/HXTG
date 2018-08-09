//
//  MMChatViewController.m
//  HXTG
//
//  Created by grx on 2017/2/28.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXChatViewController.h"
#import <RongIMKit/RongIMKit.h> /*! 融云 */
#import "HXGetMsgReqModel.h"
#import "HomeRequestModel.h"

@implementation HXChatViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*! 清除融云消息小红点 */
    [StandardUserDefaults setBool:NO forKey:@"isRYChatMessage"];
    /*! 广播层 */
    UIView *tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 42)];
    tipView.backgroundColor = UIColorBgLightTheme;
    [self.view addSubview:tipView];
    UIImageView *hornImage = [[UIImageView alloc]initWithFrame:CGRectMake(8, 11, 22, 19)];
    hornImage.image = [UIImage imageNamed:@"tongzhi"];
    [tipView addSubview:hornImage];
    UILabel *tipLable = [[UILabel alloc]initWithFrame:CGRectMake(38, 0, Main_Screen_Width-110, 42)];
    tipLable.font = UIFontSystem12;
    tipLable.textColor = UIColorRedTheme;
    tipLable.text = @"风险提示：本投顾产品投资建议仅供参考，不作为客户投资决策依据。客户须审慎独立作出投资决策，自行承担投资风险>>";
    [tipView addSubview:tipLable];
    UILabel *checkLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-80, 0, 72, 42)];
    checkLable.font = UIFontSystem12;
    checkLable.textColor = UIColorRedTheme;
    checkLable.textAlignment = NSTextAlignmentRight;
    checkLable.text = @"查看详情>>";
    [tipView addSubview:checkLable];
    /*! 手势 */
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipViewClickTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [tipView addGestureRecognizer:singleRecognizer];

    self.conversationMessageCollectionView.frame = CGRectMake(0, 106, Main_Screen_Width, Main_Screen_Height);
    self.conversationMessageCollectionView.backgroundColor = UIColorWhite;
    // 设置头像类型(圆角，默认是矩形边角)
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    /*! 自定义返回 */
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"home_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *backSpacer = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                   target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    backSpacer.width = -15;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:backSpacer,backItem,nil];
    [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlDefaultType style:RC_CHAT_INPUT_BAR_STYLE_CONTAINER];
    /*! 获取用户信息 */
    [self getUserInfoWithUserID:self.targetId];
   
}

- (void)didSendMessage:(NSInteger)stauts content:(RCMessageContent *)messageCotent
{
    if (stauts==0) {
        msg = (RCTextMessage *)messageCotent;
        [self gaintGetMsg:msg.content withName:gaintUserName];
    }
}

- (void)didTapCellPortrait:(NSString *)userId
{
    
    if (![userId isEqualToString:USERID]&&![userId isEqualToString:@"81"]) {
        NSString *str = [NSString stringWithFormat:@"投顾姓名：%@\n投顾资格证号：%@\n投诉电话：010-53821559",teachName,teachNum];
        HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"投顾介绍" contentText:str centerButtonTitle:@"我知道了"];
        alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
        [self setLabelSpace:alter.alertContentLabel withValue:str withFont:UIFontSystem14];
        alter.centerBlock=^()
        {
            
        };
        [alter show];
    }
}

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    /*! 设置行间距 */
    paraStyle.lineSpacing = 5;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    /*! 设置字间距 NSKernAttributeName:@1.5f */
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

#pragma mark - 广播层手势事件
-(void)tipViewClickTap:(UITapGestureRecognizer *)recognizer
{
    HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"风险提示" contentText:@"本投顾产品投资建议仅供参考，不作为客户投资决策依据。客户须审慎独立作出投资决策，自行承担投资风险。\n投诉热线: 010-53821559" centerButtonTitle:@"我知道了"];
    alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
    alter.centerBlock=^()
    {
        
    };
    [alter show];
}


#pragma mark - 获取接收者个人基本信息
- (void)getUserInfoWithUserID:(NSString *)sendId {
    
    HomeRequestModel *model = [[HomeRequestModel alloc]init];
    model.send_id = sendId;
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/getUserName" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            NSString *username = [NSString stringWithFormat:@"%@",responseDict[@"user_login"]];
            gaintUserName = username;
        }else{
            
            gaintUserName = @"";
        }
        /*! 获取当前军团信息 */
        [self getFindLegionWithUserID:USERID targetId:self.targetId];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        /*! 获取当前军团信息 */
        [self getFindLegionWithUserID:USERID targetId:self.targetId];
    } WithFailureBlock:^{
        /*! 获取当前军团信息 */
        [self getFindLegionWithUserID:USERID targetId:self.targetId];
    }];
}

#pragma mark - 获取当前用户的军团信息
- (void)getFindLegionWithUserID:(NSString *)userId targetId:(NSString *)targetId {
    
    HomeRequestModel *model = [[HomeRequestModel alloc]init];
    model.user_id = userId;
    model.lrving_id = targetId;
    NSDictionary *dict = [model mj_keyValues];
    [HXLoadingView show];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"User/FindLegion" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];

        if ([status isEqualToString:@"1"]) {
            gaintLegionId = [NSString stringWithFormat:@"%@",responseDict[@"data"][@"lid"]];
            gaintLegionName = [NSString stringWithFormat:@"%@",responseDict[@"data"][@"lrving_name"]];
            techId = [NSString stringWithFormat:@"%@",responseDict[@"data"][@"tech_id"]];
            teachNum = [NSString stringWithFormat:@"%@",responseDict[@"card_number"]];
            teachName = [NSString stringWithFormat:@"%@",responseDict[@"user_nicename"]];
            if ([self.targetId isEqualToString:@"81"]) {
                self.title = @"在线客服";
            }else{
                self.title = [NSString stringWithFormat:@"%@-%@老师",gaintLegionName,teachName];
//                self.targetId = techId;
            }
            [HXLoadingView hide];
        }else{
            if ([self.targetId isEqualToString:@"81"]) {
                self.title = @"在线客服";
            }
            gaintLegionId = @"";
            gaintLegionName = @"";
            if (![self.targetId isEqualToString:@"81"]) {
                self.targetId = @"57";
                self.title = @"问老师";
            }
            [HXLoadingView hide];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];

    } WithFailureBlock:^{
        [HXLoadingView hide];

    }];
}


#pragma mark - 上传用户发送信息
-(void)gaintGetMsg:(NSString *)content withName:(NSString *)name
{
    HXGetMsgReqModel *model = [[HXGetMsgReqModel alloc]init];
    model.legion_id = gaintLegionId;
    model.sender = USERNAME;
    model.send_content = content;
    if ([self.targetId isEqualToString:@"81"]) {
        model.receiver = @"kefu";
    }else{
        model.receiver = name;
    }
    model.type = @"1";
    model.carder = name;
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/getMsg" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        DDLog(@"responseDict======%@",responseDict);
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
    } WithFailureBlock:^{
        
    }];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
