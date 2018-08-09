//
//  HXSpecDetailController.m
//  HXTG
//
//  Created by grx on 2017/3/24.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXSpecDetailController.h"
#import "HXSpecHeadView.h"
#import "SpecInfoRequestModel.h"
#import "IMYWebView.h"

@interface HXSpecDetailController ()<IMYWebViewDelegate>{
    HXSpecHeadView *headView;
    IMYWebView *specDetailWebView;
    UIView *tipView;
    UILabel *teachTime;
    UILabel *teachName;
    UILabel *legionName;
    UILabel *teachNum;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HXSpecDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.view.backgroundColor = UIColorWhite;
    self.title = self.model.post_title;
    /*! 创建广播层 */
    [self creatRadio];
    /*! 添加web网页 */
    [self addWebView];
    /*! 炒股攻略头部 */
    [self addHeadView];
    /*! 网络请求 */
    [self gaintSpeculationInfo];
}

- (void)addWebView
{
    specDetailWebView = [IMYWebView new];
    specDetailWebView.frame = CGRectMake(0, CGRectGetMaxY(tipView.frame), Main_Screen_Width, Main_Screen_Height-104);
    specDetailWebView.delegate = self;
    specDetailWebView.scrollView.contentInset = UIEdgeInsetsMake(Main_Screen_Height*0.08+38, 0, 0, 0);
    specDetailWebView.scrollView.contentOffset = CGPointMake(0, -Main_Screen_Height*0.08-38);
    specDetailWebView.opaque = NO;
    [specDetailWebView setScalesPageToFit:YES];
    [self.view addSubview:specDetailWebView];
}

-(void)addHeadView
{
    
    headView = [[HXSpecHeadView alloc]initWithFrame:CGRectMake(0, -Main_Screen_Height*0.08-38, Main_Screen_Width, Main_Screen_Height*0.08+38)];
    headView.model = self.model;
    [specDetailWebView.scrollView addSubview:headView];
    /*! 老师信息 */
    UIView *teachBgView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headView.timeLable.frame)+32, Main_Screen_Width, 35)];
    teachBgView.backgroundColor = UIColorBgLightTheme;
    /*! 老师名称 */
    teachName = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 58, 30)];
    teachName.font = UIFontSystem13;
    teachName.textColor = UIColorLightTheme;
    [teachBgView addSubview:teachName];

    /*! 军团名称 */
    legionName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(teachName.frame), 5, 60, 30)];
    legionName.font = UIFontSystem13;
    legionName.textColor = UIColorLightTheme;
    [teachBgView addSubview:legionName];

    /*! 资格证号 */
    teachNum = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(legionName.frame)+5, 5, Main_Screen_Width-160-30, 30)];
    teachNum.font = UIFontSystem13;
    teachNum.textColor = UIColorLightTheme;
    [teachBgView addSubview:teachNum];
    /*! 当前时间 */
    teachTime = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-135 , 5, 125, 30) ];
    teachTime.font = UIFontSystem13;
    teachTime.textColor = UIColorLightTheme;
    teachTime.textAlignment = NSTextAlignmentRight;
    [teachBgView addSubview:teachTime];
    [headView addSubview:teachBgView];
    
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
    
    NSString *injectionJSString = [NSString stringWithFormat:@"var script = document.createElement('meta');"
                                   "script.name = 'viewport';"
                                   "script.content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0,user-scalable=no\";"
                                   "document.getElementsByTagName('head')[0].appendChild(script);"
                                   "document.documentElement.style.webkitTouchCallout = \"none\";"
                                   "document.documentElement.style.webkitUserSelect = \"none\";"
                                   "window.scrollBy(0, 0);"];
    [webView stringByEvaluatingJavaScriptFromString:injectionJSString];
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 300.0;" // UIWebView中显示的图片宽度
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    [HXLoadingView hide];
}



-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 网络请求获取炒股攻略详情
-(void)gaintSpeculationInfo
{
    SpecInfoRequestModel *model = [[SpecInfoRequestModel alloc]init];
    model.post_id = self.model.post_id;
    NSDictionary *dict = [model mj_keyValues];
    [HXLoadingView show];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/SpeculationInfo" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            NSDictionary *dic = responseDict[@"data"];
            NSString *reasonStr = dic[@"post_content"];
            [specDetailWebView loadHTMLString:reasonStr baseURL:nil];
            teachTime.text = [NSString stringWithFormat:@"%@",dic[@"post_date"]];
            teachName.text = [NSString stringWithFormat:@"%@",dic[@"post_author"]];
            legionName.text = [NSString stringWithFormat:@"%@",dic[@"lrving_name"]];
            teachNum.text = [NSString stringWithFormat:@"%@",dic[@"card_num"]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
