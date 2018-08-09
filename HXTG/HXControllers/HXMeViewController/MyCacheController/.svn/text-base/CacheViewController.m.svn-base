//
//  CacheViewController.m
//  HXTG
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 华讯财经. All rights reserved.
//

#import "CacheViewController.h"
#import "DownLoad.h"
#import "HSDownloadManager.h"
#import "MyCacheBotomView.h"
#import "HXMyCacheCell.h"
#import "HXPlayViewController.h"

@interface CacheViewController (){
    MyCacheBotomView *bottomView;
    HXMyCacheCell *cell;
    HXMyEditCacheCell *editCell;
}

@property(nonatomic,strong) UIButton *editBtn;

@end

@implementation CacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"离线缓存";
    self.backButton.hidden = NO;
    self.view.backgroundColor = UIColorBgLightTheme;
    _delBool = NO;
    _deletList = [NSMutableArray array];
    /*! 获取缓存数据 */
    [self getdownList:NO];
    /*! 初始化创建视图 */
    [self _initView];
    /*! 创建异常界面 */
    [self initEmptyView:self.myCacheTableView];
    /*! 取消/编辑 */
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.frame = CGRectMake(0,0,60,30);
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = UIFontSystem14;
    [self.editBtn addTarget:self action:@selector(KeepAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -18;
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editBtn];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightButtonItem, nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /*! 开启定时器(验证是否有下载) */
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getdownList:) userInfo:nil repeats:YES];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_myTimer invalidate];
    _myTimer = nil;
}
#pragma mark -- 创建视图
- (void)_initView{
    _myCacheTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
    _myCacheTableView.delegate = self;
    _myCacheTableView.dataSource = self;
    _myCacheTableView.backgroundColor = UIColorBgLightTheme;
    _myCacheTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _myCacheTableView.showsVerticalScrollIndicator = NO;
    [_myCacheTableView registerClass:[HXMyCacheCell class] forCellReuseIdentifier:myCacheCellIdentifier];
    [_myCacheTableView registerClass:[HXMyEditCacheCell class] forCellReuseIdentifier:myEditCacheCellIdentifier];

    
    [self.view addSubview:_myCacheTableView];
}
#pragma mark -- 获取缓存列表
- (void)getdownList:(BOOL)deleted{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
    NSMutableArray *cachingList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
    NSMutableArray *failedList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"failedList"]];
    _waitArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
    _cachedList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"fishList"]];
    _cachingList = [NSMutableArray array];
    for (int i=0;i<array.count;i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:array[i]];
        CGFloat f = [[HSDownloadManager sharedInstance] progress:array[i]];
        if (f >= 1) {
            [_cachedList addObject:dic];
        }else if (f > 0){
            [_cachingList addObject:dic];
        }else{
            [_cachingList addObject:dic];
        }
    } 
    [_cachingList addObjectsFromArray:_waitArray];
    [_cachingList addObjectsFromArray:failedList];
    [_cachingList addObjectsFromArray:_cachedList];
    
    for (int i = 0; i < cachingList.count; i++) {
        if (![_cachingList containsObject:cachingList[i]]) {
            [_cachingList addObject:cachingList[i]];
        }
    }
    if (deleted == YES) {
        
    }else{
        [_myCacheTableView reloadData];
    }
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
/*! 先要设Cell可编辑 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
/*! 定义编辑样式 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_myTimer setFireDate:[NSDate distantFuture]];
    return UITableViewCellEditingStyleDelete;
}
/*! 进入编辑模式，按下出现的编辑按钮后,进行删除操作 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL down = NO;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
        NSMutableArray *waitArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
        NSMutableArray *cachedList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"fishList"]];
        NSMutableArray *ZTarray =  [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
        NSMutableArray *failedList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"failedList"]];
        if ([failedList containsObject:_cachingList[indexPath.section]]) {
            [failedList removeObject:_cachingList[indexPath.section]];
            [userDefaults setObject:failedList forKey:@"failedList"];
            [userDefaults synchronize];
        }
        if ([array containsObject:_cachingList[indexPath.section]]) {
            [array removeObject:_cachingList[indexPath.section]];
            [userDefaults setObject:array forKey:@"downList"];
            [userDefaults synchronize];
            down = !down;
        }
        if ([waitArray containsObject:_cachingList[indexPath.section]]) {
            [waitArray removeObject:_cachingList[indexPath.section]];
            [userDefaults setObject:waitArray forKey:@"waitList"];
            [userDefaults synchronize];
        }
        if ([cachedList containsObject:_cachingList[indexPath.section]]) {
            [cachedList removeObject:_cachingList[indexPath.section]];
            [userDefaults setObject:cachedList forKey:@"fishList"];
            [userDefaults synchronize];
        }
        if ([ZTarray containsObject:_cachingList[indexPath.section]]) {
            [ZTarray removeObject:_cachingList[indexPath.section]];
            [userDefaults setObject:ZTarray forKey:@"cachingList"];
            [userDefaults synchronize];
            down = !down;
        }
        [[HSDownloadManager sharedInstance]deleteFile:_cachingList[indexPath.section]];
        [self getdownList:YES];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        if (down == YES) {
            if (waitArray.count > 0) {
                [array addObject:waitArray[0]];
                [waitArray removeObjectAtIndex:0];
                [userDefaults setObject:array forKey:@"downList"];
                [userDefaults setObject:waitArray forKey:@"waitList"];
                [userDefaults synchronize];
                [self downFileWithDictionary:[array lastObject]];
            }else{
                [userDefaults setObject:array forKey:@"downList"];
                [userDefaults synchronize];
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath{
    /*! 开启定时器(验证是否有下载) */
    [_myTimer setFireDate:[NSDate date]];
}
/*! 修改编辑按钮文字 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_cachingList.count==0) {
        bottomView.hidden = YES;
        self.editBtn.enabled = NO;
    }else{
        self.editBtn.enabled = YES;
    }
    [self showNoDataView:_cachingList];
    return _cachingList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delBool==NO) {
         cell = [tableView dequeueReusableCellWithIdentifier:myCacheCellIdentifier forIndexPath:indexPath];
         cell.titleLable.text = _cachingList[indexPath.section][@"title"];
         cell.titleLable.textColor = UIColorBlackTheme;
         /*! 下载状态 */
         UILabel *proess = [DownLoadState labelStateWithDictionary: _cachingList[indexPath.section]];
         cell.downLoadLable.text = proess.text;
         CGFloat f = [[HSDownloadManager sharedInstance] progress:_cachingList[indexPath.section]];
         [cell.progressView setProgress:f animated:NO];
         return cell;
    }else{
        editCell = [tableView dequeueReusableCellWithIdentifier:myEditCacheCellIdentifier forIndexPath:indexPath];
        if ([_deletList containsObject:_cachingList[indexPath.section]]) {
            [editCell.selectButton setBackgroundImage:[UIImage imageNamed:@"yuan2"] forState:UIControlStateNormal];

        }else{
            [editCell.selectButton setBackgroundImage:[UIImage imageNamed:@"yuan1"] forState:UIControlStateNormal];
        }
        editCell.titleLable.text = _cachingList[indexPath.section][@"title"];
        editCell.titleLable.textColor = UIColorBlackTheme;
        /*! 下载状态 */
        UILabel *proess = [DownLoadState labelStateWithDictionary: _cachingList[indexPath.section]];
        editCell.downLoadLable.text = proess.text;
        return editCell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delBool==NO) {
    }else{
        if (![_deletList containsObject:_cachingList[indexPath.section]]) {
            [editCell.selectButton setBackgroundImage:[UIImage imageNamed:@"yuan2"] forState:UIControlStateNormal];
            [_deletList addObject:_cachingList[indexPath.section]];
        }else{
            [_deletList removeObject:_cachingList[indexPath.section]];
            [editCell.selectButton setBackgroundImage:[UIImage imageNamed:@"yuan1"] forState:UIControlStateNormal];
        }
        [self.myCacheTableView reloadData];
        return;
    }
    /*! 暂停列表 */
    NSMutableArray *ZTarray =  [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
    /*! 下载列表 */
    NSMutableArray *downarray =  [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
    /*! 等待下载 */
    NSMutableArray *waitList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
    /*! 获取下载进度 */
    NSMutableDictionary *dic = _cachingList[indexPath.section];
    CGFloat f = [[HSDownloadManager sharedInstance] progress:dic];
    if (f >= 1) {
        HXPlayViewController *playerVC = [[HXPlayViewController alloc] init];
        playerVC.plarInfo = dic;
        [self.navigationController pushViewController:playerVC animated:YES];
        return;
    }
    /*! 暂停下载 */
    if ([waitList containsObject:dic]) {
        [waitList removeObject:dic];
        [userDefaults setObject:waitList forKey:@"waitList"];
        [userDefaults synchronize];
        [ZTarray addObject:dic];
        [userDefaults setObject:ZTarray forKey:@"cachingList"];
        [userDefaults synchronize];
        return;
    }
    /*! 移除下载失败列表 */
    BOOL a = YES;
    NSMutableArray *failed = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"failedList"]];
    if ([failed containsObject:dic]) {
        [failed removeObject:dic];
        [userDefaults setObject:failed forKey:@"failedList"];
        [userDefaults synchronize];
        a = !a;
    }
    /*! 暂停下载 */
    if (a == NO) {
        
    }else{
        if ([downarray containsObject:dic]&&(![ZTarray containsObject:dic])) {
            [self downFileWithDictionary:dic];
            return;
        }
    }
    if ((downarray.count < 1)||((downarray.count == ZTarray.count) && downarray.count != 1)) {
        if (downarray == nil) {
            downarray = [NSMutableArray array];
        }
        if (![downarray containsObject:dic]) {
            NSMutableArray *aRRay = [[NSMutableArray alloc] initWithArray:downarray];
            [aRRay addObject:dic];
            [userDefaults setObject:aRRay forKey:@"downList"];
            [userDefaults synchronize];
        }
        /*! 开始下载 */
        [self downFileWithDictionary:dic];
    }else{
        /*! 加入等待列表 */
        NSMutableArray *array1 = (NSMutableArray*)[userDefaults objectForKey:@"waitList"];
        if (array1 == nil) {
            array1 = [NSMutableArray array];
        }
        if (![array1 containsObject:dic]) {
            NSMutableArray *aRRay = [[NSMutableArray alloc] initWithArray:array1];
            [aRRay addObject:dic];
            NSMutableArray *downList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
            NSMutableArray *ZTList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
            [downList removeObject:dic];
            [userDefaults setObject:downList forKey:@"downList"];
            [ZTList removeObject:dic];
            [userDefaults setObject:ZTList forKey:@"cachingList"];
            [userDefaults setObject:aRRay forKey:@"waitList"];
            [userDefaults synchronize];
        }
    }
    /*! 移除暂停列表 */
    if ([ZTarray containsObject:dic]) {
        [ZTarray removeObject:dic];
        [userDefaults setObject:ZTarray forKey:@"cachingList"];
        [userDefaults synchronize];
    }
    
}
#pragma mark -- 下载
- (void)downFileWithDictionary:(NSDictionary*)dic{
    [DownLoad continueDownLoadWithDictionary:dic];
}

