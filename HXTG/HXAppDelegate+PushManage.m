//
//  HXAppDelegate+PushManage.m
//  HXTG
//
//  Created by grx on 2017/2/20.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXAppDelegate+PushManage.h"

@implementation HXAppDelegate (PushManage)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzleMethod(class, @selector(application:didFinishLaunchingWithOptions:),
                      @selector(hx_application:didFinishLaunchingWithOptions:));
        swizzleMethod(class, @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:),
                      @selector(hx_application:didRegisterForRemoteNotificationsWithDeviceToken:));
        swizzleMethod(class, @selector(application:didFailToRegisterForRemoteNotificationsWithError:),
                      @selector(hx_application:didFailToRegisterForRemoteNotificationsWithError:));
        swizzleMethod(class, @selector(application:didReceiveRemoteNotification:),
                      @selector(hx_application:didReceiveRemoteNotification:));
        swizzleMethod(class, @selector(application:didReceiveRemoteNotification:fetchCompletionHandler:),
                      @selector(hx_application:didReceiveRemoteNotification:fetchCompletionHandler:));
        
        swizzleMethod(class, @selector(applicationWillEnterForeground:),
                      @selector(hx_applicationWillEnterForeground:));
        swizzleMethod(class, @selector(application:handleActionWithIdentifier:forRemoteNotification:completionHandler:),
                      @selector(hx_application:handleActionWithIdentifier:forRemoteNotification:completionHandler:));
    });
}

static inline void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)   {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (BOOL)hx_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    BOOL result = [self hx_application:application didFinishLaunchingWithOptions:launchOptions];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        /*! iOS10以上 */
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        /*! iOS8以上可以添加自定义categories */
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeSound)
                                              categories:nil];
    }
    else {
        /*! iOS8以下categories 必须为nil */
        [JPUSHService registerForRemoteNotificationTypes:(UNAuthorizationOptionBadge |
                                                          UNAuthorizationOptionSound |
                                                          UNAuthorizationOptionAlert)
                                              categories:nil];
    }
    /*! Required(2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil */
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:JPushAppSecret
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    if ([[StandardUserDefaults objectForKey:ISLOGIN]boolValue]){
        /*! 用于绑定极光Alias */
        [JPUSHService setAlias:USERNAME callbackSelector:nil object:self];
    }
    /*! 接受推送点击icon进入应用时 */
    if (application.applicationIconBadgeNumber==0) {
        [StandardUserDefaults setBool:NO forKey:@"isServerMessage"];
        [StandardUserDefaults setBool:NO forKey:@"isOfficialMessage"];
    }else{
        [StandardUserDefaults setBool:YES forKey:@"isServerMessage"];
        [StandardUserDefaults setBool:YES forKey:@"isOfficialMessage"];
    }

    return result;
}

#pragma mark -- 接收设备令牌
- (void)hx_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [self hx_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    /*! 修改设备消息通知token */
    [JPUSHService registerDeviceToken:deviceToken];
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *HXdeviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    DDLog(@"接收设备令牌======%@",HXdeviceToken);

}
//
#pragma mark -- 获取device token失败后
- (void)hx_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
       DDLog(@"获取device token失败======");
}


- (void)hx_application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[identifier]];
    completionHandler();  /*! 系统要求执行这个方法 */
}

#pragma mark -- 进入前台后设置消息信息
-(void)hx_applicationWillEnterForeground:(UIApplication *)application
{
    /*! 进入前台应用消息图标暂时不作操作
        用户阅读后才消失
     */

}

#pragma mark - iOS7+: iOS7及以上系统调用(iOS7是通过系统实现的回调)
- (void)hx_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self hx_application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
    
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark - iOS6: iOS6及以下系统(iOS6是通过系统实现的回调)
/*! 如果 App状态为正在前台或者点击通知栏的通知消息，那么此函数将被调用 */
- (void)hx_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    if (application.applicationState == UIApplicationStateActive) {
        /*! 转换成一个alerView(当前在前台) */
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        }else{
        }
    }
    else
    {
        
    }
    [JPUSHService handleRemoteNotification:userInfo];
    
}

#pragma mark - iOS10: 收到推送消息调用(iOS10是通过Delegate实现的回调)
#pragma mark- JPUSHRegisterDelegate
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark -- 当程序在前台时, 收到推送弹出的通知
-(void)jpushNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSString *tag = userInfo[@"tag"];
        if ([tag isEqualToString:@"1"]) {
            /*! 官方公告 */
            [StandardUserDefaults setBool:YES forKey:@"isOfficialMessage"];
        }else if ([tag isEqualToString:@"3"]){
            [StandardUserDefaults setBool:YES forKey:@"isServerMessage"];
        }
        NSInteger badge = [userInfo[@"aps"][@"badge"] intValue];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];
        /*! 发送通知 */
        [self changeHomeMessageTip];
        DDLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
    }
    /*! 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置 */
//    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);

    completionHandler(UNNotificationPresentationOptionSound);
}

#pragma mark -- 程序进入后台后, 通过点击推送弹出的通知
-(void)jpushNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSString *tag = userInfo[@"tag"];
        /*! 发送通知 */
        [self jumpToHXServerListVC:userInfo];
        if ([tag isEqualToString:@"1"]) {
            /*! 官方公告 */
            [StandardUserDefaults setBool:YES forKey:@"isOfficialMessage"];
        }else if ([tag isEqualToString:@"3"]){
            [StandardUserDefaults setBool:YES forKey:@"isServerMessage"];
        }
        DDLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
    }
//    completionHandler();  /*! 系统要求执行这个方法 */
    completionHandler(UNNotificationPresentationOptionSound);

}

#endif

-(NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return str;
}

#pragma mark - ====================后台接收到推送点击跳转到系统服务=================
-(void)jumpToHXServerListVC:(NSDictionary *)userInfo
{
    /*! 发送通知到首页跳转 */
    [[NSNotificationCenter defaultCenter]postNotificationName:JumpToServerListNotification object:userInfo];
}

#pragma mark - ====================前台接收到推送首页发现显示小红点=================
-(void)changeHomeMessageTip
{
    /*! 前台接收到推送显示小红点 */
    [[NSNotificationCenter defaultCenter]postNotificationName:ChangeHomeMessageNotification object:nil];
}

@end
