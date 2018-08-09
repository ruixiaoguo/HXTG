//
//  HXStockDetailController.m
//  HXTG
//
//  Created by grx on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXStockDetailController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "HXPoolDetailCell.h"
#import "HXPoolDetailModel.h"
#import "HXPoolDetailHeadView.h"
#import "UILabel+ContentSize.h"
#import "NSString+TxtHeight.h"
#import "StockPoolRequestModel.h"

@interface HXStockDetailController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *operDesc;    /*! 操作建议 */
    NSString *mainDesc;    /*! 介绍 */
    int pageCount;
    UIView *tipView;
    UILabel *teachTime;
    UILabel *teachName;
    UILabel *legionName;
    UILabel *teachNum;
    UIView *teachBgView;
    HXPoolDetailCell *cell;
}

@property (nonatomic,strong) HXPoolDetailTopView *topView;
@property (nonatomic,strong) HXPoolDetailHeadView *headView;
@property (nonatomic,strong) UITableView *poolDetailTableView;
@property (nonatomic,strong) NSMutableArray *stockInfoArray;

@end

@implementation HXStockDetailController

-(UITableView *)poolDetailTableView
{
    if (!_poolDetailTableView) {
        _poolDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(teachBgView.frame), Main_Screen_Width, Main_Screen_Height-204-35) style:UITableViewStyleGrouped];
        _poolDetailTableView.backgroundColor = UIColorBlackTheme;
        _poolDetailTableView.delegate = self;
        _poolDetailTableView.dataSource = self;
        _poolDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _poolDetailTableView.showsVerticalScrollIndicator = NO;
        [_poolDetailTableView registerClass:[HXPoolDetailCell class] forCellReuseIdentifier:PoolDetailCellIdentifier];
    }
    return _poolDetailTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.navigationItem.title = self.poolTitle;
    self.stockInfoArray = [NSMutableArray arrayWithCapacity:0];
    /*! 创建风险提示 */
    [self creatRadio];
    /*! 头视图 */
    self.topView = [[HXPoolDetailTopView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipView.frame), Main_Screen_Width, 100)];
    self.topView.stockModel = self.model;
    [self.view addSubview:self.topView];
    WeakSelf(weakSelf);
    self.topView.followClickBlock = ^(){
        /*! 关注股票 */
        [weakSelf gaintStockFollow];
    };
    /*! 老师信息 */
    [self addTeacherInfoBtn];

    [self.view addSubview:self.poolDetailTableView];
    self.headView = [[HXPoolDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width,37)];
    self.poolDetailTableView.tableHeaderView = self.headView;
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    [self gaintStockInfoList:NO];
}

#pragma mark - =============创建广播层=============
-(void)creatRadio
{
    /*! 广播层 */
    tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 40)];
    tipView.backgroundColor = UIColorBgLightTheme;
    [self.view addSubview:tipView];
    UIImageView *hornImage = [[UIImageView alloc]initWithFrame:CGRectMake(8, 11, 22, 19)];
    hornImage.image = [UIImage imageNamed:@"tongzhi"];
    [tipView addSubview:hornImage];
    UILabel *tipLable = [[UILabel alloc]initWithFrame:CGRectMake(38, 0, Main_Screen_Width-110, 40)];
    tipLable.font = UIFontSystem12;
    tipLable.textColor = UIColorRedTheme;
    tipLable.text = @"风险提示：本投顾产品投资建议仅供参考，不作为客户投资决策依据。客户须审慎独立作出投资决策，自行承担投资风险>>";
    [tipView addSubview:tipLable];
    UILabel *checkLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-80, 0, 72, 40)];
    checkLable.font = UIFontSystem12;
    checkLable.textColor = UIColorRedTheme;
    checkLable.textAlignment = NSTextAlignmentRight;
    checkLable.text = @"查看详情>>";
    [tipView addSubview:checkLable];
    /*! 手势 */
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipViewClickTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [tipView addGestureRecognizer:singleRecognizer];
}

#pragma mark - 广播层手势事件
-(void)tipViewClickTap:(UITapGestureRecognizer *)recognizer
{
    HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"风险提示" contentText:@"本投顾产品投资建议仅供参考，不作为客户投资决策依据。客户须审慎独立作出投资决策，自行承担投资风险。\n投诉热线: 010-53821559" centerButtonTitle:@"我知道了"];
    alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
    alter.centerBlock=^()
    {
        
    };
    [alter show];
}

