//
//  HXHomeViewController.m
//  HXTG
//
//  Created by grx on 2017/2/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXHomeViewController.h"
#import "HXNavigationController.h"
#import "HXHomeCell.h"
#import "HXLoginController.h"
#import "HXChatViewController.h"
#import "HXVideoExplainController.h"
#import "HXEarlyReadController.h"
#import "HXOpenClassController.h"
#import "HXStockPoolController.h"
#import "HXTgReferenceController.h"
#import "HXExtraServerController.h"
#import "HXHightExcluController.h"
#import "HXStockSpecController.h"
#import "HXEveDayStockController.h"
#import "HXMessageListController.h"
#import "HXAdboadDetailController.h"
#import "HXSpecDetailController.h"
#import "AdboardModel.h"
#import "HXDailystockModel.h"
#import "HXHomeCellModel.h"
#import "HomeRequestModel.h"
#import "NSString+TxtHeight.h"
#import "HXServerListController.h"
#import "HXLingShenController.h"
#import "JPUSHService.h"
#import "HXTrainingClassController.h"
#import "HXConversationListController.h"
#import "HXBindNewTelController.h"
#import "HXSysDetailController.h"
#import "HXAskListViewController.h"

@interface HXHomeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    HXDailystockModel *stockeModel;
    HXHomeCell *homeCell;
    BOOL isToLogin;
    NSString *isCheck;
}

@property(nonatomic,strong) NSMutableArray *bannerListArray;
@property(nonatomic,strong) NSMutableArray *homeListArray;
@property(nonatomic,strong) UITableView *hxHomeTableView;
@property(nonatomic,strong) NSMutableArray *curColumnArray;  /*! 当前用户权限列表 */

@end

@implementation HXHomeViewController

