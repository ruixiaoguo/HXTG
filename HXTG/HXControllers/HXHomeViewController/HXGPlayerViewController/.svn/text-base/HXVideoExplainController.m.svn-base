//
//  HXVideoExplainController.m
//  HXTG
//
//  Created by grx on 2017/5/9.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXVideoExplainController.h"
#import "GUIPlayerView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HXPastLiveCell.h"
#import "LiveHistoryReqModel.h"
#import "HSDownloadManager.h"
#import "DownLoad.h"

@interface HXVideoExplainController ()<GUIPlayerViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIView *titleBgView;
    UIView *teachBgView;
    UILabel *warlyTitle;
    UILabel *teachTime;
    UILabel *teachName;
    UILabel *teachNum;
    UILabel *legionName;
    NSDictionary *downLoadDict;
    UIView *tipView;
    HXPastLiveCell *cell;
    int pageCount;
}

@property (nonatomic,strong) GUIPlayerView *playerView;
@property (strong, nonatomic) UITableView *pastLivetableView;
@property (strong, nonatomic) NSMutableArray *pastLiveArray;
@property (nonatomic,strong) HXLiveHistoryModel *firstModel;/*! 第一条数据 */
@property (nonatomic,strong) HXLiveHistoryModel *currenModel;/*! 当前数据 */

@end

@implementation HXVideoExplainController

/*! 懒加载 */
-(UITableView *)pastLivetableView
{
    if (!_pastLivetableView) {
        _pastLivetableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.playerView.frame)+10, Main_Screen_Width, Main_Screen_Height-Main_Screen_Height/3.28-125) style:UITableViewStyleGrouped];
        
        _pastLivetableView.delegate = self;
        _pastLivetableView.dataSource = self;
        
        _pastLivetableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _pastLivetableView.backgroundColor = UIColorBgLightTheme;
        [_pastLivetableView registerClass:[HXPastLiveCell class] forCellReuseIdentifier:PastLiveCellIdentifier];
    }
    return _pastLivetableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorBgLightTheme;
    self.backButton.hidden = NO;
    /*! 创建广播层 */
    [self creatRadio];
    /*! 创建播放器 */
    [self AVPlayer];
    self.pastLiveArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.pastLivetableView];
    /*! 初始化异常界面 */
    [self initEmptyView:self.pastLivetableView];

    
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    [self gaintLiveHistory:NO];

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
    /*! 文章信息 */
    titleBgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipView.frame), Main_Screen_Width, 30)];
    titleBgView.hidden = YES;
    titleBgView.backgroundColor = UIColorWhite;
    /*! 文章标题 */
    warlyTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, Main_Screen_Width-30, 30)];
    warlyTitle.font = UIFontSystem14;
    warlyTitle.textColor = UIColorBlackTheme;
    [titleBgView addSubview:warlyTitle];
    [self.view addSubview:titleBgView];
}

#pragma mark - =============创建视频播放视图=============
- (void)AVPlayer{
    
    // 1.创建视频播放视图
    _playerView = [[GUIPlayerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleBgView.frame), Main_Screen_Width, Main_Screen_Height/3.15)];
    _playerView.delegate = self;
    _playerView.hidden = YES;
    [self.view addSubview:_playerView];
    
    WeakSelf(weakSelf);
    _playerView.firstPlayBtnClick = ^(){
        NSString *currenUrl = [NSString stringWithFormat:@"%@",weakSelf.currenModel.train_url];
        currenUrl = [currenUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

        weakSelf.playerView.videoURL = [NSURL URLWithString:currenUrl];
        [weakSelf.playerView prepareAndPlayAutomatically:YES];
        [weakSelf.playerView.coverImageView removeFromSuperview];
        [weakSelf.playerView.firstPlayButton removeFromSuperview];
        [weakSelf.playerView showControllers];

    };
    _playerView.downLoadBtnClick = ^(){
        DDLog(@"开始下载==============");
        [weakSelf readyDownLoad:weakSelf.currenModel];
    };
    /*! 老师信息 */
    teachBgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_playerView.frame), Main_Screen_Width, 30)];
    teachBgView.backgroundColor = UIColorBgLightTheme;
    /*! 老师名称 */
    teachName = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 55, 30)];
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
    [self.view addSubview:teachBgView];

    
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pastLiveArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:PastLiveCellIdentifier forIndexPath:indexPath];
    cell.model = self.pastLiveArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXLiveHistoryModel *model = self.pastLiveArray[indexPath.row];
    /*! 点击列表切换点播 */
    [self creatRefreshAVPlary:model];
}

