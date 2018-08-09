//
//  DownLoad.m
//  HXTG
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 华讯财经. All rights reserved.
//

#import "DownLoad.h"
#import "HSDownloadManager.h"

@implementation DownLoad
/**
 * 下载
 */
+ (void)downLoadWithDictionary:(NSDictionary*)dic{
    
    [[HSDownloadManager sharedInstance] download:dic[@"url"] withDic:dic progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        
    } state:^(DownloadState state) {
        if (state == DownloadStateCompleted) {
            // 下载成功
            // 1)播放声音、震动
            AudioServicesPlaySystemSound(1007);
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
            NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
            NSMutableArray *array2 = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"fishList"]];
            [array2 addObject:dic];
            [userDefaults setObject:array2 forKey:@"fishList"];
            [userDefaults synchronize];
            [array removeObject:dic];
            if (array1.count > 0) {
                [array addObject:array1[0]];
                [array1 removeObjectAtIndex:0];
                [userDefaults setObject:array forKey:@"downList"];
                [userDefaults setObject:array1 forKey:@"waitList"];
                [userDefaults synchronize];
                [self downLoadWithDictionary:[array lastObject]];
            }else{
                [userDefaults setObject:array forKey:@"downList"];
                [userDefaults synchronize];
            }
        }
        else if (state == DownloadStateStart)
        {
        }
        else if (state == DownloadStateFailed)
        {
            // 下载失败
            NSMutableArray *failedList = (NSMutableArray*)[userDefaults objectForKey:@"failedList"];
            if (failedList == nil) {
                failedList = [NSMutableArray array];
            }
            if (![failedList containsObject:dic]) {
                NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:failedList];
                [array1 addObject:dic];
                [userDefaults setObject:array1 forKey:@"failedList"];
                [userDefaults synchronize];
            }else{
            }
            NSMutableArray *downArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
            NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
            [downArray removeObject:dic];
            if (array1.count > 0) {
                [downArray addObject:array1[0]];
                [array1 removeObjectAtIndex:0];
                [userDefaults setObject:downArray forKey:@"downList"];
                [userDefaults setObject:array1 forKey:@"waitList"];
                [userDefaults synchronize];
                [self downLoadWithDictionary:[downArray lastObject]];
            }else{
                [userDefaults setObject:downArray forKey:@"downList"];
                [userDefaults synchronize];
            }
        }
        else
        {
            // 暂停下载
            NSMutableArray *array = (NSMutableArray*)[userDefaults objectForKey:@"cachingList"];
            if (array == nil) {
                array = [NSMutableArray array];
            }
            if (![array containsObject:dic]) {
                NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:array];
                [array1 addObject:dic];
                [userDefaults setObject:array1 forKey:@"cachingList"];
                [userDefaults synchronize];
            }
            NSMutableArray *downArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
            NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
            [downArray removeObject:dic];
            if (array1.count > 0) {
                [downArray addObject:array1[0]];
                [array1 removeObjectAtIndex:0];
                [userDefaults setObject:downArray forKey:@"downList"];
                [userDefaults setObject:array1 forKey:@"waitList"];
                [userDefaults synchronize];
                [self downLoadWithDictionary:[downArray lastObject]];
            }else{
                [userDefaults setObject:downArray forKey:@"downList"];
                [userDefaults synchronize];
            }
        }
    }];

}
/**
 * 继续下载
 */
+ (void)continueDownLoadWithDictionary:(NSDictionary*)dic{
    // 下载
    [[HSDownloadManager sharedInstance] download2:dic[@"url"] withDic:dic progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        
    } state:^(DownloadState state) {
        DDLog(@"DownloadState=========%u",state);
        if (state == DownloadStateCompleted) {
            // 下载成功
            // 1)播放声音、震动
            AudioServicesPlaySystemSound(1007);
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
            NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
            NSMutableArray *array2 = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"fishList"]];
            [array2 addObject:dic];
            [userDefaults setObject:array2 forKey:@"fishList"];
            [userDefaults synchronize];
            [array removeObject:dic];
            if (array1.count > 0) {
                [array addObject:array1[0]];
                [array1 removeObjectAtIndex:0];
                [userDefaults setObject:array forKey:@"downList"];
                [userDefaults setObject:array1 forKey:@"waitList"];
                [userDefaults synchronize];
                [self continueDownLoadWithDictionary:[array lastObject]];
            }else{
                [userDefaults setObject:array forKey:@"downList"];
                [userDefaults synchronize];
            }
        }
        else if (state == DownloadStateStart)
        {
            
        }
        else if (state == DownloadStateFailed)
        {
            // 下载失败
            NSMutableArray *failedList = (NSMutableArray*)[userDefaults objectForKey:@"failedList"];
            if (failedList == nil) {
                failedList = [NSMutableArray array];
            }
            if (![failedList containsObject:dic]) {
                NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:failedList];
                [array1 addObject:dic];
                [userDefaults setObject:array1 forKey:@"failedList"];
                [userDefaults synchronize];
            }else{
            }
            NSMutableArray *downArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
            NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
            [downArray removeObject:dic];
            if (array1.count > 0) {
                [downArray addObject:array1[0]];
                [array1 removeObjectAtIndex:0];
                [userDefaults setObject:downArray forKey:@"downList"];
                [userDefaults setObject:array1 forKey:@"waitList"];
                [userDefaults synchronize];
                [self continueDownLoadWithDictionary:[downArray lastObject]];
            }else{
                [userDefaults setObject:downArray forKey:@"downList"];
                [userDefaults synchronize];
            }
        }
        else
        {
            // 暂停下载
            NSMutableArray *array = (NSMutableArray*)[userDefaults objectForKey:@"cachingList"];
            if (array == nil) {
                array = [NSMutableArray array];
            }
            if (![array containsObject:dic]) {
                NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:array];
                [array1 addObject:dic];
                [userDefaults setObject:array1 forKey:@"cachingList"];
                [userDefaults synchronize];
            }
            NSMutableArray *downArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
            NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
            [downArray removeObject:dic];
            if (array1.count > 0) {
                [downArray addObject:array1[0]];
                [array1 removeObjectAtIndex:0];
                [userDefaults setObject:downArray forKey:@"downList"];
                [userDefaults setObject:array1 forKey:@"waitList"];
                [userDefaults synchronize];
                [self continueDownLoadWithDictionary:[downArray lastObject]];
            }else{
                [userDefaults setObject:downArray forKey:@"downList"];
                [userDefaults synchronize];
            }
        }
    }];
}
@end
