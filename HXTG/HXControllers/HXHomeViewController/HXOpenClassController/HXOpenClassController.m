//
//  HXOpenClassController.m
//  HXTG
//
//  Created by grx on 2017/3/3.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXOpenClassController.h"
#import "HXOpenClassDetailController.h"
#import "HXOpenClassCell.h"
#import "OpenClassRequestModel.h"
#import "HXOpenClassModel.h"

@interface HXOpenClassController ()<UITableViewDelegate,UITableViewDataSource>{
    HXOpenClassCell *cell;
    int pageCount;
}

@property(nonatomic,strong) UITableView *openClassTableView;
@property(nonatomic,strong) NSMutableArray *openClassArray;

@end

@implementation HXOpenClassController

/*! 懒加载 */
-(UITableView *)openClassTableView
{
    if (!_openClassTableView) {
        _openClassTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _openClassTableView.delegate = self;
        _openClassTableView.dataSource = self;
        _openClassTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _openClassTableView.backgroundColor = UIColorBgLightTheme;
        [_openClassTableView registerClass:[HXOpenClassCell class] forCellReuseIdentifier:OpneClassCellIdentifier];
    }
    return _openClassTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*! 账号重复登录 */
    

    self.backButton.hidden = NO;
    self.openClassArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.openClassTableView];
    /*! 初始化异常界面 */
    [self initEmptyView:self.openClassTableView];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    /*! 网络请求 */
    [self gaintOpenClassList:NO];
}



#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.openClassArray.count;
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
    cell = [tableView dequeueReusableCellWithIdentifier:OpneClassCellIdentifier forIndexPath:indexPath];
    cell.model = self.openClassArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXOpenClassDetailController *detailVC = [[HXOpenClassDetailController alloc]init];
    HXOpenClassModel *model = self.openClassArray[indexPath.row];
    detailVC.postId = model.post_id;
    detailVC.playTitle = model.post_title;
    detailVC.title = self.title;
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.openClassTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [weakSelf gaintOpenClassList:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.openClassTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [weakSelf gaintOpenClassList:YES];
    }];
}

#pragma mark - 公开课列表网络请求
-(void)gaintOpenClassList:(BOOL)isLoadMore
{
    [HXLoadingView show];
    OpenClassRequestModel *model = [[OpenClassRequestModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    NSDictionary *dict = [model mj_keyValues];
    NSString *urlStr;
    if ([self.title isEqualToString:@"公开课"]) {
        urlStr = @"App/OpenClass";
    }else if ([self.title isEqualToString:@"操作报告"]||[self.title isEqualToString:@"操作计划A"]||[self.title isEqualToString:@"操作计划B"]||[self.title isEqualToString:@"持仓报告"]){
        urlStr = @"Investment/OperationReport";
    }else if ([self.title isEqualToString:@"机构实盘"]){
        urlStr = @"Investment/FirmOffer";
    }else{
        urlStr = @"App/OpenClass";
    }
    NSString *ttileStr = self.title;
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:urlStr WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        NSString *navName = [NSString stringWithFormat:@"%@",responseDict[@"name"]];
        self.title = navName;
        if ([self.title isEqualToString:@"(null)"]) {
            self.title = ttileStr;
        }
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.openClassArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXOpenClassModel *model = [HXOpenClassModel mj_objectWithKeyValues:dic];
                [self.openClassArray addObject:model];
            }
            
            [HXLoadingView hide];
            [self.openClassTableView reloadData];
            
            if (isLoadMore == NO) {
                [self.openClassTableView.mj_header endRefreshing];
                [self.openClassTableView.mj_footer resetNoMoreData];
            }else{
                [self.openClassTableView.mj_footer endRefreshing];
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.openClassTableView.mj_footer endRefreshingWithNoMoreData];
            }

        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.openClassTableView.mj_header endRefreshing];
            [self.openClassTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self showNoDataView:self.openClassArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.openClassTableView.mj_header endRefreshing];
        }else{
            [self.openClassTableView.mj_footer endRefreshing];
        }
        [self showNoServerView:self.openClassArray];
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.openClassTableView.mj_header endRefreshing];
        }else{
            [self.openClassTableView.mj_footer endRefreshing];
        }
        [self showNoNetView:self.openClassArray];
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
