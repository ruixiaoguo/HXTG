//
//  HXGPlayerViewController.m
//  HXTG
//
//  Created by grx on 2017/2/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXGPlayerViewController.h"
#import "HXLiveHistoryController.h"
#import "LiveHistoryReqModel.h"
//<GSPPlayerManagerDelegate,GSPDocViewDelegate>
@interface HXGPlayerViewController ()<GUIPlayerViewDelegate,UIScrollViewDelegate>{
    NSDictionary *downLoadDict;
    CGRect videoViewRect;//记录videoView的原始尺寸
    BOOL hasOrientation;
    BOOL isSegment;
    UIView *segmentLine;
    UIView *segmentView;
    UIButton *fullScreenBtn;
    HXLiveHistoryController *pastLiveView;
    UIScrollView *segentScrollView;
//    GSPChatInputToolView *inputView;
    BOOL isHaveLive;  /*! 是否正在直播 */
//    GSPJoinParam *joinParm;
}

//@property (nonatomic,strong) GSPChatView *chatView;
//@property (nonatomic,strong) GSPVideoView *videoView;
@property (nonatomic,strong) GUIPlayerView *playerView;
@property (nonatomic,strong) HXLiveHistoryModel *firstModel;/*! 第一条数据 */
@property (nonatomic,strong) HXLiveHistoryModel *currenModel;/*! 当前数据 */

@end

@implementation HXGPlayerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = UIColorBgLightTheme;
//    self.backButton.hidden = NO;
//    hasOrientation = NO;
//    isSegment = NO;
//    self.title = @"直播解盘";
//    
//    /*! =============================点播播放器================================== */
//    [self AVPlayer];
//    /*! 进入前台后台事件监听 */
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(enterBackground)
//                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(becomeActive)
//                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
//    /*! =============================直播播放器================================== */
//    self.playerManager = [GSPPlayerManager sharedManager];
//    if (!self.playerManager) {
//        self.playerManager = [GSPPlayerManager new];
//    }
//    self.playerManager.delegate = self;
//    [self.playerManager enableVideo:YES];
//    [self.playerManager enableAudio:YES];
//    joinParm = [GSPJoinParam new];
//    joinParm.domain = @"hxbj.gensee.com";
//    joinParm.serviceType = GSPServiceTypeWebcast;
//    joinParm.roomNumber = @"05650506";
//    joinParm.nickName = USERNAME;
//    joinParm.watchPassword = @"103901";
//    [self.playerManager joinWithParam:joinParm];
//
//    videoViewRect = CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height/3.28);
//    self.videoView = [[GSPVideoView alloc]initWithFrame:videoViewRect];
//    [self.view addSubview:self.videoView];
//    self.playerManager.videoView = self.videoView;
//    /*! 全屏按钮 */
//    fullScreenBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.videoView.frame.size.width-38, self.videoView.frame.size.height-38, 20, 20)];
//    [fullScreenBtn setBackgroundImage:[UIImage imageNamed:@"gui_expand_red"] forState:UIControlStateNormal];
//    [fullScreenBtn addTarget:self action:@selector(rotationVideoView:) forControlEvents:UIControlEventTouchUpInside];
//    [self.videoView addSubview:fullScreenBtn];
//    /*! =============================分段选择================================== */
//    segmentView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoView.frame)+10, Main_Screen_Width, 40)];
//    NSArray *titleArray = @[@"直播互动",@"往期直播"];
//    for (int i=0; i<2; i++) {
//        UIButton *segButton = [[UIButton alloc]initWithFrame:CGRectMake(i*Main_Screen_Width/2, 0, Main_Screen_Width/2, 40)];
//        segButton.tag = i;
//        segButton.backgroundColor = UIColorWhite;
//        [segButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        segButton.titleLabel.font = UIFontSystem14;
//        [segmentView addSubview:segButton];
//        [segButton setTitle:titleArray[i] forState:UIControlStateNormal];
//        [segButton addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    segmentLine = [[UIView alloc] initWithFrame:CGRectMake(0, 38, Main_Screen_Width/2, 2)];
//    segmentLine.backgroundColor = [UIColor redColor];
//    [segmentView addSubview:segmentLine];
//    [self.view addSubview:segmentView];
//    /*! segentScrollView */
//    segentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(segmentView.frame)+10, Main_Screen_Width, Main_Screen_Height-190)];
//    segentScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    segentScrollView.pagingEnabled = YES;
//    segentScrollView.delegate = self;
//    segentScrollView.bounces = NO;
//    segentScrollView.alwaysBounceVertical = NO;
//    segentScrollView.alwaysBounceHorizontal = YES;
//    segentScrollView.showsHorizontalScrollIndicator = NO;
//    segentScrollView.showsVerticalScrollIndicator = NO;
//    segentScrollView.backgroundColor = [UIColor whiteColor];
//    segentScrollView.contentSize = CGSizeMake(Main_Screen_Width * titleArray.count, Main_Screen_Height - (self.videoView.frame.origin.y + self.videoView.frame.size.height) - 52);
//    [self.view addSubview:segentScrollView];
//    /*! ChatView直播聊天 */
//    _chatView = [[GSPChatView alloc]initWithFrame:CGRectMake(0, -45, Main_Screen_Width, Main_Screen_Height-Main_Screen_Height/3.28-178+90)];
//    _chatView.backgroundColor = UIColorWhite;
//    [segentScrollView addSubview:_chatView];
//    inputView= [[GSPChatInputToolView alloc]initWithViewController:self combinedChatView:_chatView combinedQaView:nil isChatMode:YES];
//    inputView.backgroundColor = UIColorWhite;
//    [self.view addSubview:inputView];
//    self.playerManager.chatView = _chatView;
//    /*! 初始化异常界面 */
//    [self initEmptyView:_chatView withFrame:_chatView.frame];
//    [HXLoadingView show];
}

