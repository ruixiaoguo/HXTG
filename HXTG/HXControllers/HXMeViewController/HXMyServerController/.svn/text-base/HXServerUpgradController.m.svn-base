//
//  HXServerUpgradController.m
//  HXTG
//
//  Created by grx on 2017/4/1.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXServerUpgradController.h"
#import "HXServerExtendCell.h"
#import "MyServerUpRequestModel.h"

@interface HXServerUpgradController ()<UITableViewDelegate,UITableViewDataSource>{
    HXServerExtendCell *serverCell;
    UILabel *disLable;
    NSString *aboutStr;
}

@property(nonatomic,strong) UITableView *serverUpdateTableView;
@property(nonatomic,strong) NSMutableArray *serverArray;

@end

@implementation HXServerUpgradController

/*! 懒加载tableview */
-(UITableView *)serverUpdateTableView
{
    if (!_serverUpdateTableView) {
        _serverUpdateTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _serverUpdateTableView.delegate = self;
        _serverUpdateTableView.dataSource = self;
        _serverUpdateTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _serverUpdateTableView.backgroundColor = UIColorBgLightTheme;
        _serverUpdateTableView.showsVerticalScrollIndicator=NO;
        [_serverUpdateTableView registerClass:[HXServerExtendCell class] forCellReuseIdentifier:serverExtendCellIdentifier];
    }
    return _serverUpdateTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.view.backgroundColor = UIColorBgLightTheme;
    self.serverArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.serverUpdateTableView];
    /*! 获取服务展期 */
    [self gaintServerUpgrad];
}

#pragma mark -tableViewDelegete

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.serverArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    /*! 广播层 */
    UIView *tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Main_Screen_Width, 40)];
    tipView.backgroundColor = ColorWithHexRGB(0xfcd7d9);
    [header addSubview:tipView];
    UIImageView *hornImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 11, 22, 17)];
    hornImage.image = [UIImage imageNamed:@"tongzhi"];
    [tipView addSubview:hornImage];
    UILabel *tipLable = [[UILabel alloc]initWithFrame:CGRectMake(45, 0, Main_Screen_Width-45, 40)];
    tipLable.font = UIFontSystem12;
    tipLable.textColor = UIColorBlackTheme;
    if (self.isUpdate==NO) {
        tipLable.text = @"目前不支持在线展期服务，如有需要请联系客服！";
    }else{
        tipLable.text = @"目前不支持在线升级服务，如有需要请联系客服！";
    }
    [tipView addSubview:tipLable];

    /*! 设置文字 */
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorBlackTheme;
    label.font = UIFontSystem15;
    label.frame = CGRectMake(15, 25, 0, 0);
    label.width = 200;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [header addSubview:label];
    label.text = @"当前服务";
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
        UIView *footer = [[UIView alloc] init];
        /*! 联系客服 */
        UIButton *submittBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [submittBtn setTitle:@" 联系客服" forState:UIControlStateNormal];
        [submittBtn setImage:[UIImage imageNamed:@"fuwu"] forState:UIControlStateNormal];
        submittBtn.titleLabel.font = UIFontSystem16;
        [submittBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
        submittBtn.backgroundColor = UIColorRedTheme;
        submittBtn.layer.cornerRadius = 5;
        [submittBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:submittBtn];
        submittBtn.sd_layout.leftSpaceToView(footer,30).rightSpaceToView(footer,30).topSpaceToView(footer,70).heightIs(40);
        /*! 公司简介 */
        disLable = [UILabel new];
        disLable.numberOfLines = 0;
        disLable.font = UIFontSystem13;
        disLable.textColor = UIColorLightTheme;
//        disLable.text = @"大连华讯投资股份有限公司 成立十年来，一直秉持“帮助投资者树立科学投资理念，实现财富稳健增长”的公司使命，努力为国内投资者提供高品质的财经资讯和投资咨询服务，引领中国证券投资咨询行业的健康发展";
        disLable.text = aboutStr;
        [footer addSubview:disLable];
        disLable.sd_layout.leftSpaceToView(footer,15).rightSpaceToView(footer,15).topSpaceToView(submittBtn,10).heightIs(180);
        return footer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 95;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 300;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        serverCell = [tableView dequeueReusableCellWithIdentifier:serverExtendCellIdentifier forIndexPath:indexPath];
        serverCell.infoDic = self.serverArray[indexPath.row];
        serverCell.backgroundColor = UIColorWhite;
        return serverCell;
}

#pragma mark - 联系客服
-(void)submitBtnClick:(UIButton *)sender
{
    
    HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"是否拨打客服服务:400-098-7966?" rightButtonTitle:@"确定" leftButtonTitle:@"取消"];
    alter.rightBlock=^()
    {
        NSString *allString = [NSString stringWithFormat:@"tel:400-098-7966"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
    };
    alter.leftBlock=^()
    {
        
    };
    
    [alter show];

}


-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取服务展期网络请求
-(void)gaintServerUpgrad
{
    [HXLoadingView show];
    MyServerUpRequestModel *model = [[MyServerUpRequestModel alloc]init];
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"MyOrder/ExtensionPeriod" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        [self.serverArray removeAllObjects];
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        aboutStr = [NSString stringWithFormat:@"%@",responseDict[@"about"]];
        if ([status isEqualToString:@"1"]) {
            
            NSArray *serverArray = responseDict[@"data"];
            for (int i=0; i<serverArray.count; i++) {
                NSDictionary *serverDic = responseDict[@"data"][i];
                NSString *serverStr = [NSString stringWithFormat:@"%@",serverDic[@"product_name"]];
                if ([serverStr isEqualToString:@"<null>"]||serverStr==nil||[serverStr isEqualToString:@"(null)"]) {
                   serverStr = [NSString stringWithFormat:@"当前暂无购买服务"];
                }else{
                   serverStr = [NSString stringWithFormat:@"%@",serverDic[@"product_name"]];
                }
                NSString *timeStr = [NSString stringWithFormat:@"%@",serverDic[@"end"]];
                if ([timeStr isEqualToString:@"<null>"]||timeStr==nil||[timeStr isEqual:[NSNull null]]){
                    timeStr = [NSString stringWithFormat:@"服务截止日期:"];
                }else{
                    timeStr = [NSString stringWithFormat:@"服务截止日期: %@",serverDic[@"end"]];
                }
                [self.serverArray addObject:@{@"title":serverStr}];
                [self.serverArray addObject:@{@"title":timeStr}];
            }
            [HXLoadingView hide];
        }else{
            [self.serverArray addObject:@{@"title":@"无购买服务"}];
            [self.serverArray addObject:@{@"title":@"服务截止日期:"}];
            [HXLoadingView hide];
        }
        [self.serverUpdateTableView reloadData];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [HXLoadingView hide];
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