/*! HXHomeTableView懒加载 */
-(UITableView *)hxHomeTableView
{
    if (!_hxHomeTableView) {
        _hxHomeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -kStatusBarHeight, Main_Screen_Width, Main_Screen_Height+kStatusBarHeight) style:UITableViewStyleGrouped];
        _hxHomeTableView.delegate = self;
        _hxHomeTableView.dataSource = self;
        _hxHomeTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _hxHomeTableView.backgroundColor = UIColorBgLightTheme;
        _hxHomeTableView.showsVerticalScrollIndicator=NO;
        [_hxHomeTableView registerClass:[HXHomeCell class] forCellReuseIdentifier:HomeCellIdentifier];
    }
    return _hxHomeTableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isToLogin = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    /*! 显示小红点 */
    if (ISSERVERMESSAGE || ISRYCHATMESSAGE||ISSOFFICIALMESSAGE) {
        [self.homeMessageBtn showBadge];
    }else{
        [self.homeMessageBtn clearBadge];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:isToLogin animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"投顾";
    self.bannerListArray = [NSMutableArray arrayWithCapacity:0];
    self.homeListArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.hxHomeTableView];
    /*! 添加通知 */
    [self addNotificationCenter];
    /*! 初始化异常界面 */
    [self initEmptyView:self.hxHomeTableView];
    /*! 用户查看全部权限列表 */
    self.curColumnArray = [NSMutableArray arrayWithCapacity:0];
    //337
    CGFloat headHight = 230+170+Main_Screen_Height/3.28;
    self.homeHeadView=[[HomeHeadView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, headHight)];
    WeakSelf(WeakSelf);
    
    /*! 广告位跳转 */
    self.homeHeadView.tapHXAdboardView = ^(AdboardModel *model){
        
        if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
        {
            [WeakSelf jumpToLoginVC];
            return;
        }
        if (model.slide_url.length==0) {
            return ;
        }
        [WeakSelf adboarJumpToController:model.slide_url];
    };
    
    /*! 分类北京栏目 */
    self.homeHeadView.bjHeadColumClick = ^(NSInteger headColumTag){
        if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
        {
            [WeakSelf jumpToLoginVC];
            return;
        }
        if (headColumTag==1) {
            /*! 早盘必读 */
            [WeakSelf pushToEarlyReadVC];
        }else if (headColumTag==2) {
            /*! 公开课 */
            [WeakSelf pushToOpenClassVC];
        }else if (headColumTag==3) {
            /*! 股票池 */
            [WeakSelf pushToStockPoolVC];
        }else if (headColumTag==4) {
            /*! 直播解盘 */
            [WeakSelf pushToPlayerVC];
        }else if (headColumTag==11) {
            /*! 投顾内参 */
            [WeakSelf pushToTgReferVC];
        }else if (headColumTag==12) {
            /*! 附加服务 */
            [WeakSelf pushToExtraServerVC];
        }else if (headColumTag==13) {
            /*! 高端专属 */
            [WeakSelf pushToHightExcluVC];
        }else if (headColumTag==14) {
            /*! 问老师 */
            [WeakSelf pushToAskTeacherVC];
        }
    };
    /*! 分类重庆栏目 */
    self.homeHeadView.cqHeadColumClick = ^(NSInteger headColumTag){
        if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
        {
            [WeakSelf jumpToLoginVC];
            return;
        }
        if (headColumTag==1) {
            /*! 早盘必读 */
            [WeakSelf pushToEarlyReadVC];
        }else if (headColumTag==2) {
            /*! 公开课 */
            [WeakSelf pushToOpenClassVC];
        }else if (headColumTag==3) {
            /*! 股票池 */
            [WeakSelf pushToStockPoolVC];
        }else if (headColumTag==4) {
            /*! 直播解盘 */
            [WeakSelf pushToPlayerVC];
        }else if (headColumTag==11) {
            /*! 投顾内参 */
            [WeakSelf pushToTgReferVC];
        }else if (headColumTag==12) {
            /*! 操作报告 */
            [WeakSelf pushToCaozClassVC];
        }else if (headColumTag==13) {
            /*! 量身定制 */
            [WeakSelf pushToLiangShenVC];
        }else if (headColumTag==14) {
            /*! 问老师 */
            [WeakSelf pushToAskTeacherVC];
        }else if (headColumTag==21) {
            /*! 机构实盘 */
            [WeakSelf pushToJgPanClassVC];

        }
    };

    /*! 每日一股 */
    self.homeHeadView.everStockClickBlock = ^(HXDailystockModel *stockModel){
        
        [WeakSelf pushToEveDayStockVC:stockModel];
    };
    /*! 炒股攻略 */
    self.homeHeadView.strateClickBlock = ^(){
        [WeakSelf pushToStockSpecVC];
    };
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 消息 */
    self.homeMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.homeMessageBtn.frame = CGRectMake(Main_Screen_Width-58,27,60,30);
    [self.homeMessageBtn setImage:[UIImage imageNamed:@"home_xiaoxi"] forState:UIControlStateNormal];
    [self.homeMessageBtn addTarget:self action:@selector(doMessageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.homeHeadView addSubview:self.homeMessageBtn];
    
    /*! 请求轮播图 */
    [self gaintHomeBannerList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    homeCell = [tableView dequeueReusableCellWithIdentifier:HomeCellIdentifier forIndexPath:indexPath];
    homeCell.cellModel = self.homeListArray[indexPath.row];
    return homeCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        [self jumpToLoginVC];
        return;
    }
        HXSpecDetailController *specDetailVC = [[HXSpecDetailController alloc]init];
        HXHomeCellModel *model = self.homeListArray[indexPath.row];
        specDetailVC.model = model;
        specDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:specDetailVC animated:YES];
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.hxHomeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintHomeBannerList];
    }];
}


#pragma mark - 跳转到消息中心
-(void)doMessageAction:(UIButton *)sender
{
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        [self jumpToLoginVC];
    }else{
        HXMessageListController *messageVC = [[HXMessageListController alloc]init];
        messageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:messageVC animated:YES];
    }
}


#pragma mark - 跳转到早盘必读
-(void)pushToEarlyReadVC
{
    HXEarlyReadController *earlyVC = [[HXEarlyReadController alloc] init];
    earlyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:earlyVC animated:YES];
}

#pragma mark - 跳转到公开课
-(void)pushToOpenClassVC
{
    HXOpenClassController *openClassVC = [[HXOpenClassController alloc] init];
    openClassVC.title = @"公开课";
    openClassVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:openClassVC animated:YES];
}