#pragma mark - =====================创建点播视频播放视图===================
//- (void)AVPlayer{
//    
//    /*! 创建视频播放视图 */
//    _playerView = [[GUIPlayerView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height/3.28)];
//    _playerView.delegate = self;
//    _playerView.videoTitle = @"往期直播";
//    [self.view addSubview:_playerView];
//    
//    WeakSelf(weakSelf);
//    _playerView.firstPlayBtnClick = ^(){
//        DDLog(@"开始播放=============");
//        weakSelf.playerView.videoURL = [NSURL URLWithString:weakSelf.firstModel.train_url];
//        [weakSelf.playerView prepareAndPlayAutomatically:YES];
//        [weakSelf.playerView.coverImageView removeFromSuperview];
//        [weakSelf.playerView.firstPlayButton removeFromSuperview];
//        [weakSelf.playerView showControllers];
//    };
//    _playerView.downLoadBtnClick = ^(){
//        DDLog(@"开始下载==============");
//        [weakSelf readyDownLoad:weakSelf.currenModel];
//    };
//    
//}


#pragma mark - ========直播播放器进入全屏==========
- (void)rotationVideoView:(UIButton *)sender {
    [self.view endEditing:YES];//收起键盘
    //强制旋转
//    if (!hasOrientation) {
//        [UIView animateWithDuration:0.5 animations:^{
//            self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
//            self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
//            self.videoView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
//            hasOrientation = YES;
//            segmentView.hidden = YES;
//            segentScrollView.hidden = YES;
//            self.navigationController.navigationBarHidden = YES;
//            [[UIApplication sharedApplication] setStatusBarHidden:YES];
//            fullScreenBtn.frame = CGRectMake(self.videoView.frame.size.width-38, self.videoView.frame.size.height-38, 20, 20);
//            [fullScreenBtn setBackgroundImage:[UIImage imageNamed:@"gui_shrin"] forState:UIControlStateNormal];
//        }];
//    } else {
//        [UIView animateWithDuration:0.5 animations:^{
//            self.view.transform = CGAffineTransformInvert(CGAffineTransformMakeRotation(0));
//            self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//            self.videoView.frame = videoViewRect;
//            hasOrientation = NO;
//            segmentView.hidden = NO;
//            segentScrollView.hidden = NO;
//            [[UIApplication sharedApplication] setStatusBarHidden:NO];
//            self.navigationController.navigationBarHidden = NO;
//            fullScreenBtn.frame = CGRectMake(self.videoView.frame.size.width-38, self.videoView.frame.size.height-38, 20, 20);
//            [fullScreenBtn setBackgroundImage:[UIImage imageNamed:@"gui_expand_red"] forState:UIControlStateNormal];
//            if (isSegment ==YES) {
//                segentScrollView.contentOffset = [self ScrollViewWithContentOffSetPage:1];
//            }
//        }];
//    }
}


