//
//  HXLiveHistoryController.m
//  HXTG
//
//  Created by grx on 2017/4/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXLiveHistoryController.h"
#import "HXPastLiveCell.h"
#import "LiveHistoryReqModel.h"

@interface HXLiveHistoryController ()<UITableViewDelegate,UITableViewDataSource>{
    HXPastLiveCell *cell;
    int pageCount;
}

@property (strong, nonatomic) UITableView *pastLivetableView;
@property (strong, nonatomic) NSMutableArray *pastLiveArray;

@end

@implementation HXLiveHistoryController

/*! 懒加载 */
-(UITableView *)pastLivetableView
{
    if (!_pastLivetableView) {
        _pastLivetableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-Main_Screen_Height/3.28-125) style:UITableViewStyleGrouped];
        
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
    self.pastLiveArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.pastLivetableView];
    /*! 初始化异常界面 */
    [self initEmptyView:self.pastLivetableView withFrame:_pastLivetableView.frame];

    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    [self gaintLiveHistory:NO];
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
    if (self.liveHistoryClick) {
        self.liveHistoryClick(model);
    }
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

#pragma mark - 往期直播列表网络请求
-(void)gaintLiveHistory:(BOOL)isLoadMore
{
    
    LiveHistoryReqModel *model = [[LiveHistoryReqModel alloc]init];
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
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.pastLiveArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXLiveHistoryModel *model = [HXLiveHistoryModel mj_objectWithKeyValues:dic];
                [self.pastLiveArray addObject:model];
            }
            
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
        [self showNoDataView:self.pastLiveArray];
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
