//
//  HXTrainingClassController.m
//  HXTG
//
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXTrainingClassController.h"
#import "HXTrainingClassCell.h"
#import "TrainingCourseRequestModel.h"
#import "HXOpenClassDetailController.h"

@interface HXTrainingClassController ()<UITableViewDelegate,UITableViewDataSource>{
    HXTrainingClassCell *cell;
    int pageCount;
}

@property(nonatomic,strong) UITableView *trainClassTableView;
@property (nonatomic,strong) NSMutableArray *trainClassArray;

@end

@implementation HXTrainingClassController

/*! 懒加载 */
-(UITableView *)trainClassTableView
{
    if (!_trainClassTableView) {
        _trainClassTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-104) style:UITableViewStyleGrouped];
        _trainClassTableView.delegate = self;
        _trainClassTableView.dataSource = self;
        _trainClassTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _trainClassTableView.backgroundColor = UIColorBgLightTheme;
        [_trainClassTableView registerClass:[HXTrainingClassCell class] forCellReuseIdentifier:TrainClassCellIdentifier];
    }
    return _trainClassTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.trainClassArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.trainClassTableView];
    
    /*! 初始化异常界面 */
    [self initEmptyView:self.trainClassTableView];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    
    [self gaintTrainingCourseList:NO];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.trainClassArray.count;
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
    cell = [tableView dequeueReusableCellWithIdentifier:TrainClassCellIdentifier forIndexPath:indexPath];
    cell.model = self.trainClassArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXTrainingCourseModel *model = self.trainClassArray[indexPath.row];
        if (self.trainingClassClick) {
            self.trainingClassClick(model);
        }
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.trainClassTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintTrainingCourseList:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.trainClassTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintTrainingCourseList:YES];
    }];
}

#pragma mark - 培训课程列表网络请求
-(void)gaintTrainingCourseList:(BOOL)isLoadMore
{
    [HXLoadingView show];
    TrainingCourseRequestModel *model = [[TrainingCourseRequestModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"Investment/TrainingCourse" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.trainClassArray removeAllObjects];
            }
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXTrainingCourseModel *model = [HXTrainingCourseModel mj_objectWithKeyValues:dic];
                [self.trainClassArray addObject:model];
            }
            [HXLoadingView hide];
            [self.trainClassTableView reloadData];
            if (isLoadMore == NO) {
                [self.trainClassTableView.mj_header endRefreshing];
                [self.trainClassTableView.mj_footer resetNoMoreData];
            }else{
                [self.trainClassTableView.mj_footer endRefreshing];
                
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.trainClassTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [self.trainClassTableView.mj_header endRefreshing];
            [HXLoadingView hide];
            [self.trainClassTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self showNoDataView:self.trainClassArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.trainClassTableView.mj_header endRefreshing];
        }else{
            [self.trainClassTableView.mj_footer endRefreshing];
        }
        [self showNoServerView:self.trainClassArray];
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.trainClassTableView.mj_header endRefreshing];
        }else{
            [self.trainClassTableView.mj_footer endRefreshing];
        }
        [self showNoNetView:self.trainClassArray];
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