#pragma mark - 跳转到股票池
-(void)pushToStockPoolVC
{
    if ([self.curColumnArray containsObject:@"10"]) {
    HXStockPoolController *StockPoolVC = [[HXStockPoolController alloc] init];
    StockPoolVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:StockPoolVC animated:YES];
    }else{
        [self showUnBuyServer];
    }
}

#pragma mark - 跳转到投顾内参
-(void)pushToTgReferVC
{
    if ([self.curColumnArray containsObject:@"4"]) {
    HXTgReferenceController *tgReferVC = [[HXTgReferenceController alloc] init];
    tgReferVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tgReferVC animated:YES];
    }else{
        [self showUnBuyServer];
    }
}

#pragma mark - 跳转到附加服务
-(void)pushToExtraServerVC
{
    if ([self.curColumnArray containsObject:@"5"]&&([self.curColumnArray containsObject:@"6"]||[self.curColumnArray containsObject:@"7"])) {
        HXExtraServerController *extraServerVC = [[HXExtraServerController alloc] init];
        extraServerVC.curenListArray = self.curColumnArray;
        extraServerVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:extraServerVC animated:YES];
    }else{
        [self showUnBuyServer];
    }
}
#pragma mark - 跳转到高端专属
-(void)pushToHightExcluVC
{
    if ([self.curColumnArray containsObject:@"8"]) {
    HXHightExcluController *hightExcluVC = [[HXHightExcluController alloc] init];
    hightExcluVC.curenListArray = self.curColumnArray;
    hightExcluVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hightExcluVC animated:YES];
    }else{
        [self showUnBuyServer];
    }
}

#pragma mark - 跳转到操作报告
-(void)pushToCaozClassVC
{
    if ([self.curColumnArray containsObject:@"15"]) {
        HXOpenClassController *openClassVC = [[HXOpenClassController alloc] init];
        openClassVC.hidesBottomBarWhenPushed = YES;
        openClassVC.title = @"操作报告";
        [self.navigationController pushViewController:openClassVC animated:YES];
    }else{
        [self showUnBuyServer];
    }
}

#pragma mark - 跳转到量身定制
-(void)pushToLiangShenVC
{
    if ([self.curColumnArray containsObject:@"17"]) {
        HXLingShenController *openClassVC = [[HXLingShenController alloc] init];
        openClassVC.hidesBottomBarWhenPushed = YES;
        openClassVC.curenListArray = self.curColumnArray;
        openClassVC.title = @"量身定制";
        [self.navigationController pushViewController:openClassVC animated:YES];
    }else{
        [self showUnBuyServer];
    }
}

#pragma mark - 跳转到机构实盘
-(void)pushToJgPanClassVC
{
    if ([self.curColumnArray containsObject:@"16"]) {
        HXOpenClassController *openClassVC = [[HXOpenClassController alloc] init];
        openClassVC.hidesBottomBarWhenPushed = YES;
        openClassVC.title = @"机构实盘";
        [self.navigationController pushViewController:openClassVC animated:YES];
    }else{
        [self showUnBuyServer];
    }
}

#pragma mark - 跳转到问老师
-(void)pushToAskTeacherVC
{
    if ([self.curColumnArray containsObject:@"11"]) {
    //HXChatViewController
    HXAskListViewController *chatVC = [[HXAskListViewController alloc] init];
//    chatVC.conversationType = ConversationType_PRIVATE;
//    chatVC.targetId = TEACHERID;
    chatVC.legionName = LEGIONNAME;
    chatVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
    }else{
        [self showUnBuyServer];
    }
}

#pragma mark - 跳转到每日一股
-(void)pushToEveDayStockVC:(HXDailystockModel *)stockModel
{
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        [self jumpToLoginVC];
        return;
    }
    HXEveDayStockController *eveDayStockVC = [[HXEveDayStockController alloc] init];
    eveDayStockVC.model = stockModel;
    eveDayStockVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:eveDayStockVC animated:YES];
}

#pragma mark - 跳转到炒股攻略
-(void)pushToStockSpecVC
{
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
            [self jumpToLoginVC];
            return;
    }
    HXStockSpecController *stockSpecVC = [[HXStockSpecController alloc] init];
    stockSpecVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:stockSpecVC animated:YES];
    
}

