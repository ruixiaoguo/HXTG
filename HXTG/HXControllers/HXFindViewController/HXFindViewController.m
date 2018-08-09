//
//  HXFindViewController.m
//  HXTG
//
//  Created by grx on 2017/2/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXFindViewController.h"
#import "HXNavigationController.h"
#import "HXLoginController.h"
#import "HXMessageListController.h"
#import "HXAboutUsWebController.h"
#import "HXCustSerWebController.h"
#import "HXServerVersionController.h"
#import "HXSystemMsgController.h"
#import "HXServerListController.h"
#import "HXTGCorpsController.h"
#import "HXFindCell.h"
#import "FindHeadView.h"
#import "HXSysDetailController.h"

@interface HXFindViewController ()<UITableViewDelegate,UITableViewDataSource>{
    HXFindCell *findCell;
    FindHeadView *findView;
    NSString *messageStr;
}

@property(nonatomic,strong) UITableView *findTableView;
@property(nonatomic,strong) NSMutableArray *findArray;

@end

@implementation HXFindViewController

/*! 懒加载tableview */
-(UITableView *)findTableView
{
    if (!_findTableView) {
        _findTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _findTableView.delegate = self;
        _findTableView.dataSource = self;
        _findTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _findTableView.backgroundColor = UIColorBgLightTheme;
        _findTableView.showsVerticalScrollIndicator=NO;
        [_findTableView registerClass:[HXFindCell class] forCellReuseIdentifier:FindCellIdentifier];
    }
    return _findTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorWhite;
    self.messageBtn.hidden = NO;
    self.navigationItem.title = @"发现";
    self.findArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.view addSubview:self.findTableView];
    CGFloat meHeadHight = Main_Screen_Height/4.65;
    findView=[[FindHeadView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, meHeadHight)];
    self.findTableView.tableHeaderView=findView;
    WeakSelf(weakSelf);
    findView.bgViewClickTapClickBlock = ^(NSInteger tag){
        if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
        {
            [weakSelf jumpToLoginVC];
            return;
        }
        if (tag==10) {
            /*! 关于我们 */
            HXAboutUsWebController *aboutWebVC = [[HXAboutUsWebController alloc]init];
            aboutWebVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:aboutWebVC animated:YES];
        }else{
            /*! 客户服务 */
            HXCustSerWebController *serverWebVC = [[HXCustSerWebController alloc]init];
            serverWebVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:serverWebVC animated:YES];
        }
    };
    [self gaintIosCheck];
}

#pragma mark -tableViewDelegete
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.findArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    findCell = [tableView dequeueReusableCellWithIdentifier:FindCellIdentifier forIndexPath:indexPath];
    findCell.infoDic = self.findArray[indexPath.row];
    findCell.cellTag = indexPath.row+100;
    findCell.backgroundColor = [UIColor whiteColor];
    return findCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        [self jumpToLoginVC];
        return;
    }
    
    if (indexPath.row==0) {
        /*! 投顾军团 */
        HXTGCorpsController *corpsVC = [[HXTGCorpsController alloc]init];
        corpsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:corpsVC animated:YES];
    }
    if (indexPath.row==1) {
        if ([messageStr isEqualToString:@"yes"]) {
            /*! 官方公告 */
            HXSysDetailController *serverVC = [[HXSysDetailController alloc]init];
            serverVC.hidesBottomBarWhenPushed = YES;
            serverVC.title = @"官方公告";
            [self.navigationController pushViewController:serverVC animated:YES];
            return;
        }
        /*! 服务版本 */
        HXServerVersionController *versionVC = [[HXServerVersionController alloc]init];
        versionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:versionVC animated:YES];
    }
    if (indexPath.row==2) {
        if ([messageStr isEqualToString:@"yes"]) {
            /*! 服务消息 */
            HXSysDetailController *serverVC = [[HXSysDetailController alloc]init];
            serverVC.title = @"服务消息";
            serverVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:serverVC animated:YES];
            return;
        }
        /*! 官方公告 */
        HXSysDetailController *serverVC = [[HXSysDetailController alloc]init];
        serverVC.hidesBottomBarWhenPushed = YES;
        serverVC.title = @"官方公告";
        [self.navigationController pushViewController:serverVC animated:YES];
    }
    if (indexPath.row==3) {
        /*! 服务消息 */
        HXSysDetailController *serverVC = [[HXSysDetailController alloc]init];
        serverVC.title = @"服务消息";
        serverVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:serverVC animated:YES];
    }
    
}

-(void)doMessageAction:(UIButton *)sender
{
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        [self jumpToLoginVC];
    }else{
        HXMessageListController *messageVC = [[HXMessageListController alloc]init];
        messageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:messageVC animated:YES];
    }
}

#pragma mark - 跳转到登录
-(void)jumpToLoginVC
{
    HXLoginController *loginVC=[[HXLoginController alloc]init];
    HXNavigationController * loginNC = [[HXNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNC animated:YES completion:nil];
    
}

#pragma mark - ==============审核开关==============================
-(void)gaintIosCheck
{
    [HXLoadingView show];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/iosexamine" WithParameter:nil WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *message = [NSString stringWithFormat:@"%@",responseDict[@"msg"]];
        messageStr = message;
        [self.findArray removeAllObjects];
        if ([message isEqualToString:@"no"]) {
            [self.findArray addObject:@{@"pic":@"juntua",@"title":@"投顾军团",@"isCheck":@"no"}];
            [self.findArray addObject:@{@"pic":@"banbenfuwu",@"title":@"版本服务",@"isCheck":@"no"}];
            [self.findArray addObject:@{@"pic":@"guanfang",@"title":@"官方公告",@"isCheck":@"no"}];
            [self.findArray addObject:@{@"pic":@"fuwxiaoxi",@"title":@"服务消息",@"isCheck":@"no"}];
        }else{
            /*! 审核中 */
            [self.findArray addObject:@{@"pic":@"juntua",@"title":@"投顾军团",@"isCheck":@"yes"}];
            [self.findArray addObject:@{@"pic":@"guanfang",@"title":@"官方公告",@"isCheck":@"yes"}];
            [self.findArray addObject:@{@"pic":@"fuwxiaoxi",@"title":@"服务消息",@"isCheck":@"yes"}];
        }
        [self.findTableView reloadData];
        [HXLoadingView hide];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [self.findArray removeAllObjects];
        [self.findArray addObject:@{@"pic":@"juntua",@"title":@"投顾军团",@"isCheck":@"no"}];
        [self.findArray addObject:@{@"pic":@"banbenfuwu",@"title":@"版本服务",@"isCheck":@"no"}];
        [self.findArray addObject:@{@"pic":@"guanfang",@"title":@"官方公告",@"isCheck":@"no"}];
        [self.findArray addObject:@{@"pic":@"fuwxiaoxi",@"title":@"服务消息",@"isCheck":@"no"}];
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];
}

- (void)dealloc
{
    
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