#pragma mark -- 编辑事件
- (void)KeepAction:(UIButton*)button{
    _delBool = !_delBool;
    if (_delBool == YES) {
        [self _del];
        bottomView.hidden = NO;
        [self.editBtn setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        [self _canel];
        bottomView.hidden = YES;
        [_deletList removeAllObjects];
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    [self.myCacheTableView reloadData];
}
#pragma mark -- 编辑
- (void)_del{
    /*! 底部编辑 */
    if (bottomView==nil) {
        bottomView = [[MyCacheBotomView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 50)];
        [self.view addSubview:bottomView];
        WeakSelf(weakSelf);
        bottomView.bottomSelectButtonClick = ^(){
            /*! 全部选中 */
            [weakSelf.deletList removeAllObjects];
            [weakSelf.deletList addObjectsFromArray:weakSelf.cachingList];
            [weakSelf.myCacheTableView reloadData];
        };
        bottomView.bottomCancleButtonClick = ^(){
            /*! 循环删除 */
            for (NSDictionary*dic in weakSelf.deletList) {
                [weakSelf delWithDic:dic];
            }
            /*! 判断下载 */
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
            NSMutableArray *waitArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
            if (array.count==0) {
                if (waitArray.count > 0) {
                    [array addObject:waitArray[0]];
                    [waitArray removeObjectAtIndex:0];
                    [userDefaults setObject:array forKey:@"downList"];
                    [userDefaults setObject:waitArray forKey:@"waitList"];
                    [userDefaults synchronize];
                    [weakSelf downFileWithDictionary:[array lastObject]];
                }else{
                    [userDefaults setObject:array forKey:@"downList"];
                    [userDefaults synchronize];
                }
            }
            /*! 返回正常状态 */
            [weakSelf KeepAction:weakSelf.button];
            [weakSelf.myCacheTableView reloadData];
            [weakSelf _canel];
        };

    }
    /*! 设置动画效果 */
    [UIView animateWithDuration:.22 animations:^{
        bottomView.frame = CGRectMake(0, Main_Screen_Height-50, Main_Screen_Width, 50);
    } completion:^(BOOL finished) {
    }];
}
#pragma mark -- 取消选中
- (void)_canel{
    /*! 设置动画效果 */
    [UIView animateWithDuration:.22 animations:^{
        bottomView.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 50);
    } completion:^(BOOL finished) {
    }];

}

#pragma mark - 删除数据
- (void)delWithDic:(NSDictionary*)dic{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
    NSMutableArray *waitArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
    NSMutableArray *cachedList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"fishList"]];
    NSMutableArray *ZTarray =  [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
    NSMutableArray *failedList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"failedList"]];
    if ([failedList containsObject:dic]) {
        [failedList removeObject:dic];
        [userDefaults setObject:failedList forKey:@"failedList"];
        [userDefaults synchronize];
    }
    if ([array containsObject:dic]) {
        [array removeObject:dic];
        [userDefaults setObject:array forKey:@"downList"];
        [userDefaults synchronize];
    }
    if ([waitArray containsObject:dic]) {
        [waitArray removeObject:dic];
        [userDefaults setObject:waitArray forKey:@"waitList"];
        [userDefaults synchronize];
    }
    if ([cachedList containsObject:dic]) {
        [cachedList removeObject:dic];
        [userDefaults setObject:cachedList forKey:@"fishList"];
        [userDefaults synchronize];
    }
    if ([ZTarray containsObject:dic]) {
        [ZTarray removeObject:dic];
        [userDefaults setObject:ZTarray forKey:@"cachingList"];
        [userDefaults synchronize];
    }
    [[HSDownloadManager sharedInstance]deleteFile:dic];
    [self getdownList:YES];
}

#pragma mark -- 返回
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
