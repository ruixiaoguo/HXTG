//
//  HXCustSerWebController.m
//  HXTG
//
//  Created by grx on 2017/4/20.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXCustSerWebController.h"
#import "HXChatViewController.h"
#import "HXCustomCell.h"

@interface HXCustSerWebController ()<UITableViewDelegate,UITableViewDataSource>{
    HXCustomCell *cell;
}

@property(nonatomic,strong) UITableView *custSerTableView;
@property(nonatomic,strong) NSArray *custSerArray;

@end

@implementation HXCustSerWebController

/*! 懒加载tableview */
-(UITableView *)custSerTableView
{
    if (!_custSerTableView) {
        _custSerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _custSerTableView.delegate = self;
        _custSerTableView.dataSource = self;
        _custSerTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _custSerTableView.backgroundColor = UIColorBgLightTheme;
        _custSerTableView.showsVerticalScrollIndicator=NO;
        [_custSerTableView registerClass:[HXCustomCell class] forCellReuseIdentifier:CustomServerCellIdentifier];
    }
    return _custSerTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.navigationItem.title = @"客户服务";
    self.custSerArray = [NSArray arrayWithObjects:@{@"pic":@"hudongxiaoxi",@"title":@"在线客服",@"dis":@"(09:00-18:00)"},@{@"pic":@"kefuyouxiang",@"title":@"客服邮箱",@"dis":@"(tousu@huaxuntouzi.com.cn)"},nil];
    [self.view addSubview:self.custSerTableView];
    
    /*! 客服电话/投诉电话 */
    for (int i=0; i<2; i++) {
        UILabel *serverLable = [[UILabel alloc]init];
        serverLable.frame = CGRectMake(0, Main_Screen_Height*0.44+i*23, Main_Screen_Width, 20);
        serverLable.font = UIFontSystem14;
        serverLable.tag = i+10;
        serverLable.textColor = UIColorLightTheme;
        serverLable.textAlignment = NSTextAlignmentCenter;
        [self.custSerTableView addSubview:serverLable];
        if (serverLable.tag==10) {
            serverLable.text = @"客服电话: 400-098-7966";
        }else{
            serverLable.text = @"投诉电话: 010-53821559";
        }
    }
}

#pragma mark -tableViewDelegete
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.custSerArray count];
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
    cell = [tableView dequeueReusableCellWithIdentifier:CustomServerCellIdentifier forIndexPath:indexPath];
    cell.infoDic = self.custSerArray[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        HXChatViewController *chatVC = [[HXChatViewController alloc] init];
        chatVC.conversationType = ConversationType_PRIVATE;
        chatVC.targetId = @"81";
        [self.navigationController pushViewController:chatVC animated:YES];
    }
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
