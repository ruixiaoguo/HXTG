//
//  HXEveDayStockController.m
//  HXTG
//
//  Created by grx on 2017/3/24.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXEveDayStockController.h"
#import "HXEveDayHeadView.h"
#import "StockInfoRequestModel.h"
#import "HXDayStockInfoModel.h"
#import "IMYWebView.h"
#import "HXDailystockModel.h"

@interface HXEveDayStockController ()<IMYWebViewDelegate>{
    HXEveDayHeadView *headView;
    IMYWebView *eveDayWebView;
    UIView *tipView;
    UIView *teacherBgView;
    UILabel *warlyTitle;
    UILabel *teachTime;
    UILabel *teachName;
    UILabel *legionName;
    UILabel *teachNum;
}

@property (nonatomic,strong) NSMutableArray *reasionArray;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HXEveDayStockController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.title = @"每日一股";
    self.view.backgroundColor = UIColorWhite;
    self.reasionArray = [NSMutableArray arrayWithCapacity:0];
    /*! 创建广播层 */
    [self creatRadio];
    /*! 推荐理由详情Web网页 */
    [self addWebView];
    /*! 每日一股头部 */
    [self addHeadView];
    /*! 网络请求 */
    [self gaintStockdayInfo];
}

- (void)addWebView
{
    eveDayWebView = [IMYWebView new];
    eveDayWebView.frame = CGRectMake(0, CGRectGetMaxY(tipView.frame), Main_Screen_Width, Main_Screen_Height-104);
    eveDayWebView.delegate = self;
    eveDayWebView.scrollView.contentInset = UIEdgeInsetsMake(136+35, 0, 0, 0);
    eveDayWebView.scrollView.contentOffset = CGPointMake(0, -136-35);
    eveDayWebView.opaque = NO;
    [eveDayWebView setScalesPageToFit:YES];
    [self.view addSubview:eveDayWebView];
    DDLog(@"Main_Screen_Height====%f",Main_Screen_Height*0.24);
}

-(void)addHeadView
{
    headView = [[HXEveDayHeadView alloc]initWithFrame:CGRectMake(0, -136-35, Main_Screen_Width, 136+33)];
//    headView.model = self.model;
    [eveDayWebView.scrollView addSubview:headView];
    /*! 老师信息 */
    UIView *teachBgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipView.frame), Main_Screen_Width, 35)];
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
    teachTime = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-50 , 5, 40, 30)];
    teachTime.font = UIFontSystem13;
    teachTime.textColor = UIColorLightTheme;
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

#pragma mark - 网络请求获取每日一股详情
-(void)gaintStockdayInfo
{
    
    StockInfoRequestModel *model = [[StockInfoRequestModel alloc]init];
    model.shares_id = self.model.shares_id;
    NSDictionary *dict = [model mj_keyValues];
    [HXLoadingView show];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/StockdayInfo" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            NSDictionary *dic = responseDict[@"data"];
            NSString *reasonStr = dic[@"shares_reason"];
            [eveDayWebView loadHTMLString:reasonStr baseURL:nil];
            teachTime.text = [NSString stringWithFormat:@"%@",dic[@"shares_addtime"]];
            teachName.text = [NSString stringWithFormat:@"%@",dic[@"post_author"]];
            legionName.text = [NSString stringWithFormat:@"%@",dic[@"lrving_name"]];
            teachNum.text = [NSString stringWithFormat:@"%@",dic[@"card_num"]];
            
            HXDailystockModel *model = [HXDailystockModel mj_objectWithKeyValues:dic];
            headView.model = model;

            [HXLoadingView hide];
            
        }else{
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


@end