#pragma mark - ==================切换点播时退出播放器重建=========================
-(void)creatRefreshAVPlary:(HXLiveHistoryModel *)model
{
    [self.playerView clean];
    self.playerView = [[GUIPlayerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleBgView.frame), Main_Screen_Width, Main_Screen_Height/3.28)];
    self.playerView.delegate = self;
    [self.view addSubview:self.playerView];
    NSString *currenUrl = [NSString stringWithFormat:@"%@",model.train_url];
    currenUrl = [currenUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    self.playerView.videoURL = [NSURL URLWithString:currenUrl];
    [self.playerView prepareAndPlayAutomatically:YES];
    [self.playerView.coverImageView removeFromSuperview];
    [self.playerView.firstPlayButton removeFromSuperview];
    [self.playerView showControllers];
    self.currenModel = model;
    warlyTitle.text = self.currenModel.train_title;
    teachTime.text = self.currenModel.train_addtime;
    teachName.text = self.currenModel.opert_user;
    legionName.text = LEGIONNAME;
    teachNum.text = self.currenModel.card_num;
    WeakSelf(weakSelf);
    _playerView.downLoadBtnClick = ^(){
        DDLog(@"开始下载==============");
        [weakSelf readyDownLoad:weakSelf.currenModel];
    };
}



/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.pastLivetableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintLiveHistory:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.pastLivetableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintLiveHistory:YES];
    }];
}

#pragma mark - ===========进入全屏===================
- (void)playerWillEnterFullscreen {
    [[self navigationController] setNavigationBarHidden:YES];
    [UIView animateWithDuration:0.6 animations:^{
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }];
    titleBgView.hidden = YES;
    teachBgView.hidden = YES;
    self.pastLivetableView.hidden = YES;
    self.playerView.firstPlayButton.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - ===========退出全屏===================
- (void)playerWillLeaveFullscreen {
    [[self navigationController] setNavigationBarHidden:NO];
    [UIView animateWithDuration:0.6 animations:^{
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }];
    titleBgView.hidden = NO;
    teachBgView.hidden = NO;
    self.pastLivetableView.hidden = NO;
    self.playerView.firstPlayButton.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - 往期直播列表网络请求
-(void)gaintLiveHistory:(BOOL)isLoadMore
{
    
    LiveHistoryReqModel *model = [[LiveHistoryReqModel alloc]init];
    model.legion_id = LEGIONLID;
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    NSDictionary *dict = [model mj_keyValues];
    
    [HXLoadingView show];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"Investment/LiveHistory" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        NSString *navName = [NSString stringWithFormat:@"%@",responseDict[@"name"]];
        self.title = navName;
        if ([status isEqualToString:@"1"]) {
            
            if (isLoadMore == NO) {
                [self.pastLiveArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXLiveHistoryModel *model = [HXLiveHistoryModel mj_objectWithKeyValues:dic];
                [self.pastLiveArray addObject:model];
            }
            /*! 获取第一条 */
            NSDictionary *firstDic = responseDict[@"data"][0];
            self.firstModel = [HXLiveHistoryModel mj_objectWithKeyValues:firstDic];
            if (self.firstModel.video_pic.length==0) {
                _playerView.coverImageView.image = [UIImage imageNamed:@"banner"];
            }else{
                NSString *picStr = [NSString stringWithFormat:@"%@",self.firstModel.video_pic];
                picStr = [picStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [_playerView.coverImageView sd_setImageWithURL:[NSURL URLWithString:picStr]];
            }
            self.currenModel = self.firstModel;
            warlyTitle.text = self.currenModel.train_title;
            teachTime.text = self.currenModel.train_addtime;
            teachName.text = self.currenModel.opert_user;
            legionName.text = self.currenModel.lrving_name;;
            teachNum.text = self.currenModel.card_num;

            [HXLoadingView hide];
            [self.pastLivetableView reloadData];
            if (isLoadMore == NO) {
                [self.pastLivetableView.mj_header endRefreshing];
                [self.pastLivetableView.mj_footer resetNoMoreData];
            }else{
                [self.pastLivetableView.mj_footer endRefreshing];
                
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.pastLivetableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.pastLivetableView.mj_header endRefreshing];
            [self.pastLivetableView.mj_footer endRefreshingWithNoMoreData];
            
        }
        if (self.pastLiveArray.count==0) {
            titleBgView.hidden = YES;
            teachBgView.hidden = YES;
            _playerView.hidden = YES;
            _pastLivetableView.frame = CGRectMake(0, 104, Main_Screen_Width, Main_Screen_Height-104);
        }else{
            titleBgView.hidden = NO;
            teachBgView.hidden = NO;
            _playerView.hidden = NO;
            teachTime.text = self.currenModel.train_addtime;
            teachName.text = self.currenModel.opert_user;
            teachNum.text = self.currenModel.card_num;
            _pastLivetableView.frame = CGRectMake(0, CGRectGetMaxY(teachBgView.frame)+10, Main_Screen_Width, Main_Screen_Height-Main_Screen_Height/3.28-125);
        }
        [self showNoDataView:self.pastLiveArray];
        if ([self.title isEqualToString:@"<null>"]||[self.title isEqualToString:@"(null)"]) {
            self.title = @"视频解盘";
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.pastLivetableView.mj_header endRefreshing];
        }else{
            [self.pastLivetableView.mj_footer endRefreshing];
        }
        [self showNoServerView:self.pastLiveArray];
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.pastLivetableView.mj_header endRefreshing];
        }else{
            [self.pastLivetableView.mj_footer endRefreshing];
        }
        [self showNoNetView:self.pastLiveArray];
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

#pragma mark - =======================准备下载视频========================
-(void)readyDownLoad:(HXLiveHistoryModel *)model
{
    /*! 暂停列表 */
    NSMutableArray *ZTarray =  [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
    /*! 下载列表 */
    NSMutableArray *downarray =  [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
    /*! 等待下载 */
    NSMutableArray *waitList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
    /*! 失败列表 */
    NSMutableArray *failed = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"failedList"]];
    
    NSDictionary *dic = [self gaintDownLoadDic:model];
    downLoadDict = dic;
    
    CGFloat f = [[HSDownloadManager sharedInstance] progress:dic];
    
    if (f >= 1) {
        /*! 已下载提示 */
        [HXProgressHUD showMessage:self.view labelText:@"已下载" mode:MBProgressHUDModeText];
        return;
    }
    /*! 如果已存在等待列表中 */
    if ([waitList containsObject:dic]) {
        [HXProgressHUD showMessage:self.view labelText:@"已在等待列表中" mode:MBProgressHUDModeText];
        return;
    }
    /*! 如果已在失败列表中 */
    if ([failed containsObject:dic]) {
        [failed removeObject:dic];
        [userDefaults setObject:failed forKey:@"failedList"];
        [userDefaults synchronize];
        /*! 开始下载 */
        [self startDownLoad];
    }
    /*! 如果已在下载列表中 */
    if ([downarray containsObject:dic]&&(![ZTarray containsObject:dic])) {
        [HXProgressHUD showMessage:self.view labelText:@"正在下载中..." mode:MBProgressHUDModeText];
        return;
    }
    /*! 第一次下载提示网络模式 */
    if ((downarray.count < 1) || ((downarray.count == ZTarray.count) && downarray.count != 1)) {
        /*! 检查网络状况 */
        [[HXNetClient sharedInstance]netWorkReachabilityWithReturnNetWorkStatusBlock:^(AFNetworkReachabilityStatus status) {
            if (status==1) {
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络为蜂窝网,是否继续下载?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alerView.delegate = self;
                [alerView show];
            }else{
                /*! 开始下载 */
                [self startDownLoad];
            }
        }];
    }else{
        /*! 添加到等待列表 */
        NSMutableArray *array1 = (NSMutableArray*)[userDefaults objectForKey:@"waitList"];
        if (array1 == nil) {
            array1 = [NSMutableArray array];
        }
        if (![array1 containsObject:dic]) {
            NSMutableArray *aRRay = [[NSMutableArray alloc] initWithArray:array1];
            [aRRay addObject:dic];
            NSMutableArray *downList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
            NSMutableArray *ZTList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
            [downList removeObject:dic];
            [userDefaults setObject:downList forKey:@"downList"];
            [ZTList removeObject:dic];
            [userDefaults setObject:ZTList forKey:@"cachingList"];
            [userDefaults setObject:aRRay forKey:@"waitList"];
            [userDefaults synchronize];
        }
    }
    /*! 移除暂停列表 */
    if ([ZTarray containsObject:dic]) {
        [ZTarray removeObject:dic];
        [userDefaults setObject:ZTarray forKey:@"cachingList"];
        [userDefaults synchronize];
    }
}

#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        /*! 开始下载 */
        [self startDownLoad];
    }
}


