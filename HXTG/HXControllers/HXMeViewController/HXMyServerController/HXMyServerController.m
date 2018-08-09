//
//  HXMyServerController.m
//  HXTG
//
//  Created by grx on 2017/3/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMyServerController.h"
#import "HXMyUnBindCardController.h"
#import "HXMyBindCartController.h"
#import "HXChatViewController.h"
#import "HXServerAgreeController.h"
#import "HXServerExtendController.h"
#import "HXServerUpgradController.h"
#import "HXMyServerCell.h"
#import "BindCartRequestModel.h"
#import "HXAskListViewController.h"

@interface HXMyServerController ()<UITableViewDelegate,UITableViewDataSource>{
    HXMyServerCell *serverCell;
    BOOL isMember;    /*! 是否会员 */
    NSMutableArray *memberInfoArray; /*! 会员信息列表 */
}

@property(nonatomic,strong) UITableView *myServerTableView;
@property(nonatomic,strong) NSMutableArray *serverArray;

@end

@implementation HXMyServerController

/*! 懒加载tableview */
-(UITableView *)myServerTableView
{
    if (!_myServerTableView) {
        _myServerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _myServerTableView.delegate = self;
        _myServerTableView.dataSource = self;
        _myServerTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _myServerTableView.backgroundColor = UIColorBgLightTheme;
        _myServerTableView.showsVerticalScrollIndicator=NO;
        [_myServerTableView registerClass:[HXMyServerCell class] forCellReuseIdentifier:myServerCellIdentifier];
    }
    return _myServerTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的服务";
    self.backButton.hidden = NO;
    memberInfoArray = [NSMutableArray arrayWithCapacity:0];
    self.serverArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.myServerTableView];
    /*! 获取会员信息 */
    [self gaintMemberinfo];
}

#pragma mark -tableViewDelegete
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.serverArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    serverCell = [tableView dequeueReusableCellWithIdentifier:myServerCellIdentifier forIndexPath:indexPath];
    serverCell.infoDic = self.serverArray[indexPath.row];
    serverCell.backgroundColor = [UIColor whiteColor];
    return serverCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
       if (isMember==YES) {
           HXMyBindCartController *bindCartVC = [[HXMyBindCartController alloc] init];
           bindCartVC.memberArray = memberInfoArray;
           [self.navigationController pushViewController:bindCartVC animated:YES];
       }else{
           HXMyUnBindCardController *unbindCartVC = [[HXMyUnBindCardController alloc] init];
           [self.navigationController pushViewController:unbindCartVC animated:YES];
       }
        return;
    }
    if (indexPath.row==1) {
        /*! 没有问老师权限 */
        if (!ASKTEACHER) {
            [self showUnBuyServer];
            return;
        }
        //HXChatViewController
        
        HXAskListViewController *chatVC = [[HXAskListViewController alloc] init];
//        chatVC.conversationType = ConversationType_PRIVATE;
//        chatVC.targetId = TEACHERID;
        chatVC.legionName = LEGIONNAME;
        [self.navigationController pushViewController:chatVC animated:YES];
        return;
    }
    if (indexPath.row==2) {
        NSString *styleStr = [NSString stringWithFormat:@"投资风格：%@\n投资日期：%@\n\n本公司履行投资者适当性职责不能取代客户本人的投资判断，不会降低投顾产品或投顾服务的固有风险，也不会影响客户依法承担相应的投资风险、履约责任以及费用。",INVESTSTYLE,INVESTSTIME];
        HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"投资风格" contentText:styleStr centerButtonTitle:@"我知道了"];
        alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
        alter.centerBlock=^()
        {
            
        };
        [alter show];
        return;
    }

    if (indexPath.row==3) {
        HXServerUpgradController *upgradVC = [[HXServerUpgradController alloc] init];
        upgradVC.title = @"服务展期";
        upgradVC.isUpdate = NO;
        [self.navigationController pushViewController:upgradVC animated:YES];
        return;
    }
    if (indexPath.row==4) {
        HXServerUpgradController *upgradVC = [[HXServerUpgradController alloc] init];
        upgradVC.title = @"服务升级";
        upgradVC.isUpdate = YES;
        [self.navigationController pushViewController:upgradVC animated:YES];
        return;
    }
}

#pragma mark - ============ 未购买服务提升
-(void)showUnBuyServer
{
    HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"对不起,你没有该产品权限,可能有以下原因:\n1.您还没有付款；\n2.付费用户已经过了有效期。" centerButtonTitle:@"确定"];
    alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
    alter.centerBlock=^()
    {
    };
    [alter show];
}


-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取会员信息网络请求
-(void)gaintMemberinfo
{
    [HXLoadingView show];
    BindCartRequestModel *model = [[BindCartRequestModel alloc]init];
    model.user_login = USERNAME;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"member/memberinfo" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            isMember = YES;
            /*! 会员名称 */
            NSString *username = [NSString stringWithFormat:@"%@",responseDict[@"data"][@"user_login"]];
            [memberInfoArray addObject:username];
            /*! 会员等级 */
            NSString *grade = [NSString stringWithFormat:@"%@",responseDict[@"data"][@"grade"]];
            [memberInfoArray addObject:grade];
            /*! 会员号 */
            NSString *membernum = [NSString stringWithFormat:@"%@",responseDict[@"data"][@"membernum"]];
            [memberInfoArray addObject:membernum];
            
            [HXLoadingView hide];
            [self gaintIosCheck];
        }else{
            isMember = NO;
            [HXLoadingView hide];
            [self gaintIosCheck];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];
        [self gaintIosCheck];
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];
}

#pragma mark - ==============审核开关==============================
-(void)gaintIosCheck
{
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/iosexamine" WithParameter:nil WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *message = [NSString stringWithFormat:@"%@",responseDict[@"msg"]];
        [self.serverArray removeAllObjects];
        if ([message isEqualToString:@"yes"]) {
            [self.serverArray addObject:@{@"title":@"我的会员卡"}];
            [self.serverArray addObject:@{@"title":@"问老师"}];
            [self.serverArray addObject:@{@"title":@"我的投资风格"}];
        }else{
            [self.serverArray addObject:@{@"title":@"我的会员卡"}];
            [self.serverArray addObject:@{@"title":@"问老师"}];
            [self.serverArray addObject:@{@"title":@"我的投资风格"}];
            [self.serverArray addObject:@{@"title":@"服务展期"}];
            [self.serverArray addObject:@{@"title":@"服务升级"}];
        }
        [self.myServerTableView reloadData];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [self.serverArray removeAllObjects];
        [self.serverArray addObject:@{@"title":@"我的会员卡"}];
        [self.serverArray addObject:@{@"title":@"问老师"}];
        [self.serverArray addObject:@{@"title":@"我的投资风格"}];
        [self.serverArray addObject:@{@"title":@"服务展期"}];
        [self.serverArray addObject:@{@"title":@"服务升级"}];
        [self.myServerTableView reloadData];
    } WithFailureBlock:^{
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
