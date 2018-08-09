//
//  HXPlayViewController.m
//  HXTG
//
//  Created by grx on 2017/4/20.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXPlayViewController.h"
#import "GUIPlayerView.h"

@interface HXPlayViewController ()<GUIPlayerViewDelegate>{
    GUIPlayerView *_playerView;
}

@end

@implementation HXPlayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    if ([self.plarInfo[@"url"] hasSuffix:@".pdf"]) {
        // 提示
        [HXProgressHUD showMessage:self.view labelText:@"加载本地PDF" mode:MBProgressHUDModeText];
        // pdf
        self.navigationItem.title = self.plarInfo[@"title"];
        UIWebView *webView= [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64)];
        NSURL *url = [NSURL fileURLWithPath:HSFileFullpath(self.plarInfo)];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }else{
        // mp4
        [self AVPlayer];
        
    }
}
#pragma mark -- UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    });
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [HXProgressHUD showMessage:self.view labelText:@"文件损坏!" mode:MBProgressHUDModeText];

}
// 播放器
- (void)AVPlayer{
    // 1.创建视频播放视图
    _playerView = [[GUIPlayerView alloc] initWithFrame:CGRectMake(0, 40, Main_Screen_Width, 180)];
    _playerView.coverImageView.hidden = YES;
    _playerView.firstPlayButton.hidden = YES;
    _playerView.downLoadBtn.hidden = YES;
    _playerView.delegate = self;
    // 播放第一节课的内容
    _playerView.videoTitle = self.plarInfo[@"title"];
    _playerView.videoURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",HSFileFullpath(self.plarInfo)]];
    
    [self playerWillEnterFullscreen];
    [self.view addSubview:_playerView];
    // 设置视频自动播放
    [_playerView prepareAndPlayAutomatically:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _playerView.benDi = YES;
    });
}
#pragma mark - GUIPlayerViewDelegate
- (void)playerWillEnterFullscreen {
    [[self navigationController] setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)playerWillLeaveFullscreen {
    [[self navigationController] setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)playerDidEndPlaying {
    [_playerView stop];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)playerFailedToPlayToEnd {
//    [HXProgressHUD showMessage:self.view labelText:@"加载失败,请重新加载" mode:MBProgressHUDModeText];
//    [_playerView stop];
    [_playerView prepareAndPlayAutomatically:YES];

}
#pragma mark - 视图离开的时候
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_playerView stop];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 按钮事件
- (void)backAction:(UIButton*)button{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [_playerView clean];
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
