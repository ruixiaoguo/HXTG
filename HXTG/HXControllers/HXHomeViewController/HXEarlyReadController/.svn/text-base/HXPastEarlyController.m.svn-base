//
//  HXPastEarlyController.m
//  HXTG
//
//  Created by grx on 2017/3/7.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXPastEarlyController.h"
#import "HXPastEarlyCell.h"
#import "EarlyRequestModel.h"
#import "HXPastEarlyModel.h"
#import "HXOpenClassDetailController.h"

@interface HXPastEarlyController ()<UITableViewDelegate,UITableViewDataSource>{
    HXPastEarlyCell *pastCell;
    int pageCount;
}

@property(nonatomic,strong) UITableView *pastEarlyTableview;
@property(nonatomic,strong) NSMutableArray *pastEarlyArray;

@end

@implementation HXPastEarlyController

#pragma mark - 懒加载

-(UITableView *)pastEarlyTableview
{
    if (!_pastEarlyTableview) {
        _pastEarlyTableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _pastEarlyTableview.delegate = self;
        _pastEarlyTableview.dataSource = self;
        _pastEarlyTableview.separatorStyle = UITableViewCellSelectionStyleNone;
        _pastEarlyTableview.backgroundColor = UIColorBgLightTheme;
        [_pastEarlyTableview registerClass:[HXPastEarlyCell class] forCellReuseIdentifier:PastEarylyCellIdentifier];
    }
    return _pastEarlyTableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.navigationItem.title = @"往日早盘";
    self.pastEarlyArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.pastEarlyTableview];
    /*! 初始化异常界面 */
    [self initEmptyView:self.pastEarlyTableview];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    /*! 网络请求 */
    [self gaintEarlyHistory:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.pastEarlyArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    pastCell = [tableView dequeueReusableCellWithIdentifier:PastEarylyCellIdentifier forIndexPath:indexPath];
    pastCell.model = self.pastEarlyArray[indexPath.row];
    return pastCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXOpenClassDetailController *detailVC = [[HXOpenClassDetailController alloc]init];
    HXPastEarlyModel *model = self.pastEarlyArray[indexPath.row];
    detailVC.postId = model.post_id;
    detailVC.playTitle = model.post_title;
    detailVC.title = @"往日早盘";
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.pastEarlyTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintEarlyHistory:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.pastEarlyTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintEarlyHistory:YES];
    }];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 往日早盘列表网络请求
-(void)gaintEarlyHistory:(BOOL)isLoadMore
{
    
    [HXLoadingView show];
    EarlyRequestModel *model = [[EarlyRequestModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/EarlyHistory" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.pastEarlyArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXPastEarlyModel *model = [HXPastEarlyModel mj_objectWithKeyValues:dic];
                [self.pastEarlyArray addObject:model];
            }
            [HXLoadingView hide];
            [self.pastEarlyTableview reloadData];
            if (isLoadMore == NO) {
                [self.pastEarlyTableview.mj_header endRefreshing];
                [self.pastEarlyTableview.mj_footer resetNoMoreData];
            }else{
                [self.pastEarlyTableview.mj_footer endRefreshing];
                
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.pastEarlyTableview.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.pastEarlyTableview.mj_header endRefreshing];
            [self.pastEarlyTableview.mj_footer endRefreshingWithNoMoreData];
        }
        [self showNoDataView:self.pastEarlyArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.pastEarlyTableview.mj_header endRefreshing];
        }else{
            [self.pastEarlyTableview.mj_footer endRefreshing];
        }
        [self showNoServerView:self.pastEarlyArray];
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.pastEarlyTableview.mj_header endRefreshing];
        }else{
            [self.pastEarlyTableview.mj_footer endRefreshing];
        }
        [self showNoNetView:self.pastEarlyArray];
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
