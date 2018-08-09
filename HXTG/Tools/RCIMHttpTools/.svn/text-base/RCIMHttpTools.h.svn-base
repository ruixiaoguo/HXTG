//
//  RCIMHttpTools.h
//  HXTG
//
//  Created by grx on 2017/4/19.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

#define RCIMHTTPTOOLS [RCIMHttpTools shareInstance]

@interface RCIMHttpTools : NSObject

/**
 * RCIMHttpTools单例
 */
+ (RCIMHttpTools *)shareInstance;

/**
 * 获取用户个人信息
 */
- (void)getUserInfoWithUserID:(NSString *)userID
                   completion:(void (^)(RCUserInfo *user))completion;


@end
