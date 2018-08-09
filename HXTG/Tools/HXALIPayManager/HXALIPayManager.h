//
//  HXALIPayManager.h
//  HXTG
//
//  Created by grx on 2017/3/8.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXALIPayManager : NSObject
/*! 定义返回请求数据的block类型 */
typedef void (^HXReturnBlock)(NSDictionary *responseDict);

+ (HXALIPayManager *)getInstance;

-(void)HXALIPayOrder:(NSString *)orderString HXScheme:(NSString *)scheme callbackBlock:(HXReturnBlock)block;

@end
