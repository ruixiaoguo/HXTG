//
//  HXAboutUsWebController.m
//  HXTG
//
//  Created by grx on 2017/4/20.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXAboutUsWebController.h"
#import "IMYWebView.h"

@interface HXAboutUsWebController ()<IMYWebViewDelegate>{
    IMYWebView *webView;
}

@end

@implementation HXAboutUsWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.navigationItem.title = @"关于我们";
    webView = [IMYWebView new] ;
    webView.delegate = self;
    [self.view addSubview:webView] ;
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:HXAboutUsHtmlUrl]]] ;
    DDLog(@"===%@",HXAboutUsHtmlUrl);
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
