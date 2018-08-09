//
//  HXStockPoolController.m
//  HXTG
//
//  Created by grx on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXStockPoolController.h"
#import "HXStockDetailController.h"
#import "HXStockPoolHeadView.h"
#import "HXStockPoolCell.h"
#import "StockPoolRequestModel.h"
#import "HXStockPoolModel.h"

@interface HXStockPoolController ()<UITableViewDelegate,UITableViewDataSource>{
    HXStockPoolCell *cell;
    HXStockPoolHeadView *headView;
    int pageCount;
}

@property(nonatomic,strong) UITableView *stockPoolTableView;
@property(nonatomic,strong) NSMutableArray *stockPoolArray;
@property(nonatomic,strong) NSString *stock_style;

@end

@implementation HXStockPoolController

/*! 股票池懒加载 */
-(UITableView *)stockPoolTableView
{
    if (_stockPoolTableView==nil) {
        _stockPoolTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _stockPoolTableView.delegate = self;
        _stockPoolTableView.dataSource = self;
        _stockPoolTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _stockPoolTableView.showsVerticalScrollIndicator = NO;
        _stockPoolTableView.backgroundColor = UIColorBgLightTheme;
        [_stockPoolTableView registerClass:[HXStockPoolCell class] forCellReuseIdentifier:StockPoolCellIdentifier];
    }
    return _stockPoolTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.stockPoolArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.stockPoolTableView];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    /*! 初始化异常界面 */
    [self initEmptyView:self.stockPoolTableView];
    
    headView = [[HXStockPoolHeadView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 54)];
    self.stockPoolTableView.tableHeaderView = headView;
    WeakSelf(weakSelf);
    headView.styleSelectAction = ^(NSInteger segmentIndex){
        DDLog(@"选择风格====%ld",(long)segmentIndex);
        weakSelf.stock_style = [NSString stringWithFormat:@"%ld",segmentIndex+1];
        [weakSelf gaintStockPoolList:NO WithStyle:weakSelf.stock_style];
    };

    /*! 网络请求 */
    self.stock_style = @"1";
    [self gaintStockPoolList:NO WithStyle:self.stock_style];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.stockPoolArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:StockPoolCellIdentifier forIndexPath:indexPath];
    cell.model = self.stockPoolArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXStockDetailController *detailVC = [[HXStockDetailController alloc]init];
    detailVC.model = self.stockPoolArray[indexPath.row];
    detailVC.poolTitle = self.title;
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.stockPoolTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [weakSelf gaintStockPoolList:NO WithStyle:weakSelf.stock_style];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.stockPoolTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [weakSelf gaintStockPoolList:YES WithStyle:weakSelf.stock_style];
    }];
}


#pragma mark - 股票池列表网络请求
-(void)gaintStockPoolList:(BOOL)isLoadMore WithStyle:(NSString *)style
{
    [HXLoadingView show];
    StockPoolRequestModel *model = [[StockPoolRequestModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    model.stock_style = style;
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"stock/StockListNew" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        NSString *versionName = [NSString stringWithFormat:@"%@",responseDict[@"name"]];
        self.title = versionName;
        if ([status isEqualToString:@"1"]) {
            
            if (isLoadMore == NO) {
                [self.stockPoolArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXStockPoolModel *model = [HXStockPoolModel mj_objectWithKeyValues:dic];
                [self.stockPoolArray addObject:model];
            }
            
            [HXLoadingView hide];
            [self.stockPoolTableView reloadData];
        
            if (isLoadMore == NO) {
                [self.stockPoolTableView.mj_header endRefreshing];
                [self.stockPoolTableView.mj_footer resetNoMoreData];
            }else{
                [self.stockPoolTableView.mj_footer endRefreshing];
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.stockPoolTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            
            pageCount -= 1;
            [HXLoadingView hide];
            [self.stockPoolTableView.mj_footer endRefreshingWithNoMoreData];
            [self.stockPoolTableView.mj_header endRefreshing];
            if (isLoadMore == NO){
            [self.stockPoolArray removeAllObjects];
            }
            [self.stockPoolTableView reloadData];
        }
        [self showNoDataView:self.stockPoolArray];
        if ([self.title isEqualToString:@"<null>"]||[self.title isEqualToString:@"(null)"]) {
            self.title = @"股票池";
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.stockPoolTableView.mj_header endRefreshing];
        }else{
            [self.stockPoolTableView.mj_footer endRefreshing];
        }
        [self showNoServerView:self.stockPoolArray];
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.stockPoolTableView.mj_header endRefreshing];
        }else{
            [self.stockPoolTableView.mj_footer endRefreshing];
        }
        [self showNoNetView:self.stockPoolArray];
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
