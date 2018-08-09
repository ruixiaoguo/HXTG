//
//  HXAppDelegate+ShareManage.m
//  HXTG
//
//  Created by grx on 2017/2/20.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXAppDelegate+OtheManage.h"
//#import "WXApi.h" /*! 微信SDK头文件 */
#import "RCIMHttpTools.h"
@implementation HXAppDelegate (OtheManage)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzleMethod(class, @selector(application:didFinishLaunchingWithOptions:),
                      @selector(other_application:didFinishLaunchingWithOptions:));
        swizzleMethod(class, @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:),
                      @selector(other_application:didRegisterForRemoteNotificationsWithDeviceToken:));
        swizzleMethod(class, @selector(application:didReceiveRemoteNotification:),
                      @selector(other_application:didReceiveRemoteNotification:));
        swizzleMethod(class, @selector(application:didRegisterUserNotificationSettings:),
                      @selector(other_application:didRegisterUserNotificationSettings:));
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

- (BOOL)other_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    BOOL result = [self other_application:application didFinishLaunchingWithOptions:launchOptions];
    /*! 微信支付 */
//    [WXApi registerApp:@"wx920fde9f97d60569"];
    /*! 初始化融云SDK */
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY]; // 融云APPKEY
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    /*! 如果已登录自动连接融云 */
    if ([[StandardUserDefaults objectForKey:ISLOGIN]boolValue])
    {
        [self loginRongYunServer];
    }
    /*! 注册推送 */
    [self registerNotification:application];
    /*! 友盟统计 */
    UMConfigInstance.appKey = UMConfigAppKey;
    UMConfigInstance.channelId = @"App Store";
    /*! 配置以上参数后调用此方法初始化SDK */
    [MobClick startWithConfigure:UMConfigInstance];
    DDLog(@"友盟统计=======");
    /*! 接受推送点击icon进入应用时 */
    //if (application.applicationIconBadgeNumber==0) {
    //    [StandardUserDefaults setBool:NO forKey:@"isRYChatMessage"];
    //}else{
    //    [StandardUserDefaults setBool:YES forKey:@"isRYChatMessage"];
    //}
    return result;
}

#pragma mark -- 接收设备令牌
- (void)other_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];

}

#pragma mark -- 注册用户通知设置
- (void)other_application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    /*! register to receive notifications */
    [application registerForRemoteNotifications];
}

#pragma mark - 注册推送服务
-(void)registerNotification:(UIApplication *)application
{
    /*! 推送 */
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        /*! 注册推送, 用于iOS8以及iOS8之后的系统 */
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        /*! 注册推送，用于iOS8之前的系统 */
//        [application registerForRemoteNotificationTypes:
//         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
}

#pragma mark -- 接收到远程推送通知之后
/*! 如果 App状态为正在前台或者点击通知栏的通知消息，那么此函数将被调用 */
- (void)other_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSDictionary *apsDict = userInfo[@"aps"];
    NSInteger badge = [apsDict[@"badge"]integerValue];
    application.applicationIconBadgeNumber = badge;
    DDLog(@"推送消息2=========%@",userInfo);
    /*! 发送通知 */
    [self jumpToRYChatVC];
    /*! 存储小红点 */
    [StandardUserDefaults setBool:YES forKey:@"isRYChatMessage"];

    
}


#pragma mark - iOS10: 收到推送消息调用(iOS10是通过Delegate实现的回调)
#pragma mark - App处于前台接收通知时
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        /*! 存储小红点 */
        [StandardUserDefaults setBool:YES forKey:@"isRYChatMessage"];
    }
    /*! 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置 */
    completionHandler(UNNotificationPresentationOptionSound);
}

//
#pragma mark - App处于后台点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    //收到推送的请求
    UNNotificationRequest *request = response.notification.request;
    //收到推送的内容
    UNNotificationContent *content = request.content;
    //收到用户的基本信息
    NSDictionary *userInfo = content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        DDLog(@"iOS10 后台收到远程通知:%@",userInfo);
        /*! 发送通知 */
        [self jumpToRYChatVC];
        /*! 存储小红点 */
        [StandardUserDefaults setBool:YES forKey:@"isRYChatMessage"];

    }
//    completionHandler(); // 系统要求执行这个方法
    completionHandler(UNNotificationPresentationOptionSound);

}

- (void)onRCIMReceiveMessage:(RCMessage *)message
                        left:(int)left
{
    int allunread = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    NSString *countStr = [NSString stringWithFormat:@"%d",allunread];
    DDLog(@"剩余消息条数%d,===%@",allunread,message.targetId);
    NSDictionary *messageDic = @{@"allunread":countStr,@"targetId":message.targetId};
    
    /*! 发送通知接收到融云新消息 */
    [[NSNotificationCenter defaultCenter]postNotificationName:RYGetChatNotification object:messageDic];
    [[NSNotificationCenter defaultCenter]postNotificationName:RYGetUnChatNotification object:nil];

}




#pragma mark - 自动登录融云
-(void)loginRongYunServer
{
    NSString *token = USERRYTOKEN;
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        
        DDLog(@"userId=======%@",userId);
        
    } error:^(RCConnectErrorCode status) {
        
        DDLog(@"Token无效,RCConnectErrorCode is %ld",(long)status);
    } tokenIncorrect:^{
        DDLog(@"TokenID已过期，请重新获取");
    }];
}


#pragma mark - 用户信息提供者函数(设置聊天用户的基本信息)MMAPP
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {

    NSString *userIdStr = [NSString stringWithFormat:@"%@",USERID];
    if ([userId isEqualToString:userIdStr]) {
        RCUserInfo *user = [[RCUserInfo alloc] init];
        user.userId = userIdStr;
        user.portraitUri = @"http://oq6doxvnn.bkt.clouddn.com/admin/20170525/yonghu.png";
        user.name = USERNAME;
        return completion(user);
    }else if ([userId isEqualToString:@"81"]){
        RCUserInfo *user = [[RCUserInfo alloc] init];
        user.userId = @"81";
        user.portraitUri = @"http://oq6doxvnn.bkt.clouddn.com/admin/20170525/zaixiankefutouxiang.png";
        user.name = @"在线客服";
        return completion(user);
    }else {
//        RCUserInfo *user = [[RCUserInfo alloc] init];
//        user.userId = TEACHERID;
//        user.portraitUri = @"http://oq6doxvnn.bkt.clouddn.com/admin/20170525/juntuatouxiang.png";
//        user.name = LEGIONNAME;
//        return completion(user);
        [[RCIMHttpTools shareInstance]getUserInfoWithUserID:userId completion:^(RCUserInfo *user) {
            return completion(user);
        }];
    }
}


#pragma mark - ======================后台接收到推送点击跳转到融云聊天界面===================
-(void)jumpToRYChatVC
{
    /*! 发送通知到融云聊天跳转 */
    [[NSNotificationCenter defaultCenter]postNotificationName:RYChatNotification object:nil];

}


@end
