//
//  HXMeViewController.m
//  HXTG
//
//  Created by grx on 2017/2/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMeViewController.h"
#import "HXNavigationController.h"
#import "HXLoginController.h"
#import "HXMyServerController.h"
#import "HXMyFollowController.h"
#import "CacheViewController.h"
#import "MyInvestmentController.h"
#import "MyOrderController.h"
#import "MySettingController.h"
#import "HXMeInfoController.h"
#import "HXComplaintController.h"
#import "HXMeCell.h"
#import "MeHeadView.h"
//#import "HXALIPayManager.h"
//#import "WXApi.h"

@interface HXMeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    HXMeCell *meCell;
    MeHeadView *meHeadView;
    BOOL isToLogin;
    NSString *messageStr;
}

@property(nonatomic,strong) UITableView *meTableView;
@property(nonatomic,strong) NSMutableArray *meArray;

@end

@implementation HXMeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isToLogin=NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if ([[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        meHeadView.userName.text = USERNAME;
    }else{
        meHeadView.userName.text = @"立即登录";
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:isToLogin animated:animated];
}

/*! 懒加载tableview */
-(UITableView *)meTableView
{
    if (!_meTableView) {
        _meTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -kStatusBarHeight, Main_Screen_Width, Main_Screen_Height+kStatusBarHeight) style:UITableViewStyleGrouped];
        _meTableView.delegate = self;
        _meTableView.dataSource = self;
        _meTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _meTableView.backgroundColor = ColorWithRGB(237, 237, 237);
        _meTableView.showsVerticalScrollIndicator=NO;
        [_meTableView registerClass:[HXMeCell class] forCellReuseIdentifier:MeCellIdentifier];
    }
    return _meTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*! 通知刷新首页 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshMeData) name:RefreshMeNotification object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的";
    self.meArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.view addSubview:self.meTableView];
    CGFloat meHeadHight = Main_Screen_Height*0.33;
    meHeadView=[[MeHeadView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, meHeadHight)];
    self.meTableView.tableHeaderView=meHeadView;
    WeakSelf(weakSelf);
    meHeadView.bgImageClickBlock = ^(){
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        /*! 未登录跳转到登录 */
        [weakSelf jumpToLoginVC];
    }else{
        /*! 已登录跳转到个人资料 */
        [weakSelf jumpToMeInfoVC];
    }
    };
    [self gaintIosCheck];
}

#pragma mark -tableViewDelegete
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.meArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    meCell = [tableView dequeueReusableCellWithIdentifier:MeCellIdentifier forIndexPath:indexPath];
    meCell.infoDic = self.meArray[indexPath.row];
    meCell.cellTag = indexPath.row+10;
    meCell.backgroundColor = [UIColor whiteColor];
    return meCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([messageStr isEqualToString:@"yes"]) {
        if (indexPath.row==3) {
            MySettingController *setVC = [[MySettingController alloc]init];
            setVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setVC animated:YES];
            return;
        }
    }else{
        if (indexPath.row==4) {
            MySettingController *setVC = [[MySettingController alloc]init];
            setVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setVC animated:YES];
            return;
        }
    }
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        [self jumpToLoginVC];
        return;
    }
    if ([messageStr isEqualToString:@"yes"]) {
        if (indexPath.row==4) {
            HXComplaintController *comVC = [[HXComplaintController alloc]init];
            comVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:comVC animated:YES];
            return;
        }
    }else{
        if (indexPath.row==5) {
            HXComplaintController *comVC = [[HXComplaintController alloc]init];
            comVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:comVC animated:YES];
            return;
        }
    }
    
    NSArray *viewControllers = [NSArray arrayWithObjects:@"HXMyServerController",@"HXMyFollowController",@"CacheViewController",@"MyOrderController",@"MySettingController",@"HXComplaintController",nil];
    UIViewController *selectVC = [[NSClassFromString(viewControllers[indexPath.row]) alloc]init];
    selectVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:selectVC animated:YES];
}
#pragma mark - 跳转到登录
-(void)jumpToLoginVC
{
    isToLogin = YES;
    HXLoginController *loginVC=[[HXLoginController alloc]init];
    HXNavigationController * loginNC = [[HXNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNC animated:YES completion:nil];
}

#pragma mark - 跳转到个人资料
-(void)jumpToMeInfoVC
{
    HXMeInfoController *meInfoVC=[[HXMeInfoController alloc]init];
    meInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:meInfoVC animated:YES];
}

#pragma mark - ==============审核开关==============================
-(void)gaintIosCheck
{
    [HXLoadingView show];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/iosexamine" WithParameter:nil WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *message = [NSString stringWithFormat:@"%@",responseDict[@"msg"]];
        messageStr = message;
        [self.meArray removeAllObjects];
        if ([message isEqualToString:@"no"]) {
            [self.meArray addObject:@{@"pic":@"wodefuwu",@"title":@"我的服务",@"isCheck":@"no"}];
            [self.meArray addObject:@{@"pic":@"wodeguanzhu",@"title":@"我的关注",@"isCheck":@"no"}];
            [self.meArray addObject:@{@"pic":@"huancun",@"title":@"离线缓存",@"isCheck":@"no"}];
            [self.meArray addObject:@{@"pic":@"wodedingdan",@"title":@"我的订单",@"isCheck":@"no"}];
            [self.meArray addObject:@{@"pic":@"setting",@"title":@"设置",@"isCheck":@"no"}];
            [self.meArray addObject:@{@"pic":@"tousu",@"title":@"投诉反馈",@"isCheck":@"no"}];
        }else{
            /*! 审核中 */
            [self.meArray addObject:@{@"pic":@"wodefuwu",@"title":@"我的服务",@"isCheck":@"yes"}];
            [self.meArray addObject:@{@"pic":@"wodeguanzhu",@"title":@"我的关注",@"isCheck":@"yes"}];
            [self.meArray addObject:@{@"pic":@"huancun",@"title":@"离线缓存",@"isCheck":@"yes"}];
            [self.meArray addObject:@{@"pic":@"setting",@"title":@"设置",@"isCheck":@"yes"}];
            [self.meArray addObject:@{@"pic":@"tousu",@"title":@"投诉反馈",@"isCheck":@"yes"}];
        }
        [self.meTableView reloadData];
        [HXLoadingView hide];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [self.meArray removeAllObjects];
        [self.meArray addObject:@{@"pic":@"wodefuwu",@"title":@"我的服务",@"isCheck":@"no"}];
        [self.meArray addObject:@{@"pic":@"wodeguanzhu",@"title":@"我的关注",@"isCheck":@"no"}];
        [self.meArray addObject:@{@"pic":@"huancun",@"title":@"离线缓存",@"isCheck":@"no"}];
        [self.meArray addObject:@{@"pic":@"wodedingdan",@"title":@"我的订单",@"isCheck":@"no"}];
        [self.meArray addObject:@{@"pic":@"setting",@"title":@"设置",@"isCheck":@"no"}];
        [self.meArray addObject:@{@"pic":@"tousu",@"title":@"投诉反馈",@"isCheck":@"no"}];
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];
}

#pragma mark - 登陆成功刷新我的
-(void)refreshMeData
{
    if ([[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        meHeadView.userName.text = USERNAME;
    }else{
        meHeadView.userName.text = @"立即登录";
    }
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
