//
//  HXServerListController.m
//  HXTG
//
//  Created by grx on 2017/5/4.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXServerVersionController.h"
#import "HXServerVersionCell.h"
#import "HXSerVersionDetailController.h"

@interface HXServerVersionController ()<UITableViewDelegate,UITableViewDataSource>{
    HXServerVersionCell *cell;
}

@property(nonatomic,strong) UITableView *serverTableView;
@property(nonatomic,strong) NSArray *serverArray;
@property(nonatomic,strong) NSArray *versionArray;

@end

@implementation HXServerVersionController

/*! 懒加载 */
-(UITableView *)serverTableView
{
    if (!_serverTableView) {
        _serverTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _serverTableView.delegate = self;
        _serverTableView.dataSource = self;
        _serverTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _serverTableView.backgroundColor = UIColorBgLightTheme;
        [_serverTableView registerClass:[HXServerVersionCell class] forCellReuseIdentifier:ServerClassCellIdentifier];
    }
    return _serverTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"版本列表";
    self.backButton.hidden = NO;
    //@{@"pic":@"5",@"title":@"华讯投顾-定制版",@"dis":@"高端配置、专属投顾、策略报告、线下会谈"}
    self.serverArray = [NSArray arrayWithObjects:@{@"pic":@"1",@"title":@"华讯投顾-专业版",@"dis":@"市场解读、数据分析、公司解读、股票池"},@{@"pic":@"2",@"title":@"华讯投顾-VIP版",@"dis":@"要闻资讯、大势解读、热点追踪、数据分析"},@{@"pic":@"3",@"title":@"华讯投顾-机构版",@"dis":@"策略报告、投顾服务、直播解盘、内参分析"},@{@"pic":@"4",@"title":@"华讯投顾-VIP机构版",@"dis":@"高端配置、专属投顾、策略报告、线下会谈"},nil];
    self.versionArray = [NSArray arrayWithObjects:@"专业版",@"VIP版",@"机构版",@"VIP机构版",nil];
    [self.view addSubview:self.serverTableView];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.serverArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:ServerClassCellIdentifier forIndexPath:indexPath];
    cell.infoDic = self.serverArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXSerVersionDetailController *detailVC = [[HXSerVersionDetailController alloc]init];
    detailVC.title = self.versionArray[indexPath.row];
    detailVC.selTag = indexPath.row;
    [self.navigationController pushViewController:detailVC animated:YES];
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
