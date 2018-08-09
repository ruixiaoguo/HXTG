//
//  NotificationMacro.h
//  HXTG
//
//  Created by grx on 2017/4/27.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationMacro : NSObject

/*! ===============================极光===================================== */
/*! 点击极光推送跳转到服务消息 */
extern NSString *const JumpToServerListNotification;
/*! 前台接收到推送显示小红点 */
extern NSString *const ChangeHomeMessageNotification;

/*! ===============================融云===================================== */
/*! 点击融云推送跳转到聊天界面 */
extern NSString *const RYChatNotification;
/*! 前台接收到融云消息 */
extern NSString *const RYGetChatNotification;
/*! 融云未读消息 */
extern NSString *const RYGetUnChatNotification;


/*! 登陆成功刷新首页 */
extern NSString *const RefreshHomeNotification;
/*! 注册成功跳转到我的 */
extern NSString *const RegistToMeNotification;
/*! 登陆成功刷新我的 */
extern NSString *const RefreshMeNotification;

@end
