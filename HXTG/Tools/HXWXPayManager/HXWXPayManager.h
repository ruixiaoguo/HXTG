//
//  HXWXPayManager.h
//  HXTG
//
//  Created by grx on 2017/3/9.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXWXPayManager : NSObject

+ (HXWXPayManager *)getInstance;

-(void)HXWXPayOrder:(NSDictionary *)orderDic;

@end
