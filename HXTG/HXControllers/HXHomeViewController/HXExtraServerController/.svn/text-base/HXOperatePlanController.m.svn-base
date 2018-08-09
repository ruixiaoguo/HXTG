//
//  HXOperatePlanViewController.m
//  HXTG
//
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXOperatePlanController.h"
#import "HXOperatePlanCell.h"
#import "TraderPlanRequestModel.h"
#import "HXOpenClassDetailController.h"

@interface HXOperatePlanController ()<UITableViewDelegate,UITableViewDataSource>{
    HXOperatePlanCell *cell;
    int pageCount;
}

@property (nonatomic,strong) NSMutableArray *planArray;

@end

@implementation HXOperatePlanController

/*! 懒加载 */
-(UITableView *)planTableView
{
    if (!_planTableView) {
        _planTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-104) style:UITableViewStyleGrouped];
        _planTableView.delegate = self;
        _planTableView.dataSource = self;
        _planTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _planTableView.backgroundColor = UIColorBgLightTheme;
        [_planTableView registerClass:[HXOperatePlanCell class] forCellReuseIdentifier:OperatePlanCellIdentifier];
    }
    return _planTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.planArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.planTableView];
    /*! 初始化异常界面 */
    [self initEmptyView:self.planTableView];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    
    [self gaintThePlanList:NO];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.planArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:OperatePlanCellIdentifier forIndexPath:indexPath];
    cell.model = self.planArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXTraderPlanModel *model = self.planArray[indexPath.row];
    if (self.operateClick) {
        self.operateClick(model);
    }
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.planTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintThePlanList:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.planTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintThePlanList:YES];
    }];
}


#pragma mark - 操盘计划列表网络请求
-(void)gaintThePlanList:(BOOL)isLoadMore
{
    [HXLoadingView show];
    TraderPlanRequestModel *model = [[TraderPlanRequestModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"Investment/TraderPlan" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"操盘计划列表======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.planArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXTraderPlanModel *model = [HXTraderPlanModel mj_objectWithKeyValues:dic];
                [self.planArray addObject:model];
            }
            
            [HXLoadingView hide];
            [self.planTableView reloadData];
            if (isLoadMore == NO) {
                [self.planTableView.mj_header endRefreshing];
                [self.planTableView.mj_footer resetNoMoreData];
            }else{
                [self.planTableView.mj_footer endRefreshing];
                
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.planTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.planTableView.mj_header endRefreshing];
            [self.planTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self showNoDataView:self.planArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.planTableView.mj_header endRefreshing];
        }else{
            [self.planTableView.mj_footer endRefreshing];
        }
        [self showNoServerView:self.planArray];
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.planTableView.mj_header endRefreshing];
        }else{
            [self.planTableView.mj_footer endRefreshing];
        }
        [self showNoNetView:self.planArray];
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