#pragma mark -=================直播间直播状态提示================
//-(void)playerManager:(GSPPlayerManager *)playerManager didReceiveSelfJoinResult:(GSPJoinResult)joinResult currentIDC:(NSString *)idcKey
//{
//    
//    if (joinResult == GSPJoinResultOK) {
//        [self showNoPlarView:YES];
//        [HXLoadingView hide];
//        _playerView.hidden = YES;
//        _videoView.hidden = NO;
//        isHaveLive = YES;
//        [self.playerView stop];
//    }else{
//            isHaveLive = NO;
//            if (joinResult == GSPJoinResultNetworkError) {
//                [HXProgressHUD showMessage:self.view labelText:@"网络错误" mode:MBProgressHUDModeText];
//                [HXLoadingView hide];
//            }else if (joinResult == GSPJoinResultParamsError) {
//                [HXProgressHUD showMessage:self.view labelText:@"参数错误" mode:MBProgressHUDModeText];
//                [HXLoadingView hide];
//            }else if (joinResult == GSPJoinResultTOO_EARLY) {
//                [HXProgressHUD showMessage:self.view labelText:@"直播尚未开始" mode:MBProgressHUDModeText];
//                [HXLoadingView hide];
//            }else if (joinResult == GSPJoinResultLICENSE) {
//                [HXProgressHUD showMessage:self.view labelText:@"直播人数已满" mode:MBProgressHUDModeText];
//                [HXLoadingView hide];
//            }else if (joinResult == GSPJoinResultTimeout) {
//                [HXProgressHUD showMessage:self.view labelText:@"网络连接超时" mode:MBProgressHUDModeText];
//                [HXLoadingView hide];
//            }else {
//                [HXProgressHUD showMessage:self.view labelText:@"服务器异常" mode:MBProgressHUDModeText];
//                [HXLoadingView hide];
//            }
//            [self showNoPlarView:NO];
//            /*! 没有直播时获取往期直播第一条 */
//            [self gaintFirstLiveHistory];
//
//        }
//}
//
//- (void)playerManager:(GSPPlayerManager *)playerManager didSelfLeaveFor:(GSPLeaveReason)reason {
//    NSString *reasonStr = nil;
//    switch (reason) {
//        case GSPLeaveReasonEjected:
//        [HXProgressHUD showMessage:self.view labelText:@"被踢出直播" mode:MBProgressHUDModeText];
//            [self showNoPlarView:NO];
//            /*! 没有直播时获取往期直播第一条 */
//            [self gaintFirstLiveHistory];
//            break;
//        case GSPLeaveReasonTimeout:
//            reasonStr = NSLocalizedString(@"超时", @"");
//        [HXProgressHUD showMessage:self.view labelText:@"超时" mode:MBProgressHUDModeText];
//            [self showNoPlarView:NO];
//            /*! 没有直播时获取往期直播第一条 */
//            [self gaintFirstLiveHistory];
//            break;
//        case GSPLeaveReasonClosed:
//        [HXProgressHUD showMessage:self.view labelText:@"直播关闭" mode:MBProgressHUDModeText];
//            [self showNoPlarView:NO];
//            /*! 没有直播时获取往期直播第一条 */
//            [self gaintFirstLiveHistory];
//            break;
//        case GSPLeaveReasonUnknown:
//        [HXProgressHUD showMessage:self.view labelText:@"未知错误" mode:MBProgressHUDModeText];
//            [self showNoPlarView:NO];
//            /*! 没有直播时获取往期直播第一条 */
//            [self gaintFirstLiveHistory];
//            break;
//        default:
//            break;
//            
//    }
//    if (reasonStr != nil) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"退出直播", @"") message:reasonStr delegate:self cancelButtonTitle:NSLocalizedString(@"知道了", @"") otherButtonTitles:nil];
//        [alertView show];
//    }
//    
//}
//#pragma mark -=================直播间断线重连提示================
//- (void)playerManagerWillReconnect:(GSPPlayerManager *)playerManager {
//    [HXProgressHUD showMessage:self.view labelText:@"断线重连" mode:MBProgressHUDModeText];
//    [self.view endEditing:YES];
//}
//
//
///**
// *  直播是否暂停
// *
// *  @param playerManager 调用该代理的直播管理实例
// *  @param isPaused      YES表示直播已暂停，NO表示直播进行中
// */
//#pragma mark -=================直播间暂停提示================
//- (void)playerManager:(GSPPlayerManager*)playerManager isPaused:(BOOL)isPaused
//{
//    
//    NSLog(@"isPaused******");
//    
//}
//
//
//#pragma mark -=================点击按钮分段选择==================
//-(void)segmentClick:(UIButton *)sender
//{
//    if (sender.tag == 0) {
//        [segentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//        if (isHaveLive==NO) {
//            /*! 如果不存在直播重连 */
//            [HXLoadingView show];
//            [self.playerManager joinWithParam:joinParm];
//            [self.playerView stop];
//        }
//    }else{
//        [segentScrollView setContentOffset:CGPointMake(Main_Screen_Width, 0) animated:YES];
//    }
//}
//
//#pragma mark -=================滑动视图分段选择==================
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    if (scrollView.contentOffset.x == 0) {
//        
//        [UIView animateWithDuration:0.2 animations:^{
//            segmentLine.frame = CGRectMake(0, 38, Main_Screen_Width/2, 2);
//            inputView.hidden = NO;
//            isSegment = NO;
//        }];
//        if (isHaveLive==NO) {
//            /*! 如果不存在直播重连 */
//            [HXLoadingView show];
//            [self.playerManager joinWithParam:joinParm];
//            [self.playerView stop];
//        }
//    }else{
//        if ([self.curenListArray containsObject:@"4"]) {
//            
//            /*! 往期直播 */
//            WeakSelf(weakSelf);
//            if (!pastLiveView) {
//                pastLiveView = [[HXLiveHistoryController alloc]init];
//                pastLiveView.view.frame = CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, Main_Screen_Height-Main_Screen_Height/3.28-125);
//                [segentScrollView addSubview:pastLiveView.view];
//                pastLiveView.liveHistoryClick = ^(HXLiveHistoryModel *model){
//                    if (isHaveLive==YES) {
//                        /*! 当前正在直播 */
//                        [weakSelf showHXAlertExitLive:model];
//                        return ;
//                    }
//                    /*! 点击列表切换点播 */
//                    [weakSelf creatRefreshAVPlary:model];
//                };
//            }
//            
//            [UIView animateWithDuration:0.2 animations:^{
//                segmentLine.frame = CGRectMake(Main_Screen_Width/2, 38, Main_Screen_Width/2, 2);
//                inputView.hidden = YES;
//                isSegment = YES;
//            }];
//        }
//        else{
//            HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"对不起,你没有该产品权限,可能有以下原因:\n1.您还没有付款；\n2.付费用户已经过了有效期。" centerButtonTitle:@"确定"];
//            alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
//            alter.centerBlock=^()
//            {
//            };
//            [alter show];
//        }
//    }
//}
//
//#pragma mark - ==================切换点播时退出播放器重建=========================
//-(void)creatRefreshAVPlary:(HXLiveHistoryModel *)model
//{
//    [self.playerView clean];
//    self.playerView = [[GUIPlayerView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height/3.28)];
//    self.playerView.delegate = self;
//    [self.view addSubview:self.playerView];
//    self.playerView.videoTitle = model.train_title;
//    self.playerView.videoURL = [NSURL URLWithString:model.train_url];
//    [self.playerView prepareAndPlayAutomatically:YES];
//    [self.playerView.coverImageView removeFromSuperview];
//    [self.playerView.firstPlayButton removeFromSuperview];
//    [self.playerView showControllers];
//    self.currenModel = model;
//    WeakSelf(weakSelf);
//    _playerView.downLoadBtnClick = ^(){
//        DDLog(@"开始下载==============");
//        [weakSelf readyDownLoad:weakSelf.currenModel];
//    };
//}
//
//#pragma mark - ===================切换点播提示退出当前直播=========================
//-(void)showHXAlertExitLive:(HXLiveHistoryModel *)model
//{
//    HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"确定退出当前直播吗?" rightButtonTitle:@"退出" leftButtonTitle:@"取消"];
//    WeakSelf(weakSelf);
//    alter.rightBlock=^()
//    {
//        weakSelf.playerView.hidden = NO;
//        weakSelf.videoView.hidden = YES;
//        [weakSelf.playerManager leave];
//        isHaveLive = NO;
//        weakSelf.playerView.videoURL = [NSURL URLWithString:model.train_url];
//        weakSelf.playerView.videoTitle = model.train_title;
//        [weakSelf.playerView prepareAndPlayAutomatically:YES];
//        [weakSelf.playerView.coverImageView removeFromSuperview];
//        [weakSelf.playerView.firstPlayButton removeFromSuperview];
//        [weakSelf.playerView showControllers];
//        weakSelf.currenModel = model;
//    };
//    alter.leftBlock=^()
//    {
//        
//    };
//    [alter show];
//}
//
///*! 返回scrollView偏移量 */
//- (CGPoint)ScrollViewWithContentOffSetPage:(NSInteger)page{
//    return CGPointMake(([UIScreen mainScreen].bounds.size.width) * page, 0);
//}
//
//
//#pragma mark - ========点播播放器进入全屏===============================
//- (void)playerWillEnterFullscreen {
//    [[self navigationController] setNavigationBarHidden:YES];
//    [UIView animateWithDuration:0.6 animations:^{
//        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    }];
//    inputView.hidden = YES;
//    segmentView.hidden = YES;
//    segentScrollView.hidden = YES;
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
//}
//
//- (void)playerWillLeaveFullscreen {
//    [[self navigationController] setNavigationBarHidden:NO];
//    [UIView animateWithDuration:0.6 animations:^{
//        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    }];
//    inputView.hidden = NO;
//    segmentView.hidden = NO;
//    segentScrollView.hidden = NO;
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//    if (isSegment==YES) {
//        inputView.hidden = YES;
//    }
//}
//
//- (void)playerDidEndPlaying {
//    [_playerView stop];
//}
//
//- (void)playerFailedToPlayToEnd {
//    [self.playerView prepareAndPlayAutomatically:YES];
//}
//
//
//
//#pragma mark - ======================进入后台====================
//-(void)enterBackground
//{
//    DDLog(@"========进入后台");
//    [_playerView pause];
//}
//
//#pragma mark - ======================进入前台=====================
//-(void)becomeActive
//{
//    DDLog(@"========进入前台");
//    [_playerView play];
//}
//
//
//#pragma mark - ================视图进入的时候==================
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.playerView addSubview:self.playerView.coverImageView];
//    [self.playerView addSubview:self.playerView.firstPlayButton];
//    
//}
//#pragma mark - ================视图离开的时候===================
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [_playerView stop];
//    
//}
//
//
//-(void)dealloc
//{
//    [_playerView clean];
//    [self.playerManager leave];
//}
//
//-(void)backClick
//{
//    [self.playerManager leave];
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
//
//
//#pragma mark - =======================准备下载视频========================
//-(void)readyDownLoad:(HXLiveHistoryModel *)model
//{
//    /*! 暂停列表 */
//    NSMutableArray *ZTarray =  [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
//    /*! 下载列表 */
//    NSMutableArray *downarray =  [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
//    /*! 等待下载 */
//    NSMutableArray *waitList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
//    /*! 失败列表 */
//    NSMutableArray *failed = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"failedList"]];
//    
//    NSDictionary *dic = [self gaintDownLoadDic:model];
//    downLoadDict = dic;
//    
//    CGFloat f = [[HSDownloadManager sharedInstance] progress:dic];
//    
//    if (f >= 1) {
//        /*! 已下载提示 */
//        [HXProgressHUD showMessage:self.view labelText:@"已下载" mode:MBProgressHUDModeText];
//        return;
//    }
//    /*! 如果已存在等待列表中 */
//    if ([waitList containsObject:dic]) {
//        [HXProgressHUD showMessage:self.view labelText:@"已在等待列表中" mode:MBProgressHUDModeText];
//        return;
//    }
//    /*! 如果已在失败列表中 */
//    if ([failed containsObject:dic]) {
//        [failed removeObject:dic];
//        [userDefaults setObject:failed forKey:@"failedList"];
//        [userDefaults synchronize];
//        /*! 开始下载 */
//        [self startDownLoad];
//    }
//    /*! 如果已在下载列表中 */
//    if ([downarray containsObject:dic]&&(![ZTarray containsObject:dic])) {
//        [HXProgressHUD showMessage:self.view labelText:@"正在下载中..." mode:MBProgressHUDModeText];
//        return;
//    }
//    /*! 第一次下载提示网络模式 */
//    if ((downarray.count < 1) || ((downarray.count == ZTarray.count) && downarray.count != 1)) {
//        /*! 检查网络状况 */
//        [[HXNetClient sharedInstance]netWorkReachabilityWithReturnNetWorkStatusBlock:^(AFNetworkReachabilityStatus status) {
//            if (status==1) {
//                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络为蜂窝网,是否继续下载?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                alerView.delegate = self;
//                [alerView show];
//            }else{
//                /*! 开始下载 */
//                [self startDownLoad];
//            }
//        }];
//    }else{
//        /*! 添加到等待列表 */
//        NSMutableArray *array1 = (NSMutableArray*)[userDefaults objectForKey:@"waitList"];
//        if (array1 == nil) {
//            array1 = [NSMutableArray array];
//        }
//        if (![array1 containsObject:dic]) {
//            NSMutableArray *aRRay = [[NSMutableArray alloc] initWithArray:array1];
//            [aRRay addObject:dic];
//            NSMutableArray *downList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
//            NSMutableArray *ZTList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
//            [downList removeObject:dic];
//            [userDefaults setObject:downList forKey:@"downList"];
//            [ZTList removeObject:dic];
//            [userDefaults setObject:ZTList forKey:@"cachingList"];
//            [userDefaults setObject:aRRay forKey:@"waitList"];
//            [userDefaults synchronize];
//        }
//    }
//    /*! 移除暂停列表 */
//    if ([ZTarray containsObject:dic]) {
//        [ZTarray removeObject:dic];
//        [userDefaults setObject:ZTarray forKey:@"cachingList"];
//        [userDefaults synchronize];
//    }
//}
//
//#pragma mark -- UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 1) {
//        /*! 开始下载 */
//        [self startDownLoad];
//    }
//}
//
//
//#pragma mark - ============================获取下载视频数据源=======================
//-(NSDictionary *)gaintDownLoadDic:(HXLiveHistoryModel *)model
//{
//    NSDictionary *dic;
//    dic = @{@"title":model.train_title,
//            @"url":model.train_url,
//            @"time":model.train_addtime,
//            @"cache_id":model.train_id,
//            };
//    
//    return dic;
//}
//
//#pragma mark - =========================开始下载视频===========================
//-(void)startDownLoad
//{
//    NSMutableArray *downarray =  [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
//    if (downarray == nil) {
//        downarray = [NSMutableArray array];
//    }
//    if (![downarray containsObject:downLoadDict]) {
//        NSMutableArray *aRRay = [[NSMutableArray alloc] initWithArray:downarray];
//        [aRRay addObject:downLoadDict];
//        [userDefaults setObject:aRRay forKey:@"downList"];
//        [userDefaults synchronize];
//    }
//    /*! 开始下载 */
//    [DownLoad downLoadWithDictionary:downLoadDict];
//    [HXProgressHUD showMessage:self.view labelText:@"已成功添加到下载列表" mode:MBProgressHUDModeText];
//    
//}
//
//#pragma mark - ==================没有直播时获取往期直播列表第一条========================
//-(void)gaintFirstLiveHistory
//{
//    LiveHistoryReqModel *model = [[LiveHistoryReqModel alloc]init];
//    /*! 第一页 */
//    model.pagenum = @"1";
//    NSDictionary *dict = [model mj_keyValues];
//    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"Investment/LiveHistory" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
//        DDLog(@"responseDict======%@",responseDict);
//        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
//        NSDictionary *dic;
//        if ([status isEqualToString:@"1"]) {
//             dic =responseDict[@"data"][0];
//        }else{
//         dic=@{@"opert_user":@"",@"train_addtime":@"",@"train_id":@"",@"train_title":@"",@"train_url":@"",@"video_pic":@""};
//        }
//        self.firstModel = [HXLiveHistoryModel mj_objectWithKeyValues:dic];
//        self.currenModel = self.firstModel;
//        _playerView.hidden = NO;
//        _videoView.hidden = YES;
//        if (self.firstModel.video_pic.length==0) {
//            _playerView.coverImageView.image = [UIImage imageNamed:@"banner"];
//        }else{
//            [_playerView.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.firstModel.video_pic]];
//        }
//        [HXLoadingView hide];
//
//    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
//        [HXLoadingView hide];
//    } WithFailureBlock:^{
//        [HXLoadingView hide];
//    }];
//}
//

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
