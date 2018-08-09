//
//  AppDelegate.m
//  HXTG
//
//  Created by grx on 2017/2/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXAppDelegate.h"
#import "HXTabBarController.h"
#import "HXHomeViewController.h"

@interface HXAppDelegate ()

@property (strong, nonatomic) NSMutableArray *cachingList;  /*! 缓存暂停列表 */

@end

@implementation HXAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    HXTabBarController *tabVC = [HXTabBarController new];
    self.window.rootViewController = tabVC;
    tabVC.delegate = self;

    [self.window makeKeyAndVisible];
    
        
    /*! 数据库 */
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"RYUserInfo.sqlite"];
    NSString* docs=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    /*! 数据库地址 */
    DDLog(@"docs======%@",docs);
    
    /*! 当前版本号 */
    /*! 显示欢迎页面 用app version做对比 */
    if (![userDefaults boolForKey:[UtilityFunction gaintVersion]])
    {
        [userDefaults setBool:YES  forKey:[UtilityFunction gaintVersion]];
        [userDefaults synchronize];
//        DDLog(@"======第一次进入");
    }else{
//        DDLog(@"======不是第一次进入");
    }
    /*! 暂停所有正在下载的视频 */
    [self gaintAllDownList];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    /*! 数据库管理 */
    [MagicalRecord cleanUp];
}

#pragma mark -- 获取缓存列表（程序重新启动全部暂停下载任务）
- (void)gaintAllDownList{
    self.cachingList = [NSMutableArray arrayWithCapacity:0];
    // 下载列表
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
    // 等待列表
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
    // 暂停列表
    NSMutableArray *ZTarray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
    // 下载失败列表
    NSMutableArray *failed = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"failedList"]];
    [self.cachingList addObjectsFromArray:array];
    [self.cachingList addObjectsFromArray:array1];
    [self.cachingList addObjectsFromArray:ZTarray];
    
    for (NSDictionary *dic in failed) {
        if (![ZTarray containsObject:dic]) {
            [self.cachingList addObject:dic];
        }
    }
    // 移除所有下载任务
    [array removeAllObjects];
    [userDefaults setObject:array forKey:@"downList"];
    [array1 removeAllObjects];
    [userDefaults setObject:array1 forKey:@"waitList"];
    [failed removeAllObjects];
    [userDefaults setObject:failed forKey:@"failedList"];
    // 把未完成的添加到暂停列表
    [userDefaults setObject:self.cachingList forKey:@"cachingList"];
    [userDefaults synchronize];
}



@end
