//
//  DownLoadState.h
//  HXTG
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 华讯财经. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoadState : NSObject
/**
 * 按钮状态
 */
+ (UIButton*)buttonStateWithDic:(NSDictionary*)dic;
/**
 * 文本状态
 */
+ (UILabel*)labelStateWithDictionary:(NSDictionary*)dic;
@end
