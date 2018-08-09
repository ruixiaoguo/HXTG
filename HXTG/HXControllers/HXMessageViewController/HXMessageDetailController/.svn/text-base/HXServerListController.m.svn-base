//
//  HXServerListController.m
//  HXTG
//
//  Created by grx on 2017/3/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXServerListController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "HXServerListCell.h"
#import "HXMessageModel.h"
#import "JPUSHService.h"
#import "ServerMessageModel.h"
#import "HXSysDetailController.h"
#import "UILabel+ContentSize.h"
#import "NSString+TxtHeight.h"

@interface HXServerListController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>{
    UIWebView *hightWeb;
    UIView *tipView;
    int pageCount;
    CGFloat cellHight;
}

@property (nonatomic,strong) UITableView *serverTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *hightArray;

@end

@implementation HXServerListController

-(UITableView *)serverTableView
{
    if (!_serverTableView) {
        _serverTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipView.frame), Main_Screen_Width, Main_Screen_Height-104) style:UITableViewStyleGrouped];
        _serverTableView.backgroundColor = UIColorWhite;
        _serverTableView.delegate = self;
        _serverTableView.dataSource = self;
        _serverTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _serverTableView.showsVerticalScrollIndicator = NO;
        [_serverTableView registerClass:[HXServerListCell class] forCellReuseIdentifier:ServerListCellIdentifier];
    }
    return _serverTableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.hightArray = [NSMutableArray arrayWithCapacity:0];
   
    [self creatRadio];
    if ([self.title isEqualToString:@"服务消息"]) {
        /*! 清除服务消息小红点 */
        [StandardUserDefaults setBool:NO forKey:@"isServerMessage"];
        /*! 清除icon计数 */
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        [JPUSHService setBadge:0];
    }else{
        /*! 清除官方消息小红点 */
        [StandardUserDefaults setBool:NO forKey:@"isOfficialMessage"];
        /*! 清除icon计数 */
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        [JPUSHService setBadge:0];

    }
    

    self.backButton.hidden = NO;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.serverTableView];
    /*! 初始化异常界面 */
    [self initEmptyView:self.serverTableView];
    /*! 下拉刷新 */
    [self setUpHeaderRefresh];
    /*! 上拉加载 */
    [self setUpFooterRefresh];
    [self gaintMessageList:NO];
    
    
}

-(void)addHigthWeb:(NSString *)str
{
    hightWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, -400, Main_Screen_Width, 100)];
    hightWeb.delegate = self;
    hightWeb.backgroundColor = [UIColor clearColor];
    hightWeb.hidden = YES;
    hightWeb.opaque = NO;
    hightWeb.scrollView.scrollEnabled = NO;
    [self.serverTableView addSubview:hightWeb];
    [hightWeb loadHTMLString:str baseURL:nil];
    
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


/*! 下拉刷新 */
- (void)setUpHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    weakSelf.serverTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintMessageList:NO];
    }];
}