#pragma mark - ============================获取下载视频数据源=======================
-(NSDictionary *)gaintDownLoadDic:(HXLiveHistoryModel *)model
{
    NSDictionary *dic;
    NSString *trainUrl = [NSString stringWithFormat:@"%@",model.train_url];

    trainUrl = [trainUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    dic = @{@"title":model.train_title,
            @"url":trainUrl,
            @"time":model.train_addtime,
            @"cache_id":model.train_id,
            };
    
    return dic;
}

#pragma mark - =========================开始下载视频===========================
-(void)startDownLoad
{
    NSMutableArray *downarray =  [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
    if (downarray == nil) {
        downarray = [NSMutableArray array];
    }
    if (![downarray containsObject:downLoadDict]) {
        NSMutableArray *aRRay = [[NSMutableArray alloc] initWithArray:downarray];
        [aRRay addObject:downLoadDict];
        [userDefaults setObject:aRRay forKey:@"downList"];
        [userDefaults synchronize];
    }
    /*! 开始下载 */
    [DownLoad downLoadWithDictionary:downLoadDict];
    [HXProgressHUD showMessage:self.view labelText:@"已成功添加到下载列表" mode:MBProgressHUDModeText];
    
}


#pragma mark - ================视图进入的时候==================
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.playerView addSubview:self.playerView.coverImageView];
    [self.playerView addSubview:self.playerView.firstPlayButton];
    
}
#pragma mark - ================视图离开的时候===================
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_playerView stop];
    [_playerView clean];

}


-(void)dealloc
{
    
    [_playerView clean];
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
