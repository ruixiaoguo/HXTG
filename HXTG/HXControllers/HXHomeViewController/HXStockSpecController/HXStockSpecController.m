//
//  HXStockSpecController.m
//  HXTG
//
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXStockSpecController.h"
#import "HXSpecDetailController.h"
#import "HXStockSpecCell.h"
#import "StockSpecRequestModel.h"
#import "HXHomeCellModel.h"

@interface HXStockSpecController ()<UITableViewDelegate,UITableViewDataSource>{
    HXStockSpecCell *cell;
    int pageCount;
}

@property(nonatomic,strong) UITableView *stockSpecTableView;
@property(nonatomic,strong) NSMutableArray *speculationListArray;

@end

@implementation HXStockSpecController

/*! 懒加载 */
-(UITableView *)stockSpecTableView
{
    if (!_stockSpecTableView) {
        _stockSpecTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _stockSpecTableView.delegate = self;
        _stockSpecTableView.dataSource = self;
        _stockSpecTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _stockSpecTableView.backgroundColor = UIColorBgLightTheme;
        [_stockSpecTableView registerClass:[HXStockSpecCell class] forCellReuseIdentifier:StockSpecCellIdentifier];
    }
    return _stockSpecTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.navigationItem.title = @"炒股攻略";
    self.speculationListArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.stockSpecTableView];
    /*! 初始化异常界面 */
    [self initEmptyView:self.stockSpecTableView];
    /*! 网络请求 */
    [self gaintStockSpecList:NO];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.speculationListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:StockSpecCellIdentifier forIndexPath:indexPath];
    cell.model = self.speculationListArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXSpecDetailController *specDetailVC = [[HXSpecDetailController alloc]init];
    HXHomeCellModel *model = self.speculationListArray[indexPath.row];
    specDetailVC.model = model;
    [self.navigationController pushViewController:specDetailVC animated:YES];
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.stockSpecTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintStockSpecList:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.stockSpecTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintStockSpecList:YES];
    }];
}


-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 炒股攻略列表
-(void)gaintStockSpecList:(BOOL)isLoadMore
{
    StockSpecRequestModel *model = [[StockSpecRequestModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    [HXLoadingView show];
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/SpeculationList" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.speculationListArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXHomeCellModel *model = [HXHomeCellModel mj_objectWithKeyValues:dic];
                [self.speculationListArray addObject:model];
            }
            [HXLoadingView hide];
            [self.stockSpecTableView reloadData];
            if (isLoadMore == NO) {
                [self.stockSpecTableView.mj_header endRefreshing];
                [self.stockSpecTableView.mj_footer resetNoMoreData];
            }else{
                [self.stockSpecTableView.mj_footer endRefreshing];
                
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.stockSpecTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.stockSpecTableView.mj_header endRefreshing];
            [self.stockSpecTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self showNoDataView:self.speculationListArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.stockSpecTableView.mj_header endRefreshing];
        }else{
            [self.stockSpecTableView.mj_footer endRefreshing];
        }
        [self showNoServerView:self.speculationListArray];
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.stockSpecTableView.mj_header endRefreshing];
        }else{
            [self.stockSpecTableView.mj_footer endRefreshing];
        }
        [self showNoNetView:self.speculationListArray];
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
