//
//  HXMessageListController.m
//  HXTG
//
//  Created by grx on 2017/3/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMessageListController.h"
#import "HXMessageListCell.h"
#import "HXConversationListController.h"
#import "HXServerListController.h"
#import "HXSystemMsgController.h"
#import "HXSysDetailController.h"

@interface HXMessageListController ()<UITableViewDelegate,UITableViewDataSource>{
    HXMessageListCell *listCell;
}

@property(nonatomic,strong) UITableView *messageTableView;
@property(nonatomic,strong) NSArray *messageArray;

@end

@implementation HXMessageListController

-(UITableView *)messageTableView
{
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _messageTableView.backgroundColor = ColorWithRGB(237, 237, 237);
        _messageTableView.showsVerticalScrollIndicator=NO;
        [_messageTableView registerClass:[HXMessageListCell class] forCellReuseIdentifier:MessageListCellIdentifier];
    }
    return _messageTableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.messageTableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*! 接收到融云在线消息 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRongYChatMessage:) name:RYGetChatNotification object:nil];
    self.backButton.hidden = NO;
    self.navigationItem.title = @"消息中心";
    self.messageArray = [NSArray arrayWithObjects:@{@"pic":@"hudongxiaoxi",@"title":@"互动消息"},@{@"pic":@"fuwxiaoxi1",@"title":@"服务消息"},@{@"pic":@"kefuyouxiang",@"title":@"官方公告"},nil];
    [self.view addSubview:self.messageTableView];
}


#pragma mark -tableViewDelegete

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messageArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    listCell = [tableView dequeueReusableCellWithIdentifier:MessageListCellIdentifier forIndexPath:indexPath];
    listCell.tag = indexPath.row+10;
    listCell.infoDic = self.messageArray[indexPath.row];
    if (listCell.tag==10) {
        /*! 融云消息显示小红点 */
        if (ISRYCHATMESSAGE) {
            [listCell.picImageView showBadge];
        }else{
            [listCell.picImageView clearBadge];
        }
    }
    if (listCell.tag==11) {
        /*! 服务消息显示小红点 */
        if (ISSERVERMESSAGE) {
            [listCell.picImageView showBadge];
        }else{
            [listCell.picImageView clearBadge];
        }
    }
    if (listCell.tag==12) {
        /*! 官方消息显示小红点 */
        if (ISSOFFICIALMESSAGE) {
            [listCell.picImageView showBadge];
        }else{
            [listCell.picImageView clearBadge];
        }
    }
    return listCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        /*! 互动消息 */
        HXConversationListController *converListVC = [[HXConversationListController alloc]init];
        [self.navigationController pushViewController:converListVC animated:YES];
    }else if (indexPath.row==1){
        /*! 服务消息 */
        HXSysDetailController *serverListVC = [[HXSysDetailController alloc]init];
        serverListVC.title = @"服务消息";
        [self.navigationController pushViewController:serverListVC animated:YES];
    }else{
        /*! 官方公告 */
        HXSysDetailController *serverListVC = [[HXSysDetailController alloc]init];
        serverListVC.title = @"官方公告";
        [self.navigationController pushViewController:serverListVC animated:YES];
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


-(void)getRongYChatMessage:(NSNotification *)notification
{
    DDLog(@"notification=====%@",notification.object);
    listCell = [self.messageTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSDictionary *dic = notification.object;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic[@"allunread"] isEqualToString:@"0"]) {
            [listCell.picImageView clearBadge];
            [StandardUserDefaults setBool:NO forKey:@"isRYChatMessage"];
        }else{
            /*! 融云消息显示小红点 */
            [listCell.picImageView showBadge];
            [StandardUserDefaults setBool:YES forKey:@"isRYChatMessage"];
        }
    }
    
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:RYGetChatNotification object:nil];
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