/*! 上拉加载 */
-(void)setUpFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    weakSelf.serverTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /*! 进入刷新状态后会自动调用这个block */
        [self gaintMessageList:YES];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    [self.serverTableView startAutoCellHeightWithCellClass:[HXServerListCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    return self.hightArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DDLog(@"cell======%f",[self.serverTableView cellHeightForIndexPath:indexPath model:self.dataArray[indexPath.row] keyPath:@"model"]);
//    return [self.serverTableView cellHeightForIndexPath:indexPath model:self.dataArray[indexPath.row] keyPath:@"model"];
////     HXServerListCell *cell = [self.serverTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
////        cell.gaintHight = ^(CGFloat hight) {
//////            cellHight = hight+60;
////            
////        };
//
//
//    if (self.hightArray.count==0) {
//        return 10;
//    }else{
//        return [self.hightArray[indexPath.row] integerValue];
//    }
//    return 100;
    
    return [self.hightArray[indexPath.row] integerValue];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HXServerListCell *cell = [tableView dequeueReusableCellWithIdentifier:ServerListCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = UIColorWhite;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - 获取服务消息网络请求
-(void)gaintMessageList:(BOOL)isLoadMore
{
    [HXLoadingView show];
    ServerMessageModel *model = [[ServerMessageModel alloc]init];
    if ([self.title isEqualToString:@"服务消息"]) {
        model.type = @"3";
    }else{
        model.type = @"1";
    }
    /*! 当前页 */
    if (isLoadMore==YES) {
        pageCount += 1;
    }else{
        pageCount = 1;
    }
    model.pagenum = [NSString stringWithFormat:@"%d",pageCount];
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"App/Notice" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"responseDict======%@",responseDict);
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
            if (isLoadMore == NO) {
                [self.dataArray removeAllObjects];
                [self.hightArray removeAllObjects];
            }
            for (int i=0; i<1; i++) {
                NSDictionary *dic =responseDict[@"data"][i];
                HXMessageModel *model = [HXMessageModel mj_objectWithKeyValues:dic];
//                CGFloat contentStrHight = [model.news_content heightWithLabelFont:UIFontSystem15 withLabelWidth:Main_Screen_Width-50];
//                [self.hightArray addObject:[NSString stringWithFormat:@"%f",contentStrHight+90]];
                model.news_content = @"<p>【市场点评】</p><p><img src=\"http://oq6doxvnn.bkt.clouddn.com/ueditor/20170527/5928db2e7734b.jpg\" title=\"7.jpg\" alt=\"7.jpg\" style=\"width: 91px; height: 82px;\" width=\"91\" height=\"82\"/>已经发布，敬请享受你得假期，带着你的钱去<br/></p><p>【投资建议，仅供参考】</p>";
                [self.dataArray addObject:model];
                [self addHigthWeb:model.news_content];
            }
            [HXLoadingView hide];
            [self.serverTableView reloadData];
            if (isLoadMore == NO) {
                [self.serverTableView.mj_header endRefreshing];
                [self.serverTableView.mj_footer resetNoMoreData];
            }else{
                [self.serverTableView.mj_footer endRefreshing];
                
            }
            NSString *totalCount = [NSString stringWithFormat:@"%@",responseDict[@"PageCount"]];
            int totalCountNum = [totalCount intValue];
            if (pageCount==totalCountNum) {
                [self.serverTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            pageCount -= 1;
            [HXLoadingView hide];
            [self.serverTableView.mj_header endRefreshing];
            [self.serverTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self showNoDataView:self.dataArray];
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.serverTableView.mj_header endRefreshing];
        }else{
            [self.serverTableView.mj_footer endRefreshing];
        }
        [self showNoServerView:self.dataArray];
    } WithFailureBlock:^{
        pageCount -= 1;
        [HXLoadingView hide];
        if (isLoadMore == NO) {
            [self.serverTableView.mj_header endRefreshing];
        }else{
            [self.serverTableView.mj_footer endRefreshing];
        }
        [self showNoNetView:self.dataArray];
    }];
}



-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - ================加载完成======================
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *injectionJSString = [NSString stringWithFormat:@"var script = document.createElement('meta');"
                                   "script.name = 'viewport';"
                                   "script.content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0,user-scalable=no\";"
                                   "document.getElementsByTagName('head')[0].appendChild(script);"
                                   "document.documentElement.style.webkitTouchCallout = \"none\";"
                                   "document.documentElement.style.webkitUserSelect = \"none\";"
                                   "window.scrollBy(0, 0);"];
    [webView stringByEvaluatingJavaScriptFromString:injectionJSString];
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 300.0;" // UIWebView中显示的图片宽度
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
    DDLog(@"hhhhhhhh=====%f",height);
    if (height>=682) {
        [self.hightArray addObject:[NSString stringWithFormat:@"%f",height+210]];
    }
    if (height>=590&&height<682) {
        [self.hightArray addObject:[NSString stringWithFormat:@"%f",height+190]];
    }
    if (height>=500&&height<590) {
        [self.hightArray addObject:[NSString stringWithFormat:@"%f",height+170]];
    }
    if (height>300&&height<500) {
        [self.hightArray addObject:[NSString stringWithFormat:@"%f",height+140]];
    }
    if (height<=300) {
        [self.hightArray addObject:[NSString stringWithFormat:@"%f",height+80]];
    }
    [self.serverTableView reloadData];
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
