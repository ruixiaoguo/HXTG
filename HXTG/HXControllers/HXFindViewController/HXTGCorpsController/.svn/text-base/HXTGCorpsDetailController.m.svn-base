//
//  HXTGCorpsDetailController.m
//  HXTG
//
//  Created by grx on 2017/5/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXTGCorpsDetailController.h"
#import "HXLegionDetailCell.h"
#import "TGCorpsDetailHeadView.h"
#import "TGCorpsDetailFootView.h"
#import "LrvingDetailReqtModel.h"
#import "UILabel+ContentSize.h"
#import "NSString+TxtHeight.h"
#import "HXLrvingDetailModel.h"

@interface HXTGCorpsDetailController ()<UITableViewDelegate,UITableViewDataSource>{
    HXLegionDetailCell *cell;
    TGCorpsDetailHeadView *detailHeadView;
}

@property(nonatomic,strong) UITableView *corpsDetailTableView;
@property(nonatomic,strong) NSMutableArray *corpsDetailArray;
@property(nonatomic,strong) TGCorpsDetailFootView *detailFootView;

@end

@implementation HXTGCorpsDetailController

/*! 懒加载tableview */
-(UITableView *)corpsDetailTableView
{
    if (!_corpsDetailTableView) {
        _corpsDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _corpsDetailTableView.delegate = self;
        _corpsDetailTableView.dataSource = self;
        _corpsDetailTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _corpsDetailTableView.backgroundColor = UIColorBgLightTheme;
        _corpsDetailTableView.showsVerticalScrollIndicator=NO;
        [_corpsDetailTableView registerClass:[HXLegionDetailCell class] forCellReuseIdentifier:LegionDetailCellIdentifier];
    }
    return _corpsDetailTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.LrvingName;
    self.backButton.hidden = NO;
    self.corpsDetailArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.corpsDetailTableView];
    detailHeadView=[[TGCorpsDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 220)];
    self.corpsDetailTableView.tableHeaderView=detailHeadView;
    self.detailFootView=[[TGCorpsDetailFootView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 350)];
    WeakSelf(weakSelf);
    self.detailFootView.gaintWebHight = ^(CGFloat hight) {
        weakSelf.detailFootView.frame = CGRectMake(0, 0, Main_Screen_Width, hight);
        DDLog(@"hight==%f===",hight);
        weakSelf.corpsDetailTableView.tableFooterView=weakSelf.detailFootView;
    };
    [self gaintLrvingInfo];
}

#pragma mark -tableViewDelegete
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.corpsDetailArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:LegionDetailCellIdentifier forIndexPath:indexPath];
    HXLrvingDetailModel *model = self.corpsDetailArray[indexPath.row];
    cell.model = model;
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 军团详情网络请求
-(void)gaintLrvingInfo
{
    [HXLoadingView show];
    LrvingDetailReqtModel *model = [[LrvingDetailReqtModel alloc]init];
    model.lid = self.LrvingId;
    NSDictionary *dict = [model mj_keyValues];
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"Lrving/LrvingInfo" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            /*! 军团介绍 */
            NSDictionary *lrvingData = responseDict[@"data"];
            NSString *contentStr = responseDict[@"data"][@"legion_info"];
            CGFloat contentStrHight = [contentStr heightWithLabelFont:UIFontSystem12 withLabelWidth:Main_Screen_Width-30];
            detailHeadView.introHight = contentStrHight;
            detailHeadView.headDic = lrvingData;
//            detailHeadView.frame = CGRectMake(0, 0, Main_Screen_Width, 160+contentStrHight);
            /*! 详细信息 */
            NSString *legionData = lrvingData[@"legion_info"];
            [self.detailFootView.tGCorpWebView loadHTMLString:legionData baseURL:nil];
            /*! 军团成员 */
            [self.corpsDetailArray removeAllObjects];
            for (int i=0; i<[responseDict[@"leaguer"] count]; i++) {
                NSDictionary *dic =responseDict[@"leaguer"][i];
                HXLrvingDetailModel *model = [HXLrvingDetailModel mj_objectWithKeyValues:dic];
                [self.corpsDetailArray addObject:model];
            }

            [HXLoadingView hide];
            [self.corpsDetailTableView reloadData];
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
