//
//  HXMyFollowController.m
//  HXTG
//
//  Created by grx on 2017/3/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMyFollowController.h"
#import "MyFollowRequestModel.h"
#import "StockPoolRequestModel.h"
#import "HXStockDetailController.h"
#import "HXMyFollowCell.h"

@interface HXMyFollowController ()<UITableViewDelegate,UITableViewDataSource>{
    HXMyFollowCell *cell;
    int pageCount;
    
}

@property(nonatomic,strong) UITableView *myFollowTableView;
@property(nonatomic,strong) NSMutableArray *myFollowArray;

@end

@implementation HXMyFollowController

/*! 懒加载 */
-(UITableView *)myFollowTableView
{
    if (!_myFollowTableView) {
        _myFollowTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _myFollowTableView.delegate = self;
        _myFollowTableView.dataSource = self;
        _myFollowTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _myFollowTableView.backgroundColor = UIColorBgLightTheme;
        [_myFollowTableView registerClass:[HXMyFollowCell class] forCellReuseIdentifier:myFollowCellIdentifier];
    }
    return _myFollowTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    self.backButton.hidden = NO;
    self.myFollowArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.myFollowTableView];
    /*! 初始化异常界面 */
    [self initEmptyView:self.myFollowTableView];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    /*! 网络请求 */
    [self gaintMyFollowList:NO];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.myFollowArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:myFollowCellIdentifier forIndexPath:indexPath];
    cell.model = self.myFollowArray[indexPath.row];
    cell.followBtn.tag = indexPath.row+10;
    WeakSelf(weakSelf);
    cell.cancelFollowClick = ^(NSInteger tag){
        HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"确定要取消关注吗?" rightButtonTitle:@"确定" leftButtonTitle:@"取消"];
        alter.rightBlock=^()
        {
            HXMyFollowModel *model = weakSelf.myFollowArray[tag-10];
            [weakSelf gaintStockFollow:model.stock_id withTag:tag-10];
        };
        alter.leftBlock=^()
        {
            
        };
        [alter show];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXStockDetailController *detailVC = [[HXStockDetailController alloc]init];
    detailVC.model = self.myFollowArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.refreshMyFollow = ^(){
        [self gaintMyFollowList:NO];
    };
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.myFollowTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintMyFollowList:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.myFollowTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintMyFollowList:YES];
    }];
}


-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 我的关注列表网络请求
-(void)gaintMyFollowList:(BOOL)isLoadMore
{
    [HXLoadingView show];
    MyFollowRequestModel *model = [[MyFollowRequestModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/UserStockFollow" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.myFollowArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXStockPoolModel *model = [HXStockPoolModel mj_objectWithKeyValues:dic];
                [self.myFollowArray addObject:model];
            }
            if (isLoadMore == NO) {
                [self.myFollowTableView.mj_header endRefreshing];
                [self.myFollowTableView.mj_footer resetNoMoreData];
            }else{
                [self.myFollowTableView.mj_footer endRefreshing];
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.myFollowTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.myFollowTableView.mj_header endRefreshing];
            [self.myFollowTableView.mj_footer endRefreshingWithNoMoreData];
            if (isLoadMore == NO) {
            [self.myFollowArray removeAllObjects];
            }
        }
        [HXLoadingView hide];
        [self.myFollowTableView reloadData];
        [self showNoDataView:self.myFollowArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.myFollowTableView.mj_header endRefreshing];
        }else{
            [self.myFollowTableView.mj_footer endRefreshing];
        }
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.myFollowTableView.mj_header endRefreshing];
        }else{
            [self.myFollowTableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - 取消关注网络请求
-(void)gaintStockFollow:(NSString *)stock_id withTag:(NSInteger)tag
{
    StockFollowRequestModel *model = [[StockFollowRequestModel alloc]init];
    model.type = @"2";
    model.stock_id = stock_id;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"stock/StockFollow" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        [HXLoadingView show];
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [self.myFollowArray removeObjectAtIndex:tag];
            [self.myFollowTableView reloadData];
            [HXLoadingView hide];
        }else{
            [HXLoadingView hide];
            [HXProgressHUD showMessage:self.view
                             labelText:responseDict[@"msg"]
                                  mode:MBProgressHUDModeText];
        }
        [self showNoDataView:self.myFollowArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [self showNoServerView:self.myFollowArray];
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [self showNoNetView:self.myFollowArray];
        [HXLoadingView hide];
    }];
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
