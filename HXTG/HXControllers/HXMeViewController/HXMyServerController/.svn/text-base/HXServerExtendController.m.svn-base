//
//  HXServerExtendController.m
//  HXTG
//
//  Created by grx on 2017/4/1.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXServerExtendController.h"
#import "HXServerExtendCell.h"

@interface HXServerExtendController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *sectionsServer;
    NSMutableArray *sectionsExtend;
    HXServerExtendCell *serverCell;
    HXServerCycleCell *cycleCell;
    NSArray *sectionTitle;
}

@property(nonatomic,strong) UITableView *serverExtendTableView;
@property(nonatomic,strong) NSMutableArray *serverArray;

@end

@implementation HXServerExtendController

/*! 懒加载tableview */
-(UITableView *)serverExtendTableView
{
    if (!_serverExtendTableView) {
        _serverExtendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _serverExtendTableView.delegate = self;
        _serverExtendTableView.dataSource = self;
        _serverExtendTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _serverExtendTableView.backgroundColor = UIColorBgLightTheme;
        _serverExtendTableView.showsVerticalScrollIndicator=NO;
        [_serverExtendTableView registerClass:[HXServerExtendCell class] forCellReuseIdentifier:serverExtendCellIdentifier];
        [_serverExtendTableView registerClass:[HXServerCycleCell class] forCellReuseIdentifier:serverCycleCellIdentifier];

    }
    return _serverExtendTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务展期";
    self.backButton.hidden = NO;
    self.view.backgroundColor = UIColorBgLightTheme;
    sectionTitle = @[@"当前服务",@"展期周期"];
    sectionsServer = [[NSMutableArray alloc]initWithObjects:@{@"title":@"华讯投顾-机构版（季度）"},@{@"title":@"服务截止日期：2017-05-01"},nil];
    sectionsExtend = [[NSMutableArray alloc]initWithObjects:@{@"title":@"VIP机构版（季度版）76800.00元"},@{@"title":@"VIP机构版（半年）148000.00元"},@{@"title":@"补缴价款：76800.00元"},nil];
    self.serverArray = [NSMutableArray arrayWithObjects:sectionsServer,sectionsExtend,nil];
    [self.view addSubview:self.serverExtendTableView];
}

#pragma mark -tableViewDelegete

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return [self.serverArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.serverArray[section] count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        UIView *header = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorBlackTheme;
        label.font = UIFontSystem15;
        label.frame = CGRectMake(15, 0, 0, 0);
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [header addSubview:label];
        // 设置文字
        label.text = sectionTitle[section];
        return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
    UIView *header = [[UIView alloc] init];
    /*! 提交申请 */
    UIButton *submittBtn = [UIButton new];
    [submittBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    submittBtn.titleLabel.font = UIFontSystem16;
    [submittBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    submittBtn.backgroundColor = UIColorRedTheme;
    submittBtn.layer.cornerRadius = 5;
    [submittBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [submittBtn addTarget:self action:@selector(backGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:submittBtn];
    [submittBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    submittBtn.sd_layout.leftSpaceToView(header,30).rightSpaceToView(header,30).topSpaceToView(header,40).heightIs(40);
    /*! 用户须知 */
    UILabel *disLable = [UILabel new];
    disLable.numberOfLines = 0;
    disLable.font = UIFontSystem13;
    disLable.textColor = UIColorLightTheme;
    disLable.text = @"大连华讯投资股份有限公司 成立十年来，一直秉持“帮助投资者树立科学投资理念，实现财富稳健增长”的公司使命，努力为国内投资者提供高品质的财经资讯和投资咨询服务，引领中国证券投资咨询行业的健康发展";
    [header addSubview:disLable];
    disLable.sd_layout.leftSpaceToView(header,10).rightSpaceToView(header,10).topSpaceToView(submittBtn,40).heightIs(150);
    return header;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 45;
    }else{
        return 40;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1) {
        return 300;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 ||(indexPath.section==1&&indexPath.row==2)) {
        serverCell = [tableView dequeueReusableCellWithIdentifier:serverExtendCellIdentifier forIndexPath:indexPath];
        serverCell.infoDic = self.serverArray[indexPath.section][indexPath.row];;
        serverCell.backgroundColor = [UIColor whiteColor];
        return serverCell;
    }else{
        cycleCell = [tableView dequeueReusableCellWithIdentifier:serverCycleCellIdentifier forIndexPath:indexPath];
        cycleCell.infoDic = self.serverArray[indexPath.section][indexPath.row];;
        cycleCell.backgroundColor = [UIColor whiteColor];
        if (indexPath.row==0) {
            cycleCell.selectBtn.selected = YES;
        }
        return cycleCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        for (int i=0; i<2; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            cycleCell = [tableView cellForRowAtIndexPath:index];
            cycleCell.selectBtn.selected = NO;
        }
        cycleCell = [tableView cellForRowAtIndexPath:indexPath];
        cycleCell.selectBtn.selected = YES;
    }
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

#pragma mark - 提交申请
-(void)submitBtnClick:(UIButton *)sender
{
    
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