#pragma mark - 跳转到视频解盘
-(void)pushToPlayerVC
{
    if ([self.curColumnArray containsObject:@"3"]) {
    HXVideoExplainController *playerVC = [[HXVideoExplainController alloc] init];
    playerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playerVC animated:YES];
    }else{
        [self showUnBuyServer];
    }
}

#pragma mark - ============ 跳转到登录
-(void)jumpToLoginVC
{
    isToLogin = YES;
    HXLoginController *loginVC=[[HXLoginController alloc]init];
    HXNavigationController * loginNC = [[HXNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNC animated:YES completion:nil];
    
}

#pragma mark - ============ 未购买服务提升
-(void)showUnBuyServer
{
    HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"对不起,你没有该产品权限,可能有以下原因:\n1.您还没有付款；\n2.付费用户已经过了有效期。" centerButtonTitle:@"确定"];
    alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
    alter.centerBlock=^()
    {
    };
    [alter show];
}

#pragma mark - 状态栏颜色
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 127 && offset.y>-27) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

#pragma mark - 首页轮播图网络请求
-(void)gaintHomeBannerList
{
    [HXLoadingView show];
    HomeRequestModel *model = [[HomeRequestModel alloc]init];
    NSDictionary *dic = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/bannerList" WithParameter:dic WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {

            [self.bannerListArray removeAllObjects];
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                AdboardModel *adverModel = [AdboardModel mj_objectWithKeyValues:dic];
                [self.bannerListArray addObject:adverModel];
            }
            [self.homeHeadView.adboardView setBannerPictureArr:self.bannerListArray];
            /*! 请求每日一股 */
            [self gaintHomeDailystock];
        }else{
            [self.bannerListArray removeAllObjects];
            [self.homeHeadView.adboardView setBannerPictureArr:self.bannerListArray];
            [HXProgressHUD showMessage:self.view
                             labelText:responseDict[@"msg"]
                                  mode:MBProgressHUDModeText];
            [self.hxHomeTableView.mj_header endRefreshing];
            [self gaintHomeDailystock];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [self.hxHomeTableView.mj_header endRefreshing];
        [HXProgressHUD showMessage:self.view
                         labelText:@"服务器错误,请检查服务器"
                              mode:MBProgressHUDModeText];
        [HXLoadingView hide];
        [self gaintHomeDailystock];
    } WithFailureBlock:^{
        [self.hxHomeTableView.mj_header endRefreshing];
        [HXLoadingView hide];
        [[HXNetBoxView getInstance]showTitle:self.view withTitle:@"网络开小差了,请检查网络状况!!"];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    WeakSelf(WeakSelf);
    
    NSString *busId = [NSString stringWithFormat:@"%@",USERBUSINESSID];
    if ([busId isEqualToString:@"135"]) {
        WeakSelf.homeHeadView.columnView.height = 210;
        self.homeHeadView.ClumnHight = 210;
        return 225+170+Main_Screen_Height/3.28;
    }else{
        WeakSelf.homeHeadView.columnView.height = 100;
        self.homeHeadView.ClumnHight = 150;
        return 337+Main_Screen_Height/3.28;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    return self.homeHeadView;
}

#pragma mark - 首页每日一股网络请求
-(void)gaintHomeDailystock
{
    HomeRequestModel *model = [[HomeRequestModel alloc]init];
    NSDictionary *dic = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/Dailystock" WithParameter:dic WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            NSDictionary *dic =responseDict[@"data"][0];
            stockeModel = [HXDailystockModel mj_objectWithKeyValues:dic];
            CGFloat contentStrHight = [stockeModel.shares_reason heightWithLabelFont:[UIFont systemFontOfSize:13.0f] withLabelWidth:Main_Screen_Width-90];
            if (contentStrHight>46) {
                contentStrHight = 50;
            }
            stockeModel.reasionHight = contentStrHight;
            self.homeHeadView.stockView.stockModel = stockeModel;
            /*! 请求炒股攻略 */
            [self gaintHomeStockSpeculation];
        }else{
            self.homeHeadView.stockView.stockModel = nil;
            [self.hxHomeTableView.mj_header endRefreshing];
            [self gaintHomeStockSpeculation];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [self.hxHomeTableView.mj_header endRefreshing];
        [HXLoadingView hide];
        [self gaintHomeStockSpeculation];
    } WithFailureBlock:^{
        [self.hxHomeTableView.mj_header endRefreshing];
        [HXLoadingView hide];
    }];
}

