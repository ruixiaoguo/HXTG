//
//  GlobalFile.m
//  HXTG
//
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GlobalFile.h"

@implementation GlobalFile

+ (NSString *)directoryPathWithFileName:(NSString *)fileName
{
    NSString* filePath = [[UtilityFunction documentsPath] stringByAppendingFormat:@"/%@",HX_FILE_KEY];
    NSString* directoryPath = [[UtilityFunction directoryPath:filePath] stringByAppendingString:fileName];
    
    return directoryPath;
    
}

+ (NSString *)directoryCachePathWithFileName:(NSString *)fileName
{
    NSString* filePath = [[UtilityFunction cachesPath] stringByAppendingFormat:@"/%@",HX_FILE_KEY];
    NSString* directoryPath = [[UtilityFunction directoryPath:filePath] stringByAppendingString:fileName];
    
    return directoryPath;
}


@end
