//
//  MySettingController.m
//  HXTG
//
//  Created by grx on 2017/3/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "MySettingController.h"
#import "HXModifyPassWordController.h"
#import "HXNavigationController.h"
#import "HXLoginController.h"
#import "HXMessageSetController.h"
#import "HXMySetCell.h"
#import "JPUSHService.h"
#import <RongIMKit/RongIMKit.h>


@interface MySettingController ()<UITableViewDelegate,UITableViewDataSource>{
    HXMySetCell *setterCell;
}

@property(nonatomic,strong) UITableView *mySetTableView;
@property(nonatomic,strong) NSArray *setterArray;

@end

@implementation MySettingController

/*! 懒加载tableview */
-(UITableView *)mySetTableView
{
    if (!_mySetTableView) {
        _mySetTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _mySetTableView.delegate = self;
        _mySetTableView.dataSource = self;
        _mySetTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _mySetTableView.backgroundColor = UIColorBgLightTheme;
        _mySetTableView.showsVerticalScrollIndicator=NO;
        [_mySetTableView registerClass:[HXMySetCell class] forCellReuseIdentifier:mySetCellIdentifier];
    }
    return _mySetTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.backButton.hidden = NO;
    self.setterArray = [NSArray arrayWithObjects:@{@"title":@"当前版本"},@{@"title":@"修改密码"},@{@"title":@"消息提醒设置"},nil];
    [self.view addSubview:self.mySetTableView];
    /*! 退出登录 */
    UIButton *loginOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 300, Main_Screen_Width-60, 42)];
    [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    loginOutBtn.titleLabel.font = UIFontSystem16;
    [loginOutBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    loginOutBtn.backgroundColor = UIColorRedTheme;
    loginOutBtn.layer.cornerRadius = 5;
    [loginOutBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [loginOutBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [self.mySetTableView addSubview:loginOutBtn];
    [loginOutBtn addTarget:self action:@selector(loginOutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue]){
        loginOutBtn.hidden = YES;
    }else{
        loginOutBtn.hidden = NO;
    }
}

#pragma mark -tableViewDelegete
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.setterArray count];
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
    setterCell = [tableView dequeueReusableCellWithIdentifier:mySetCellIdentifier forIndexPath:indexPath];
    setterCell.infoDic = self.setterArray[indexPath.row];
    setterCell.backgroundColor = [UIColor whiteColor];
    return setterCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        return;
    }
    if (indexPath.row==2) {
        /*! 跳转到通知设置 */
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
        return;
    }
    if (![[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        [self jumpToLoginVC];
        return;
    }
    NSArray *viewControllers = [NSArray arrayWithObjects:@"",@"HXModifyPassWordController",@"",nil];
    UIViewController *selectVC = [[NSClassFromString(viewControllers[indexPath.row]) alloc]init];
    selectVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:selectVC animated:YES];
}

#pragma mark - 关联会员卡
-(void)loginOutBtnClick:(UIButton *)sender
{
    DDLog(@"退出登录=========");
    HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"确定要注销登录吗?" rightButtonTitle:@"退出" leftButtonTitle:@"取消"];
    alter.rightBlock=^()
    {
        [self.navigationController popViewControllerAnimated:YES];
        /*! 清除缓存 */
        [StandardUserDefaults setBool:NO forKey:ISLOGIN];
        [StandardUserDefaults removeObjectForKey:@"user_Id"];
        [StandardUserDefaults removeObjectForKey:@"user_name"];
        [StandardUserDefaults removeObjectForKey:@"user_phone"];
        [StandardUserDefaults removeObjectForKey:@"business_id"];
        [StandardUserDefaults removeObjectForKey:@"sign"];
        /*! 用于解除绑定极光Alias */
//        [JPUSHService setAlias:@"" callbackSelector:nil object:self];
//        NSSet *set = [NSSet setWithObjects:@"",@"",@"",@"",nil];
//        [JPUSHService setTags:set callbackSelector:nil object:nil];
        [JPUSHService setTags:nil alias:nil callbackSelector:nil object:nil];

        /*! 退出融云 */
        [[RCIM sharedRCIM] logout];
        [[RCIM sharedRCIM] disconnect];
        /*! 发送通知刷新首页 */
        [[NSNotificationCenter defaultCenter]postNotificationName:RefreshHomeNotification object:nil];

    };
    alter.leftBlock=^()
    {
        
    };
    
    [alter show];

}

#pragma mark - 按钮高亮背景色设置
- (void)backGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = UIColorHigRedTheme;
}

-(void)backGroundNormal:(UIButton *)sender
{
    sender.backgroundColor = UIColorRedTheme;
}


-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 跳转到登录
-(void)jumpToLoginVC
{
    HXLoginController *loginVC=[[HXLoginController alloc]init];
    HXNavigationController * loginNC = [[HXNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNC animated:YES completion:nil];
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
