//
//  MyOrderController.m
//  HXTG
//
//  Created by grx on 2017/3/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "MyOrderController.h"
#import "HXMyOrderCell.h"
#import "HXMyOrderModel.h"
#import "MyOrderRequestModel.h"
#import "MyOrderDetailController.h"

@interface MyOrderController ()<UITableViewDelegate,UITableViewDataSource>{
    HXMyOrderCell *cell;
    int pageCount;
}

@property(nonatomic,strong) UITableView *myOrderTableView;
@property(nonatomic,strong) NSMutableArray *myOrderArray;

@end

@implementation MyOrderController

/*! 懒加载 */
-(UITableView *)myOrderTableView
{
    if (!_myOrderTableView) {
        _myOrderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _myOrderTableView.delegate = self;
        _myOrderTableView.dataSource = self;
        _myOrderTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _myOrderTableView.backgroundColor = UIColorBgLightTheme;
        [_myOrderTableView registerClass:[HXMyOrderCell class] forCellReuseIdentifier:OrderClassCellIdentifier];
    }
    return _myOrderTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.backButton.hidden = NO;
    self.myOrderArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.myOrderTableView];
    /*! 初始化异常界面 */
    [self initEmptyView:self.myOrderTableView];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    /*! 网络请求 */
    [self gaintMyOrderList:NO];

}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myOrderArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:OrderClassCellIdentifier forIndexPath:indexPath];
    cell.orderModel = self.myOrderArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXMyOrderModel *model = self.myOrderArray[indexPath.row];
    MyOrderDetailController *detailVC = [[MyOrderDetailController alloc]init];
    detailVC.orderNum = model.order_sn;
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.myOrderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintMyOrderList:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.myOrderTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintMyOrderList:YES];
    }];
}

#pragma mark - 我的订单列表网络请求
-(void)gaintMyOrderList:(BOOL)isLoadMore
{
    [HXLoadingView show];
    MyOrderRequestModel *model = [[MyOrderRequestModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"MyOrder/OrderList" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.myOrderArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXMyOrderModel *model = [HXMyOrderModel mj_objectWithKeyValues:dic];
                DDLog(@"order_sn=====%@",model.order_sn);
                DDLog(@"state=====%@",model.state);

                [self.myOrderArray addObject:model];
            }
            
            [HXLoadingView hide];
            [self.myOrderTableView reloadData];
            if (isLoadMore == NO) {
                [self.myOrderTableView.mj_header endRefreshing];
                [self.myOrderTableView.mj_footer resetNoMoreData];
            }else{
                [self.myOrderTableView.mj_footer endRefreshing];
                
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            
            if (pageCount==totalCountNum) {
                [self.myOrderTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.myOrderTableView.mj_header endRefreshing];
            [self.myOrderTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self showNoDataView:self.myOrderArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.myOrderTableView.mj_header endRefreshing];
        }else{
            [self.myOrderTableView.mj_footer endRefreshing];
        }
        [self showNoServerView:self.myOrderArray];
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.myOrderTableView.mj_header endRefreshing];
        }else{
            [self.myOrderTableView.mj_footer endRefreshing];
        }
        [self showNoNetView:self.myOrderArray];
    }];
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