#pragma mark - 首页炒股攻略网络请求
-(void)gaintHomeStockSpeculation
{
    HomeRequestModel *model = [[HomeRequestModel alloc]init];
    NSDictionary *dic = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/StockSpeculation" WithParameter:dic WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [self.homeListArray removeAllObjects];
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXHomeCellModel *model = [HXHomeCellModel mj_objectWithKeyValues:dic];
                [self.homeListArray addObject:model];
            }
            [self.hxHomeTableView.mj_header endRefreshing];
            /*! 查看列表权限 */
            [self gaintHomeColumnList];

        }else{
            [self.hxHomeTableView.mj_header endRefreshing];
            [self.homeListArray removeAllObjects];
            [self gaintHomeColumnList];
        }
        [self showNoDataView:self.homeListArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [self.hxHomeTableView.mj_header endRefreshing];
        [self showNoServerView:self.homeListArray];
        [HXLoadingView hide];
        [self gaintHomeColumnList];
    } WithFailureBlock:^{
        [self.hxHomeTableView.mj_header endRefreshing];
        [HXLoadingView hide];
    }];
}

#pragma mark - 获取首页模块查看权限网络请求
-(void)gaintHomeColumnList
{
    HomeRequestModel *model = [[HomeRequestModel alloc]init];
    NSString *userId;
    if (USERID==nil) {
        userId=@"";
    }else{
        userId = USERID;
    }
    model.user_id = userId;
    NSDictionary *dic = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/ColumnList" WithParameter:dic WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        
        if ([status isEqualToString:@"1"]) {

            NSString *businessId = [NSString stringWithFormat:@"%@",responseDict[@"business_id"]];
            NSString *legionId = [NSString stringWithFormat:@"%@",responseDict[@"legion_id"]];
            NSString *lrvingName = [NSString stringWithFormat:@"%@",responseDict[@"lrving_name"]];

            /*! 更新事业部Id */
            [StandardUserDefaults  setObject:businessId forKey:@"business_id"];
            /*! 更新军团名称 */
            [StandardUserDefaults  setObject:lrvingName forKey:@"lrvinName"];
            [StandardUserDefaults  setObject:legionId forKey:@"legionLid"];

            /*! 设置极光推送标签(版本) */
            NSString *investProductName = [NSString stringWithFormat:@"%@",responseDict[@"productname"]];
            /*! 设置极光推送标签(风格) */
            NSString *investmentStyle = [NSString stringWithFormat:@"%@",responseDict[@"style"]];
            NSString *investmentTime = [NSString stringWithFormat:@"%@",responseDict[@"evaluating_time"]];
            [StandardUserDefaults  setObject:investmentStyle forKey:@"investmentStyle"];
            [StandardUserDefaults  setObject:investmentTime forKey:@"investmentTime"];

            NSSet *set = [NSSet setWithObjects:investProductName,investmentStyle,businessId,legionId,nil];

            [JPUSHService setTags:set alias:USERNAME callbackSelector:nil object:nil];
            NSLog(@"推送显示收到的绑定tag======%@",set);
            [self.curColumnArray removeAllObjects];
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSString *code =[NSString stringWithFormat:@"%@",responseDict[@"data"][i][@"code"]];
                [self.curColumnArray addObject:code];
            }
            /*! 是否有问老师权限 */
           if ([self.curColumnArray containsObject:@"11"]) {
               [StandardUserDefaults setBool:YES forKey:@"askTeacher"];
           }else{
               [StandardUserDefaults setBool:NO forKey:@"askTeacher"];
           }
            [HXLoadingView hide];
            [self gaintIosCheck];

        }else{
            [HXLoadingView hide];
            [self.curColumnArray removeAllObjects];
            [StandardUserDefaults setBool:NO forKey:@"askTeacher"];
            NSSet *set = [NSSet setWithObjects:@"",@"",@"",@"",nil];
            [JPUSHService setTags:set alias:USERNAME callbackSelector:nil object:nil];

            NSLog(@"推送显示收到的绑定tag1======%@",set);
            [self.hxHomeTableView.mj_header endRefreshing];
            [self gaintIosCheck];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];
        [self.curColumnArray removeAllObjects];
        [StandardUserDefaults setBool:NO forKey:@"askTeacher"];
        [self.hxHomeTableView.mj_header endRefreshing];
        NSSet *set = [NSSet setWithObjects:@"",@"",@"",@"",nil];
