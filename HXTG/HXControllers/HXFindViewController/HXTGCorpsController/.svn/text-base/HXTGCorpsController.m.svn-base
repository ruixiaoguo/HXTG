//
//  HXTGCorpsController.m
//  HXTG
//
//  Created by grx on 2017/5/4.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXTGCorpsController.h"
#import "HXTGCorpsDetailController.h"
#import "LrvingListReqtModel.h"
#import "HXLrvingListModel.h"
#import "HXLegionCell.h"

@interface HXTGCorpsController ()<UITableViewDelegate,UITableViewDataSource>{
    HXLegionCell *cell;
    int pageCount;
}

@property(nonatomic,strong) UITableView *legionTableView;
@property(nonatomic,strong) NSArray *sectionTitle;
@property(nonatomic,strong) NSMutableArray *allLegionArray;
@property(nonatomic,strong) NSMutableArray *nowLegionArray;  /*! 当前军团 */
@property(nonatomic,strong) NSMutableArray *ownLegionArray;  /*! 全部军团 */


@end

@implementation HXTGCorpsController

/*! 懒加载 */
-(UITableView *)legionTableView
{
    if (!_legionTableView) {
        _legionTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _legionTableView.delegate = self;
        _legionTableView.dataSource = self;
        _legionTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _legionTableView.backgroundColor = UIColorBgLightTheme;
        [_legionTableView registerClass:[HXLegionCell class] forCellReuseIdentifier:LegionListClassCellIdentifier];
    }
    return _legionTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投顾军团";
    self.backButton.hidden = NO;
    self.allLegionArray = [NSMutableArray arrayWithCapacity:0];
    self.nowLegionArray = [NSMutableArray arrayWithCapacity:0];
    self.ownLegionArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.legionTableView];
    _sectionTitle = @[@"当前投顾军团",@"全部投顾军团"];
    /*! 初始化异常界面 */
    [self initEmptyView:self.legionTableView];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    /*! 网络请求 */
    [self gaintLrvingList:NO];

}

#pragma mark -tableViewDelegete
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allLegionArray[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.allLegionArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    /*! 分割线 */
    UIView *lineViwe = [UIView new];
    lineViwe.backgroundColor = UIColorBlueTheme;
    lineViwe.frame = CGRectMake(6, 13, 4, 20);
    [header addSubview:lineViwe];
    /*! 文字标题 */
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorBlackTheme;
    label.font = UIFontSystem14;
    label.frame = CGRectMake(15, 3, 0, 0);
    label.width = 200;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [header addSubview:label];
    DDLog(@"_sectionTitlen======%@",_sectionTitle);
    DDLog(@"section======%ld",(long)section);
    if (self.allLegionArray.count==1) {
        label.text = @"全部投顾军团";
    }else{
        label.text = _sectionTitle[section];
    }
    header.backgroundColor = UIColorWhite;
    return header;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:LegionListClassCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    HXLrvingListModel *model = self.allLegionArray[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXTGCorpsDetailController *detailVC = [[HXTGCorpsDetailController alloc]init];
    HXLrvingListModel *model = self.allLegionArray[indexPath.section][indexPath.row];
    detailVC.LrvingId = model.lid;
    detailVC.LrvingName = model.lrving_name;
    [self.navigationController pushViewController :detailVC animated:YES];
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.legionTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintLrvingList:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.legionTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintLrvingList:YES];
    }];
}

#pragma mark - 军团列表网络请求
-(void)gaintLrvingList:(BOOL)isLoadMore
{
    [HXLoadingView show];
    LrvingListReqtModel *model = [[LrvingListReqtModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"Lrving/LrvingList" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.allLegionArray removeAllObjects];
                [self.nowLegionArray removeAllObjects];
                [self.ownLegionArray removeAllObjects];
            }
            if (responseDict[@"current"]!=nil&&self.nowLegionArray.count==0) {
                /*! 存在当前军团 */
                HXLrvingListModel *model = [HXLrvingListModel mj_objectWithKeyValues:responseDict[@"current"]];
                [self.nowLegionArray addObject:model];
                [self.allLegionArray addObject:self.nowLegionArray];
            }
            NSArray *lrvinglistArray = responseDict[@"lrvinglist"];
            if (lrvinglistArray.count!=0) {
                for (int i=0; i<[responseDict[@"lrvinglist"] count]; i++) {
                    NSDictionary *dic =responseDict[@"lrvinglist"][i];
                    HXLrvingListModel *model = [HXLrvingListModel mj_objectWithKeyValues:dic];
                    [self.ownLegionArray addObject:model];
                    DDLog(@"lrving_style=======%@",model.lrving_style);
                }
                [self.allLegionArray addObject:self.ownLegionArray];
            }

            [HXLoadingView hide];
            [self.legionTableView reloadData];
            if (isLoadMore == NO) {
                [self.legionTableView.mj_header endRefreshing];
                [self.legionTableView.mj_footer resetNoMoreData];
            }else{
                [self.legionTableView.mj_footer endRefreshing];
                
            }
            
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            
            if (pageCount==totalCountNum) {
                [self.legionTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.legionTableView.mj_header endRefreshing];
            [self.legionTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self showNoDataView:self.allLegionArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.legionTableView.mj_header endRefreshing];
        }else{
            [self.legionTableView.mj_footer endRefreshing];
        }
        [self showNoServerView:self.allLegionArray];
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.legionTableView.mj_header endRefreshing];
        }else{
            [self.legionTableView.mj_footer endRefreshing];
        }
        [self showNoNetView:self.allLegionArray];
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
