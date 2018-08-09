//
//  HSDownloadManager.h
//  HSDownloadManagerExample
//
//  Created by hans on 15/8/4.
//  Copyright © 2015年 hans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSSessionModel.h"

@interface HSDownloadManager : NSObject
/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedInstance;

/**
 *  开启任务下载资源
 *
 *  @param url           下载地址
 *  @param progressBlock 回调下载进度
 *  @param stateBlock    下载状态
 */
- (void)download:(NSString *)url withDic:(NSDictionary*)dic progress:(void (^)(NSInteger, NSInteger, CGFloat))progressBlock state:(void (^)(DownloadState))stateBlock;

/**
 *  查询该资源的下载进度值
 *
 *  @param dic 下载地址
 *
 *  @return 返回下载进度值
 */
- (CGFloat)progress:(NSDictionary*)dic;

/**
 *  获取该资源总大小
 *
 *  @param dic 下载地址
 *
 *  @return 资源总大小
 */
- (NSInteger)fileTotalLength:(NSDictionary*)dic;

/**
 *  判断该资源是否下载完成
 *
 *  @param dic 下载地址
 *
 *  @return YES: 完成
 */
- (BOOL)isCompletion:(NSDictionary*)dic;

/**
 *  删除该资源
 *
 *  @param dic 下载地址
 */
- (void)deleteFile:(NSDictionary*)dic;

/**
 *  清空所有下载资源
 */
- (void)deleteAllFile;
/**
 *  暂停下载资源
 */
- (void)handle:(NSDictionary*)dic;
/**
 *  根据url获得对应的下载任务
 */
- (NSURLSessionDataTask *)getTask:(NSDictionary*)dic;
/**
 *  暂停下载资源
 */
- (void)download2:(NSString *)url withDic:(NSDictionary*)dic progress:(void (^)(NSInteger, NSInteger, CGFloat))progressBlock state:(void (^)(DownloadState))stateBlock;
@end