//        [JPUSHService setTags:set callbackSelector:nil object:nil];
        [JPUSHService setTags:set alias:USERNAME callbackSelector:nil object:nil];

        NSLog(@"推送显示收到的绑定tag2======%@",set);
        [self gaintIosCheck];
    } WithFailureBlock:^{
        [HXLoadingView hide];
        [self.hxHomeTableView.mj_header endRefreshing];
    }];
}

#pragma mark - ==============审核开关==============================
-(void)gaintIosCheck
{
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/iosexamine" WithParameter:nil WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {

        NSString *message = [NSString stringWithFormat:@"%@",responseDict[@"msg"]];
        isCheck = message;
        self.homeHeadView.ischeck = isCheck;
        if ([message isEqualToString:@"yes"]) {
            [StandardUserDefaults setBool:YES forKey:@"askTeacher"];
            /*! 审核放开所有权限 */
            [self.curColumnArray removeAllObjects];
            for (int i=0; i<20; i++) {
                NSString *code =[NSString stringWithFormat:@"%d",i];
                [self.curColumnArray addObject:code];
            }
        }
        if ([[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
        {
            NSString *telPhone = [NSString stringWithFormat:@"%@",USERPHONE];
            if (telPhone.length==0) {
                HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"请先绑定手机号" centerButtonTitle:@"前往"];
                alter.centerBlock=^()
                {
                    HXBindNewTelController *newBindVC = [[HXBindNewTelController alloc]init];
                    newBindVC.isPush = @"no";
                    [self presentViewController:newBindVC animated:YES completion:nil];
                };
                [alter show];
            }
        }
        [self.hxHomeTableView reloadData];
      } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [self.hxHomeTableView reloadData];
    } WithFailureBlock:^{
    }];
}

#pragma mark - ========================添加通知======================================
-(void)addNotificationCenter
{
    /*! 通知刷新首页 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHomeData) name:RefreshHomeNotification object:nil];
    /*! 未退出应用时后台接收到推送点击跳转到系统服务 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpToServerList:) name:JumpToServerListNotification object:nil];
    /*! 未退出应用时后台接收到推送点击跳转到系统服务 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpToRongYList) name:RYChatNotification object:nil];
    /*! 前台接收到推送显示小红点 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeHomeMessage) name:ChangeHomeMessageNotification object:nil];
    /*! 接收到融云在线消息 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRongYChatMessage:) name:RYGetChatNotification object:nil];

}

#pragma mark - 登陆成功刷新首页
-(void)refreshHomeData
{
    [self gaintHomeBannerList];
}

#pragma mark - 后台接收到推送点击跳转到系统服务
-(void)jumpToServerList:(NSNotification *)noti
{
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        [self jumpToLoginVC];
        return;
    }
    NSDictionary *info = noti.object;
    /*! 推送跳转到栏目详情 */
    [self JpushJumpToDetailVC:info];
    
}

#pragma mark - 后台接收到推送点击跳转到融云列表
-(void)jumpToRongYList
{
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        [self jumpToLoginVC];
        return;
    }
    /*! 互动消息 */
    HXConversationListController *converListVC = [[HXConversationListController alloc]init];
    converListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:converListVC animated:YES];
}

