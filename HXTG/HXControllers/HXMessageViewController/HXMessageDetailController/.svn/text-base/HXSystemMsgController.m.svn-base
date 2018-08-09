//
//  HXSystemMsgController.m
//  HXTG
//
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXSystemMsgController.h"
#import "HXSysDetailController.h"
#import "HXSystemCell.h"

@interface HXSystemMsgController ()<UITableViewDelegate,UITableViewDataSource>{
    HXSystemCell *listCell;
}

@property(nonatomic,strong) UITableView *systemTableView;

@end

@implementation HXSystemMsgController

-(UITableView *)systemTableView
{
    if (!_systemTableView) {
        _systemTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _systemTableView.delegate = self;
        _systemTableView.dataSource = self;
        _systemTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _systemTableView.backgroundColor = UIColorBgLightTheme;
        _systemTableView.showsVerticalScrollIndicator=NO;
        [_systemTableView registerClass:[HXSystemCell class] forCellReuseIdentifier:SystemListCellIdentifier];
    }
    return _systemTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.navigationItem.title = @"官方公告";
    [self.view addSubview:self.systemTableView];
}

#pragma mark -tableViewDelegete


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    listCell = [tableView dequeueReusableCellWithIdentifier:SystemListCellIdentifier forIndexPath:indexPath];
    return listCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXSysDetailController *sysDetailVC = [[HXSysDetailController alloc]init];
    sysDetailVC.title = @"致用户的一封信";
    [self.navigationController pushViewController:sysDetailVC animated:YES];
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
