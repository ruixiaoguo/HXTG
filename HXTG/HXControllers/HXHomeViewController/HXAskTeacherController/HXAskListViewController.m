//
//  HXAskListViewController.m
//  HXTG
//
//  Created by grx on 2017/6/8.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXAskListViewController.h"
#import "HXAskListCell.h"
#import "HXChatViewController.h"
#import "AskListRequestModel.h"
#import "HXAskListModel.h"

@interface HXAskListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    HXAskListCell *listCell;
}
@property(nonatomic,strong) UITableView *askListTableView;
@property(nonatomic,strong) NSMutableArray *askListArray;

@end

@implementation HXAskListViewController
/*! 懒加载 */
-(UITableView *)askListTableView
{
    if (!_askListTableView) {
        _askListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _askListTableView.delegate = self;
        _askListTableView.dataSource = self;
        _askListTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _askListTableView.backgroundColor = UIColorBgLightTheme;
        [_askListTableView registerClass:[HXAskListCell class] forCellReuseIdentifier:askListCellIdentifier];
    }
    return _askListTableView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*! 请求军团老师接口 */
    [self gaintMyAskTeacherList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRongYUnChatMessage) name:RYGetUnChatNotification object:nil];
    /*! 初始化异常界面 */
    [self initEmptyView:self.askListTableView];
    /*! 接收到融云在线消息 */
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.title = [NSString stringWithFormat:@"%@",self.legionName];
    self.askListArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.askListTableView];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.askListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    listCell = [tableView dequeueReusableCellWithIdentifier:askListCellIdentifier forIndexPath:indexPath];
    listCell.model = self.askListArray[indexPath.row];
    return listCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXAskListModel *model = self.askListArray[indexPath.row];
    HXChatViewController *chatVC = [[HXChatViewController alloc] init];
    chatVC.conversationType = ConversationType_PRIVATE;
    chatVC.targetId = model.uid;
    chatVC.legionName = model.user_nicename;
    chatVC.teacherNum = model.card_number;
    [self.navigationController pushViewController:chatVC animated:YES];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 我的军团老师列表网络请求
-(void)gaintMyAskTeacherList
{
    [HXLoadingView show];
    AskListRequestModel *model = [[AskListRequestModel alloc]init];
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"lrving/LrvingMember" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [self.askListArray removeAllObjects];
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXAskListModel *model = [HXAskListModel mj_objectWithKeyValues:dic];
                model.unReadMessage = @"";
                [self.askListArray addObject:model];
            }
            for (int i=0; i<self.askListArray.count; i++) {
                HXAskListModel *model = self.askListArray[i];
                int allunread = [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_PRIVATE targetId:model.uid];
                model.unReadMessage = [NSString stringWithFormat:@"%d",allunread];
                DDLog(@"allunread11111=====%d",allunread);
            }
            [HXLoadingView hide];
        }else{
            [self.askListArray removeAllObjects];
            [HXLoadingView hide];
        }
        [self.askListTableView reloadData];
        [self gaintIosCheck];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [self gaintIosCheck];
        [HXLoadingView hide];
        
    } WithFailureBlock:^{
        [self gaintIosCheck];
        [HXLoadingView hide];
    }];
}

#pragma mark - ==============审核开关==============================
-(void)gaintIosCheck
{
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/iosexamine" WithParameter:nil WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        NSString *message = [NSString stringWithFormat:@"%@",responseDict[@"msg"]];
        if ([message isEqualToString:@"yes"]) {
            self.title = @"问老师";
            [self showNoDataView:self.askListArray];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
    } WithFailureBlock:^{
    }];
}


-(void)getRongYUnChatMessage
{
        for (int i=0; i<self.askListArray.count; i++) {
            HXAskListModel *model = self.askListArray[i];
            int allunread = [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_PRIVATE targetId:model.uid];
            model.unReadMessage = [NSString stringWithFormat:@"%d",allunread];
            DDLog(@"allunread11111=====%d",allunread);
        }
        [self.askListTableView reloadData];
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
