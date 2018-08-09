//
//  GlobalFile.h
//  HXTG
//
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilityFunction.h"

@interface GlobalFile : NSObject

+ (NSString *)directoryPathWithFileName:(NSString *)fileName;
+ (NSString *)directoryCachePathWithFileName:(NSString *)fileName;

@end
