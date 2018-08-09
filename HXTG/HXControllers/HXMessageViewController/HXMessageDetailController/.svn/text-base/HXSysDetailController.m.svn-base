//
//  HXSysDetailController.m
//  HXTG
//
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXSysDetailController.h"
#import "IMYWebView.h"
#import "HXSpecHeadView.h"
#import "JPUSHService.h"

@interface HXSysDetailController ()<IMYWebViewDelegate>{
    UIView *tipView;
    HXSpecHeadView *headView;
}

@property(nonatomic,strong) IMYWebView *detailWebView;

@end

@implementation HXSysDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    [HXLoadingView show];
    if ([self.title isEqualToString:@"服务消息"]) {
        /*! 清除服务消息小红点 */
        [StandardUserDefaults setBool:NO forKey:@"isServerMessage"];
        /*! 清除icon计数 */
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        [JPUSHService setBadge:0];
    }else{
        /*! 清除官方消息小红点 */
        [StandardUserDefaults setBool:NO forKey:@"isOfficialMessage"];
        /*! 清除icon计数 */
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        [JPUSHService setBadge:0];
        
    }

    /*! 创建广播层 */
    [self creatRadio];
    /*! 添加web网页 */
    [self addWebView];
}

- (void)addWebView
{
    self.detailWebView = [IMYWebView new];
    self.detailWebView.frame = CGRectMake(0, CGRectGetMaxY(tipView.frame), Main_Screen_Width, Main_Screen_Height-104);
    self.detailWebView.delegate = self;
    NSString *htmlUrl;
    if ([self.title isEqualToString:@"服务消息"]) {
        htmlUrl = [NSString stringWithFormat:@"%@About/Notice_H5/business_id/%@/user_id/%@/type/%@/",HXBASEURL,USERBUSINESSID,USERID,@"3"];
    }else{
        htmlUrl = [NSString stringWithFormat:@"%@About/Notice_H5/business_id/%@/user_id/%@/type/%@/",HXBASEURL,USERBUSINESSID,USERID,@"1"];
    }

    [self.detailWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:htmlUrl]]] ;
    [self.view addSubview:self.detailWebView];
}


#pragma mark - =============创建广播层=============
-(void)creatRadio
{
    /*! 广播层 */
    tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 40)];
    tipView.backgroundColor = UIColorBgLightTheme;
    [self.view addSubview:tipView];
    UIImageView *hornImage = [[UIImageView alloc]initWithFrame:CGRectMake(8, 11, 22, 19)];
    hornImage.image = [UIImage imageNamed:@"tongzhi"];
    [tipView addSubview:hornImage];
    UILabel *tipLable = [[UILabel alloc]initWithFrame:CGRectMake(38, 0, Main_Screen_Width-110, 40)];
    tipLable.font = UIFontSystem12;
    tipLable.textColor = UIColorRedTheme;
    tipLable.text = @"风险提示：本投顾产品投资建议仅供参考，不作为客户投资决策依据。客户须审慎独立作出投资决策，自行承担投资风险>>";
    [tipView addSubview:tipLable];
    UILabel *checkLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-80, 0, 72, 40)];
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
}


#pragma mark - ================加载完成======================
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [HXLoadingView hide];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
