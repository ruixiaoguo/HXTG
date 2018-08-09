//
//  HXServerDetailController.m
//  HXTG
//
//  Created by grx on 2017/4/1.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXServerDetailController.h"
#import "IMYWebView.h"

@interface HXServerDetailController ()<IMYWebViewDelegate>{
    IMYWebView *webView;
}

@end

@implementation HXServerDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务协议";
    self.backButton.hidden = NO;
    self.view.backgroundColor = UIColorBgLightTheme;
    /*! 创建网页 */
    webView = [IMYWebView new] ;
    webView.delegate = self;
    [self.view addSubview:webView] ;
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]] ;
    webView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,10).heightIs(Main_Screen_Height);
    [HXLoadingView show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [HXLoadingView hide];
}

- (void)webView:(IMYWebView*)webView didFailLoadWithError:(NSError*)error
{
    [HXLoadingView hide];
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
