//
//  HXSerVersionDetailController.m
//  HXTG
//
//  Created by grx on 2017/5/4.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXSerVersionDetailController.h"
#import "HXServerDetailVerCell.h"
#import "MyOrderDetailController.h"
#import "MyOrderRequestModel.h"
#import "HXMyOrderModel.h"

@interface HXSerVersionDetailController ()<UITableViewDelegate,UITableViewDataSource>{
    HXServerDetailVerCell *cell;
    NSString *versionNum;
    UIButton *selBtn;
}

@property(nonatomic,strong) UITableView *serverDetailTableView;
@property(nonatomic,strong) NSArray *serverDetailArray;
@property(nonatomic,strong) NSArray *versionPicArray;
@property(nonatomic,strong) NSArray *versionInfoPicArray;
@property(nonatomic,strong) NSArray *versionMonPriceArray;
@property(nonatomic,strong) NSArray *versionYearPriceArray;
@property(nonatomic,strong) NSMutableArray *serverListArray;

@property(nonatomic,strong) NSArray *verListNameArray;

@end

@implementation HXSerVersionDetailController

/*! 懒加载 */
-(UITableView *)serverDetailTableView
{
    if (!_serverDetailTableView) {
        _serverDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _serverDetailTableView.delegate = self;
        _serverDetailTableView.dataSource = self;
        _serverDetailTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _serverDetailTableView.backgroundColor = UIColorBgLightTheme;
        _serverDetailTableView.showsVerticalScrollIndicator=NO;
        [_serverDetailTableView registerClass:[HXServerDetailVerCell class] forCellReuseIdentifier:ServerDetailClassCellIdentifier];
    }
    return _serverDetailTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.verListNameArray = [NSArray arrayWithObjects:@"专业版(季度)",@"专业版(半年)",@"VIP专业版(季度)",@"VIP专业版(半年)",@"机构版(季度)",@"机构版(半年)",@"VIP机构版(季度)",@"VIP机构版(半年)",@"定制版(季度)",@"定制版(半年)",nil];
    self.verListNameArray = [NSArray arrayWithObjects:@{@"1":@"华讯投顾-专业版(季度)",@"2":@"华讯投顾-专业版(半年)"},@{@"1":@"华讯投顾-VIP专业版(季度)",@"2":@"华讯投顾-VIP专业版(半年)"},@{@"1":@"华讯投顾-机构版(季度)",@"2":@"华讯投顾-机构版(半年)"},@{@"1":@"华讯投顾-VIP机构版(季度)",@"2":@"华讯投顾-VIP机构版(半年)"},@{@"1":@"华讯投顾-定制版(季度)",@"2":@"华讯投顾-定制版(半年)"},nil];

    self.versionPicArray = [NSArray arrayWithObjects:@"zyb",@"vipb",@"jgb",@"vipjgb",@"dzb",nil];
    self.versionInfoPicArray = [NSArray arrayWithObjects:@"zy",@"vip",@"jg",@"vipjg",@"dz",nil];
    self.versionMonPriceArray = [NSArray arrayWithObjects:@"6880元/季度",@"28000元/季度",@"76800元/季度",@"12.8万元/季度",@"25.8万元/季度",nil];
    self.versionYearPriceArray = [NSArray arrayWithObjects:@"1.28万元/半年",@"4.98万元/半年",@"14.8万元/半年",@"24.8万元/半年",@"49.8万元/半年",nil];
    self.serverListArray = [NSMutableArray arrayWithCapacity:0];
    self.backButton.hidden = NO;
    [self.view addSubview:self.serverDetailTableView];
    [self gaintMyOrderServerList];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDLog(@"304======%f",Main_Screen_Height*0.535);
    return Main_Screen_Height*0.535;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return Main_Screen_Height*0.26;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*0.26);
    headImage.image = [UIImage imageNamed:self.versionPicArray[self.selTag]];
    [header addSubview:headImage];
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = UIColorWhite;
    selBtn = [[UIButton alloc]init];
    selBtn.frame = CGRectMake(20, 28, Main_Screen_Width-40, 42);
    selBtn.titleLabel.font = UIFontSystem15;
    selBtn.layer.cornerRadius = 5;
    [selBtn setTintColor:UIColorWhite];
    [selBtn addTarget:self action:@selector(selBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:selBtn];
    return footer;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:ServerDetailClassCellIdentifier forIndexPath:indexPath];
    cell.monPriceLable.text = self.versionMonPriceArray[self.selTag];
    cell.yearPriceLable.text = self.versionYearPriceArray[self.selTag];
    [cell.picImageView setImage:[UIImage imageNamed:self.versionInfoPicArray[self.selTag]]];
    return cell;
}


#pragma mark - ==============订单详情===========================
-(void)selBtnClick:(UIButton *)sender
{
    MyOrderDetailController *detailVC = [[MyOrderDetailController alloc]init];
    detailVC.orderNum = versionNum;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 我的订单列表网络请求
-(void)gaintMyOrderServerList
{
    [HXLoadingView show];
    MyOrderRequestModel *model = [[MyOrderRequestModel alloc]init];
    /*! 当前页 */
    model.pagenum = [NSString stringWithFormat:@"1"];
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"MyOrder/OrderList" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {

            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXMyOrderModel *model = [HXMyOrderModel mj_objectWithKeyValues:dic];
                [self.serverListArray addObject:model];
            }
            [self searchForCurrenVersion:self.serverListArray];
            [HXLoadingView hide];
        }else{
            versionNum = @"";
            selBtn.backgroundColor = UIColorLightTheme;
            [selBtn setTitle:@"尚未购买服务，请到官网购买" forState:UIControlStateNormal];
            selBtn.enabled = NO;
            [HXLoadingView hide];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];
        
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];
}

-(void)searchForCurrenVersion:(NSMutableArray *)listArray
{
    for (HXMyOrderModel *model in listArray) {
        DDLog(@"product_name======%@",model.product_name);
        NSArray *verListArray = [self.verListNameArray[self.selTag] allValues];
        
        for (int i=0; i<verListArray.count; i++) {
            if([model.product_name isEqualToString:verListArray[i]])
            {
                versionNum = model.order_sn;
                DDLog(@"=====%@",versionNum);
                selBtn.backgroundColor = UIColorRedTheme;
                [selBtn setTitle:@"订单详情" forState:UIControlStateNormal];
                selBtn.enabled = YES;
                return;
            }else{
                versionNum = @"";
                selBtn.backgroundColor = UIColorLightTheme;
                [selBtn setTitle:@"尚未购买服务，请到官网购买" forState:UIControlStateNormal];
                selBtn.enabled = NO;
            }
        }
    }
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