/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.poolDetailTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
          [self gaintStockInfoList:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.poolDetailTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintStockInfoList:YES];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.poolDetailTableView startAutoCellHeightWithCellClass:[HXPoolDetailCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    return self.stockInfoArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.poolDetailTableView cellHeightForIndexPath:indexPath model:self.stockInfoArray[indexPath.row] keyPath:@"model"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell = [tableView dequeueReusableCellWithIdentifier:PoolDetailCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = UIColorBlackTheme;
    cell.model = self.stockInfoArray[indexPath.row];
    CGFloat cellHeight = [self tableView:self.poolDetailTableView heightForRowAtIndexPath:indexPath]-30;
    NSString *state = cell.model.stock_opert_state;
    cell.hight = cellHeight;
    
    if (indexPath.row == 0) {
        cell.upLine.hidden = YES;
    }else{
        cell.upLine.hidden = NO;
    }
    if (indexPath.row == self.stockInfoArray.count-1) {
        if ([state isEqualToString:@"买入建议"] ||[state isEqualToString:@"加仓建议"] ||[state isEqualToString:@"清仓建议"]||[state isEqualToString:@"建仓建议"]){
            cell.downLine.sd_layout.heightIs(cellHeight-10);
        }else{
            cell.downLine.sd_layout.heightIs(cellHeight-20);
        }
    }
    return cell;
}

#pragma mark - 关注网络请求
-(void)gaintStockFollow
{
    StockFollowRequestModel *model = [[StockFollowRequestModel alloc]init];
    if ([self.model.isconcern isEqualToString:@"0"]) {
        model.type = @"1";
    }else{
        model.type = @"2";
    }
    model.stock_id = self.model.stock_id;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"stock/StockFollow" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        [HXLoadingView show];
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        NSString *msg = [NSString stringWithFormat:@"%@",responseDict[@"msg"]];

        if ([status isEqualToString:@"1"]) {
            if ([msg isEqualToString:@"关注成功"]) {
                self.topView.followImg.image = [UIImage imageNamed:@"guanzhu-"];
                self.topView.followTitle.text = @"已关注";
                self.topView.followTitle.textColor = UIColorWhite;
                self.model.isconcern = @"1";
                /*! 关注刷新我的关注列表 */
                if (self.refreshMyFollow) {
                    self.refreshMyFollow();
                }
            }else{
                self.topView.followImg.image = [UIImage imageNamed:@"unguanzhu-"];
                self.topView.followTitle.text = @"关注";
                self.topView.followTitle.textColor = UIColorWhite;
                self.model.isconcern = @"0";
                /*! 取消关注刷新我的关注列表 */
                if (self.refreshMyFollow) {
                    self.refreshMyFollow();
                }
            }
             [HXLoadingView hide];
        }else{
            [HXLoadingView hide];
            [HXProgressHUD showMessage:self.view
                             labelText:responseDict[@"msg"]
                                  mode:MBProgressHUDModeText];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];
}


#pragma mark - 股票池详情网络请求
-(void)gaintStockInfoList:(BOOL)isLoadMore
{
    
    StockPoolRequestModel *model = [[StockPoolRequestModel alloc]init];
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    model.stock_id = self.model.stock_id;
    NSDictionary *dict = [model mj_keyValues];
    [HXLoadingView show];

    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"stock/StockInfo" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        DDLog(@"responseDict======%@",responseDict[@"data"][@"stock_opert_state"]);
        /*! 操作建议 */
        operDesc = [NSString stringWithFormat:@"%@",responseDict[@"data"][@"stock_oper_desc"]];
        self.topView.stock_oper_desc = operDesc;
        /*! 介绍 */
        mainDesc = [NSString stringWithFormat:@"%@",responseDict[@"data"][@"stock_main_desc"]];
        if (mainDesc.length==0) {
            self.headView.frame = CGRectMake(0, 0, Main_Screen_Width, 0);
        }else{
            CGFloat contentStrHight = [mainDesc heightWithLabelFont:UIFontSystem13 withLabelWidth:Main_Screen_Width-54];
            self.headView.headViewHight = contentStrHight+20;
            self.headView.frame = CGRectMake(0, 0, Main_Screen_Width, contentStrHight+20);
            self.headView.contentLable.text = mainDesc;
        }
        
        /*! 股票cell json解析 */
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.stockInfoArray removeAllObjects];
            }
            NSDictionary *teachDic = responseDict[@"data"];
            teachTime.text = [NSString stringWithFormat:@"%@",teachDic[@"stock_addtime"]];
            teachName.text = [NSString stringWithFormat:@"%@",teachDic[@"opert_user"]];
            legionName.text = [NSString stringWithFormat:@"%@",teachDic[@"lrving_name"]];
            teachNum.text = [NSString stringWithFormat:@"%@",teachDic[@"lrving_dictate"]];
            for (int i=0; i<[responseDict[@"data"][@"info"] count]; i++) {
                NSDictionary *dic = responseDict[@"data"][@"info"][i];
                HXPoolDetailModel *model = [HXPoolDetailModel mj_objectWithKeyValues:dic];
                if ([model.stock_opert_state isEqualToString:@"清仓"]) {
                    model.stock_oper_desc = [NSString stringWithFormat:@"卖出价 %@",model.selling_price];
                }
                if ([model.stock_opert_state isEqualToString:@"加仓"]||[model.stock_opert_state isEqualToString:@"买入"]|| [model.stock_opert_state isEqualToString:@"建仓"]) {
                    model.stock_oper_desc = [NSString stringWithFormat:@"买入价: %@    止损价: %@\n止盈价: %@    仓位占比: %@",model.bid_price,model.stop_price,model.surplus_price,model.position_ratio];
                }
                [self.stockInfoArray addObject:model];
                /*! 评级 */
                NSString *stockOpertState = [NSString stringWithFormat:@"%@",model.stock_opert_state];
                /*! 操作建议 */
                NSString *stockOperDesc = [NSString stringWithFormat:@"%@",model.stock_oper_desc];
                if ([stockOpertState isEqualToString:@"买入"]&&stockOperDesc.length!=0) {
                    HXPoolDetailModel *model = [HXPoolDetailModel mj_objectWithKeyValues:dic];
                    model.stock_opert_state = @"买入建议";
                    [self.stockInfoArray addObject:model];
                }
                if ([stockOpertState isEqualToString:@"加仓"]&&stockOperDesc.length!=0) {
                    HXPoolDetailModel *model = [HXPoolDetailModel mj_objectWithKeyValues:dic];
                    model.stock_opert_state = @"加仓建议";
                    [self.stockInfoArray addObject:model];
                }
                if ([stockOpertState isEqualToString:@"建仓"]&&stockOperDesc.length!=0) {
                    HXPoolDetailModel *model = [HXPoolDetailModel mj_objectWithKeyValues:dic];
                    model.stock_opert_state = @"建仓建议";
                    [self.stockInfoArray addObject:model];
                }
                if ([stockOpertState isEqualToString:@"清仓"]&&stockOperDesc.length!=0) {
                    HXPoolDetailModel *model = [HXPoolDetailModel mj_objectWithKeyValues:dic];
                    model.stock_opert_state = @"清仓建议";
                    [self.stockInfoArray addObject:model];
                }
            }
            
            [HXLoadingView hide];
            [self.poolDetailTableView reloadData];
            if (isLoadMore == NO) {
                [self.poolDetailTableView.mj_header endRefreshing];
                [self.poolDetailTableView.mj_footer resetNoMoreData];
            }else{
                [self.poolDetailTableView.mj_footer endRefreshing];
               
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.poolDetailTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.poolDetailTableView.mj_footer endRefreshingWithNoMoreData];
            [self.poolDetailTableView.mj_header endRefreshing];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.poolDetailTableView.mj_header endRefreshing];
        }else{
            [self.poolDetailTableView.mj_footer endRefreshing];
        }
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.poolDetailTableView.mj_header endRefreshing];
        }else{
            [self.poolDetailTableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark -==========问老师信息================
-(void)addTeacherInfoBtn
{
    /*! 老师信息 */
    teachBgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), Main_Screen_Width, 35)];
    teachBgView.backgroundColor = UIColorBgLightTheme;
    /*! 老师名称 */
    teachName = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 58, 30)];
    teachName.font = UIFontSystem13;
    teachName.textColor = UIColorLightTheme;
    [teachBgView addSubview:teachName];
    /*! 军团名称 */
    legionName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(teachName.frame), 5, 60, 30)];
    legionName.font = UIFontSystem13;
    legionName.textColor = UIColorLightTheme;
    [teachBgView addSubview:legionName];
    /*! 资格证号 */
    teachNum = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(legionName.frame)+5, 5, Main_Screen_Width-160-30, 30)];
    teachNum.font = UIFontSystem13;
    teachNum.textColor = UIColorLightTheme;
    [teachBgView addSubview:teachNum];
    /*! 当前时间 */
    teachTime = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-50 , 5, 40, 30)];
    teachTime.font = UIFontSystem13;
    teachTime.textColor = UIColorLightTheme;
    [teachBgView addSubview:teachTime];
    [self.view addSubview:teachBgView];
}


-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    /*! 设置行间距 */
    paraStyle.lineSpacing = 5;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    /*! 设置字间距 NSKernAttributeName:@1.5f */
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
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
