//
//  HXALIPayManager.m
//  HXTG
//
//  Created by grx on 2017/3/8.
//  Copyright © 2017年 grx. All rights reserved.
//
#import "HXALIPayManager.h"
//#import <AlipaySDK/AlipaySDK.h>

@implementation HXALIPayManager

static HXALIPayManager *aliPayManage;

/*! 支付宝管理单例 */
+ (HXALIPayManager *)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aliPayManage = [[HXALIPayManager alloc]init];
    });
    return aliPayManage;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aliPayManage = [super allocWithZone:zone];
    });
    return aliPayManage;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return aliPayManage;
}


-(void)HXALIPayOrder:(NSString *)orderString HXScheme:(NSString *)scheme callbackBlock:(HXReturnBlock)block
{
    /*! NOTE: 调用支付结果开始支付 */
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:scheme callback:^(NSDictionary *resultDic) {
//        block(resultDic);
//    }];
}

@end
