//
//  HXConversationListController.m
//  HXTG
//
//  Created by grx on 2017/3/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXConversationListController.h"
#import "HXChatViewController.h"

@interface HXConversationListController ()

@property(nonatomic,strong) UIView *emptyView;

@end

@implementation HXConversationListController

#pragma mark - 设置显示的会话类型

/*! 如果不写在初始化里面会导致第一次进入会话列表时是空的 */
- (instancetype)init {
    
    self = [super init];
    if (self) {
        /*! 设置要显示的会话类型 */
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    }
    return self;
}

-(UIView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64)];
        _emptyView.backgroundColor = UIColorBgLightTheme;
        UIImageView *tipImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        tipImage.centerX = _emptyView.centerX;
        tipImage.centerY = _emptyView.centerY-100;
        [tipImage setImage:[UIImage imageNamed:@"kong"]];
        [_emptyView addSubview:tipImage];
        UILabel *tipLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipImage.frame), Main_Screen_Width, 40)];
        tipLable.textAlignment = NSTextAlignmentCenter;
        tipLable.textColor = UIColorLineTheme;
        tipLable.font = UIFontSystem14;
        tipLable.text = @"暂时没有会话";
        [_emptyView addSubview:tipLable];
    }
    return _emptyView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    /*! 清除服务消息小红点 */
    [StandardUserDefaults setBool:NO forKey:@"isRYChatMessage"];
    self.navigationItem.title = @"互动消息";
    /*! 自定义返回 */
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"home_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *backSpacer = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                   target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    backSpacer.width = -15;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:backSpacer,backItem,nil];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    /*! 设置tableview样式 */
    self.conversationListTableView.separatorColor = [UIColor colorWithRed:233.0/255 green:233.0/255 blue:233.0/255 alpha:1.0];
    self.conversationListTableView.tableFooterView = [UIView new];
    [self setConversationPortraitSize:CGSizeMake(40, 40)];
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    /*! 没有会话列表界面 */
    self.emptyConversationView = self.emptyView;

}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    /*! 设置未读消息 */
    [self notifyUpdateUnreadMessageCount];
//    NSInteger aaa = [UIApplication sharedApplication].applicationIconBadgeNumber;
}

#pragma mark - 点击cell进入聊天页面
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    
    HXChatViewController *chatVC = [[HXChatViewController alloc] init];
    chatVC.conversationType = ConversationType_PRIVATE;
    chatVC.targetId = model.targetId;
    chatVC.legionName = @"";
    chatVC.teacherNum = @"";
    chatVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark - cell的高度
- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 78.0f;
}

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isMemberOfClass:[RCConversationCell class]]) {
        RCConversationCell *concell = (RCConversationCell *)cell;
        concell.conversationTitle.font = UIFontSystem15;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 设置在NavigatorBar中显示连接中的提示
    self.showConnectingStatusOnNavigatorBar = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kRCNeedReloadDiscussionListNotification" object:nil];

}
//由于demo使用了tabbarcontroller，当切换到其它tab时，不能更改tabbarcontroller的标题。
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.showConnectingStatusOnNavigatorBar = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kRCNeedReloadDiscussionListNotification" object:nil];
}

#pragma mark - 设置未读消息
- (void)notifyUpdateUnreadMessageCount {
    
    [self updateBadgeValueForTabBarItem];
}

- (void)updateBadgeValueForTabBarItem {
    
    __weak typeof(self) __weakSelf = self;
    // 异步读取
    dispatch_async(dispatch_get_main_queue(), ^{
        
        int count = [[RCIMClient sharedRCIMClient] getUnreadCount:self.displayConversationTypeArray];
        NSString *countStr = [NSString stringWithFormat:@"%d",count];
        /*! 发送通知接收到融云新消息 */
        [[NSNotificationCenter defaultCenter]postNotificationName:RYGetChatNotification object:countStr];
        if (count > 0) {
            
            __weakSelf.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", count];
        }
        else {
            
            __weakSelf.tabBarItem.badgeValue = nil;
        }
    });
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