#pragma mark - 点击广告位跳转到相应的栏目
-(void)adboarJumpToController:(NSString *)adboardUrl
{
    if ([adboardUrl isEqualToString:@"0"]) {
        /*! 每日一股 */
        [self pushToEveDayStockVC:stockeModel];
    }else if ([adboardUrl isEqualToString:@"1"]) {
        /*! 早盘必读 */
        [self pushToEarlyReadVC];
    }else if ([adboardUrl isEqualToString:@"2"]) {
        /*! 公开课 */
        [self pushToOpenClassVC];
    }else if ([adboardUrl isEqualToString:@"10"]) {
        /*! 股票池 */
        [self pushToStockPoolVC];
    }else if ([adboardUrl isEqualToString:@"3"]) {
        /*! 视频解盘 */
        [self pushToPlayerVC];
    }else if ([adboardUrl isEqualToString:@"4"]) {
        /*! 投顾内参 */
        [self pushToTgReferVC];
    }else if ([adboardUrl isEqualToString:@"5"]||[adboardUrl isEqualToString:@"6"]||[adboardUrl isEqualToString:@"7"]) {
        /*! 附加服务 */
        [self pushToExtraServerVC];
    }else if ([adboardUrl isEqualToString:@"8"]||[adboardUrl isEqualToString:@"12"]||[adboardUrl isEqualToString:@"13"]||[adboardUrl isEqualToString:@"14"]) {
        /*! 高端专属 */
        [self pushToHightExcluVC];
    }else if ([adboardUrl isEqualToString:@"11"]) {
        /*! 问老师 */
        [self pushToAskTeacherVC];
    }else if ([adboardUrl isEqualToString:@"9"]) {
        /*! 炒股攻略 */
        [self pushToStockSpecVC];
    }else if ([adboardUrl isEqualToString:@"15"]) {
        /*! 操作报告 */
        [self pushToCaozClassVC];
    }else if ([adboardUrl isEqualToString:@"16"])
    {
        /*! 机构实盘 */
        [self pushToJgPanClassVC];
    }else if ([adboardUrl isEqualToString:@"17"]||[adboardUrl isEqualToString:@"18"]||[adboardUrl isEqualToString:@"19"])
    {
        /*! 量身定制 */
        [self pushToLiangShenVC];
    }
}

#pragma mark - 点击推送通知栏跳转到相应的栏目详情
-(void)JpushJumpToDetailVC:(NSDictionary *)userInfo
{
    NSString *tag = userInfo[@"tag"];
    /*! 服务消息/官方公告 */
    if ([tag isEqualToString:@"1"]||[tag isEqualToString:@"3"]) {
        HXSysDetailController *serverListVC = [[HXSysDetailController alloc]init];
        if ([tag isEqualToString:@"1"]) {
            serverListVC.title = @"官方公告";
        }else if ([tag isEqualToString:@"3"]){
            serverListVC.title = @"服务消息";
        }
        serverListVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:serverListVC animated:YES];
    }
    /*! 每日一股 */
//    if ([tag isEqualToString:@"0"]) {
//        stockeModel.shares_id = @"";
//        [self pushToEveDayStockVC:stockeModel];
//    }
    /*! 早盘必读 */
//    if ([tag isEqualToString:@"1"]) {
//        stockeModel.shares_id = @"";
//        [self pushToEveDayStockVC:stockeModel];
//    }

}

#pragma mark - 前台接收到推送显示小红点
-(void)changeHomeMessage
{
    if (ISSERVERMESSAGE || ISRYCHATMESSAGE||ISSOFFICIALMESSAGE) {
        [self.homeMessageBtn showBadge];
    }else{
        [self.homeMessageBtn clearBadge];
    }
}

-(void)getRongYChatMessage:(NSNotification *)notification
{
    DDLog(@"notification=====%@",notification.object);
    NSDictionary *dic = notification.object;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic[@"allunread"] isEqualToString:@"0"]&&!ISSERVERMESSAGE&&!ISSOFFICIALMESSAGE) {
            [self.homeMessageBtn clearBadge];
            [StandardUserDefaults setBool:NO forKey:@"isRYChatMessage"];
        }else{
            /*! 融云消息显示小红点 */
            [self.homeMessageBtn showBadge];
            [StandardUserDefaults setBool:YES forKey:@"isRYChatMessage"];
        }
    }
}

-(void)dealloc
{
    
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
