//
//  HXServerAgreeController.m
//  HXTG
//
//  Created by grx on 2017/4/1.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXServerAgreeController.h"
#import "HXServerDetailController.h"
#import "HXChangeProtoController.h"
#import "HXServerAgreetCell.h"

@interface HXServerAgreeController ()<UITableViewDelegate,UITableViewDataSource>{
    HXServerAgreetCell *serverCell;
}

@property(nonatomic,strong) UITableView *serverAgreeTableView;
@property(nonatomic,strong) NSArray *serverArray;

@end

@implementation HXServerAgreeController

/*! 懒加载tableview */
-(UITableView *)serverAgreeTableView
{
    if (!_serverAgreeTableView) {
        _serverAgreeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _serverAgreeTableView.delegate = self;
        _serverAgreeTableView.dataSource = self;
        _serverAgreeTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _serverAgreeTableView.backgroundColor = UIColorBgLightTheme;
        _serverAgreeTableView.showsVerticalScrollIndicator=NO;
        [_serverAgreeTableView registerClass:[HXServerAgreetCell class] forCellReuseIdentifier:myServerCellIdentifier];
    }
    return _serverAgreeTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务协议";
    self.backButton.hidden = NO;
    self.view.backgroundColor = UIColorBgLightTheme;
    self.serverArray = [NSArray arrayWithObjects:@{@"title":@"服务协议"},@{@"title":@"变更协议"},nil];
    [self.view addSubview:self.serverAgreeTableView];
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
    NSArray *viewControllers = [NSArray arrayWithObjects:@"HXServerDetailController",@"HXChangeProtoController",nil];
    UIViewController *selectVC = [[NSClassFromString(viewControllers[indexPath.row]) alloc]init];
    [self.navigationController pushViewController:selectVC animated:YES];
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
