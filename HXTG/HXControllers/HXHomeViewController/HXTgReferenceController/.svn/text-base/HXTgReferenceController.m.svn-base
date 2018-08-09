//
//  HXTgReferenceController.m
//  HXTG
//
//  Created by grx on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXTgReferenceController.h"
#import "HXOpenClassDetailController.h"
#import "HXTgReferenceCell.h"
#import "TgRefeRequestModel.h"
#import "HXTgRefeModel.h"

@interface HXTgReferenceController ()<UITableViewDelegate,UITableViewDataSource>{
    HXTgReferenceCell *cell;
    int pageCount;
}

@property(nonatomic,strong) UITableView *tgReferTableView;
@property(nonatomic,strong) NSMutableArray *tgReferenceArray;

@end

@implementation HXTgReferenceController

/*! 懒加载 */
-(UITableView *)tgReferTableView
{
    if (!_tgReferTableView) {
        _tgReferTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _tgReferTableView.delegate = self;
        _tgReferTableView.dataSource = self;
        _tgReferTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tgReferTableView.backgroundColor = UIColorBgLightTheme;
        [_tgReferTableView registerClass:[HXTgReferenceCell class] forCellReuseIdentifier:TgReferenceCellIdentifier];
    }
    return _tgReferTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.tgReferenceArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.tgReferTableView];
    /*! 初始化异常界面 */
    [self initEmptyView:self.tgReferTableView];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    /*! 网络请求 */
    [self gaintTheReferenceList:NO];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tgReferenceArray.count;
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
    cell = [tableView dequeueReusableCellWithIdentifier:TgReferenceCellIdentifier forIndexPath:indexPath];
    cell.model = self.tgReferenceArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXOpenClassDetailController *detailVC = [[HXOpenClassDetailController alloc]init];
    HXTgRefeModel *model = self.tgReferenceArray[indexPath.row];
    detailVC.postId = model.post_id;
    detailVC.playTitle = model.post_title;
    detailVC.title = self.title;
    [self.navigationController pushViewController:detailVC animated:YES];
}


/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.tgReferTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintTheReferenceList:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.tgReferTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintTheReferenceList:YES];
    }];
}


-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 投顾内参列表网络请求
-(void)gaintTheReferenceList:(BOOL)isLoadMore
{
    [HXLoadingView show];
    TgRefeRequestModel *model = [[TgRefeRequestModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    model.type = @"3";
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"Investment/TheReference" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        NSString *versionName = [NSString stringWithFormat:@"%@",responseDict[@"name"]];
        self.title = versionName;
        if ([status isEqualToString:@"1"]) {
            
            if (isLoadMore == NO) {
                [self.tgReferenceArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXTgRefeModel *model = [HXTgRefeModel mj_objectWithKeyValues:dic];
                [self.tgReferenceArray addObject:model];
            }
            
            [HXLoadingView hide];
            [self.tgReferTableView reloadData];
            if (isLoadMore == NO) {
                [self.tgReferTableView.mj_header endRefreshing];
                [self.tgReferTableView.mj_footer resetNoMoreData];
            }else{
                [self.tgReferTableView.mj_footer endRefreshing];
                
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.tgReferTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.tgReferTableView.mj_header endRefreshing];
            [self.tgReferTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self showNoDataView:self.tgReferenceArray];
        if ([self.title isEqualToString:@"<null>"]||[self.title isEqualToString:@"(null)"]) {
            self.title = @"投顾内参";
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.tgReferTableView.mj_header endRefreshing];
        }else{
            [self.tgReferTableView.mj_footer endRefreshing];
        }
        [self showNoServerView:self.tgReferenceArray];
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.tgReferTableView.mj_header endRefreshing];
        }else{
            [self.tgReferTableView.mj_footer endRefreshing];
        }
        [self showNoNetView:self.tgReferenceArray];
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
