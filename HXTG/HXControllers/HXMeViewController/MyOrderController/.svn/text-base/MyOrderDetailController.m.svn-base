//
//  MyOrderDetailController.m
//  HXTG
//
//  Created by grx on 2017/5/4.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "MyOrderDetailController.h"
#import "HXMyOrderDetailCell.h"
#import "HXMyOrderDetailModel.h"
#import "MyOrderDetailHeadView.h"
#import "OrderDetailRequestModel.h"
#import "OrderPDFController.h"
#import "HXTGCorpsDetailController.h"

@interface MyOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>{
    HXMyOrderDetailCell *cell;
    MyOrderDetailHeadView *detailHeadView;
}

@property(nonatomic,strong) UITableView *orderDetailTableView;
@property(nonatomic,strong) NSMutableArray *orderDetailArray;
@property(nonatomic,strong) NSString *lidId;
@property(nonatomic,strong) NSString *lidName;

@end

@implementation MyOrderDetailController

/*! 懒加载tableview */
-(UITableView *)orderDetailTableView
{
    if (!_orderDetailTableView) {
        _orderDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _orderDetailTableView.delegate = self;
        _orderDetailTableView.dataSource = self;
        _orderDetailTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _orderDetailTableView.backgroundColor = UIColorBgLightTheme;
        _orderDetailTableView.showsVerticalScrollIndicator=NO;
        [_orderDetailTableView registerClass:[HXMyOrderDetailCell class] forCellReuseIdentifier:myOrderDetailCellIdentifier];
    }
    return _orderDetailTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.backButton.hidden = NO;
    self.orderDetailArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.orderDetailTableView];
    detailHeadView=[[MyOrderDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 585)];
    self.orderDetailTableView.tableHeaderView=detailHeadView;
    WeakSelf(weakSelf);
    detailHeadView.jumpToLegionDetail = ^(){
        if (weakSelf.lidId==nil) {
            return ;
        }
        /*! 跳转到军团详情 */
        HXTGCorpsDetailController *detailVC = [[HXTGCorpsDetailController alloc]init];
        detailVC.LrvingId = weakSelf.lidId;
        detailVC.LrvingName = weakSelf.lidName;

        [weakSelf.navigationController pushViewController :detailVC animated:YES];
    };
    /*! 网络请求 */
    [self gaintMyOrderDetailList];
}

#pragma mark -tableViewDelegete
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderDetailArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:myOrderDetailCellIdentifier forIndexPath:indexPath];
    cell.orderModel = self.orderDetailArray[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXMyOrderDetailModel *model = self.orderDetailArray[indexPath.row];
    OrderPDFController *detailVC = [[OrderPDFController alloc]init];
    detailVC.title = model.Contract_Name;
    detailVC.pdfUrl = model.Contract_Usr_Url;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 我的订单列表网络请求
-(void)gaintMyOrderDetailList
{
    [HXLoadingView show];
    OrderDetailRequestModel *model = [[OrderDetailRequestModel alloc]init];
    model.order_sn = self.orderNum;
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"MyOrder/OrderInfo" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            /*! 订单版本信息 */
            NSDictionary *orderData = responseDict[@"orderData"];
            detailHeadView.orderDic = orderData;
            /*! 军团信息 */
            DDLog(@"========%@",responseDict[@"legionArr"]);
            if (responseDict[@"legionArr"]!=nil) {
                NSDictionary *legionData = responseDict[@"legionArr"];
                detailHeadView.legionDic = legionData;
                self.lidId = legionData[@"lid"];
                self.lidName = legionData[@"lrving_name"];
            }
            /*! 合同列表 */
            [self.orderDetailArray removeAllObjects];
            for (int i=0; i<[responseDict[@"contractData"] count]; i++) {
                NSDictionary *dic =responseDict[@"contractData"][i];
                HXMyOrderDetailModel *model = [HXMyOrderDetailModel mj_objectWithKeyValues:dic];
                [self.orderDetailArray addObject:model];
            }
            
            [HXLoadingView hide];
            [self.orderDetailTableView reloadData];
        }else{
            [HXProgressHUD showMessage:self.view labelText:responseDict[@"msg"] mode:MBProgressHUDModeText];
            [HXLoadingView hide];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];
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
