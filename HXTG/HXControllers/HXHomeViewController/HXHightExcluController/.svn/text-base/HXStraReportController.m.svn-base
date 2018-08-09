//
//  HXStraReportcController.m
//  HXTG
//
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXStraReportController.h"
#import "HXStraReportCell.h"
#import "StraReptRequestModel.h"

@interface HXStraReportController ()<UITableViewDelegate,UITableViewDataSource>{
    HXStraReportCell *cell;
    int pageCount;
}

@property(nonatomic,strong) UITableView *reportTableView;
@property(nonatomic,strong) NSMutableArray *reportArray;

@end

@implementation HXStraReportController

/*! 懒加载 */
-(UITableView *)reportTableView
{
    if (!_reportTableView) {
        _reportTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-104) style:UITableViewStyleGrouped];
        _reportTableView.delegate = self;
        _reportTableView.dataSource = self;
        _reportTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _reportTableView.backgroundColor = UIColorBgLightTheme;
        [_reportTableView registerClass:[HXStraReportCell class] forCellReuseIdentifier:StraReportCellIdentifier];
    }
    return _reportTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.reportArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.reportTableView];
    /*! 初始化异常界面 */
    [self initEmptyView:self.reportTableView];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    [self gaintStraReportList:NO];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.reportArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:StraReportCellIdentifier forIndexPath:indexPath];
    cell.model = self.reportArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXStraReportModel *model = self.reportArray[indexPath.row];
    if (self.straReportClick) {
        self.straReportClick(model);
    }
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.reportTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintStraReportList:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.reportTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintStraReportList:YES];
    }];
}

#pragma mark - 策略报告列表网络请求
-(void)gaintStraReportList:(BOOL)isLoadMore
{
    
    StraReptRequestModel *model = [[StraReptRequestModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    NSDictionary *dict = [model mj_keyValues];
    [HXLoadingView show];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"Investment/StrategyReport" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.reportArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXStraReportModel *model = [HXStraReportModel mj_objectWithKeyValues:dic];
                [self.reportArray addObject:model];
            }
            
            [HXLoadingView hide];
            [self.reportTableView reloadData];
            if (isLoadMore == NO) {
                [self.reportTableView.mj_header endRefreshing];
                [self.reportTableView.mj_footer resetNoMoreData];
            }else{
                [self.reportTableView.mj_footer endRefreshing];
                
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.reportTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.reportTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self showNoDataView:self.reportArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.reportTableView.mj_header endRefreshing];
        }else{
            [self.reportTableView.mj_footer endRefreshing];
        }
        [self showNoServerView:self.reportArray];

    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.reportTableView.mj_header endRefreshing];
        }else{
            [self.reportTableView.mj_footer endRefreshing];
        }
        [self showNoNetView:self.reportArray];
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
