//
//  HSDownloadManager.m
//  HSDownloadManagerExample
//
//  Created by hans on 15/8/4.
//  Copyright © 2015年 hans. All rights reserved.
//

#import "HSDownloadManager.h"
#import "NSString+Hash.h"

@interface HSDownloadManager()<NSCopying, NSURLSessionDelegate>

/** 保存所有任务(注：用下载地址md5后作为key) */
@property (nonatomic, strong) NSMutableDictionary *tasks;
/** 保存所有下载相关信息 */
@property (nonatomic, strong) NSMutableDictionary *sessionModels;
@end

@implementation HSDownloadManager

- (NSMutableDictionary *)tasks
{
    if (!_tasks) {
        _tasks = [NSMutableDictionary dictionary];
    }
    return _tasks;
}

- (NSMutableDictionary *)sessionModels
{
    if (!_sessionModels) {
        _sessionModels = [NSMutableDictionary dictionary];
    }
    return _sessionModels;
}


static HSDownloadManager *_downloadManager;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _downloadManager = [super allocWithZone:zone];
    });
    
    return _downloadManager;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone
{
    return _downloadManager;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _downloadManager = [[self alloc] init];
    });
    
    return _downloadManager;
}

/**
 *  创建缓存目录文件
 */
- (void)createCacheDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:HSCachesDirectory]) {
        [fileManager createDirectoryAtPath:HSCachesDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
        DDLog(@"HSCachesDirectory====%@",HSCachesDirectory);
        
    }
}
- (NSOperationQueue *)queue
{
    static NSOperationQueue *queue = nil;
    @synchronized(self) {
        if (queue == nil) {
            queue = [[NSOperationQueue alloc] init];
            queue.maxConcurrentOperationCount = 1;
        }
    }
    return queue;
}
/**
 *  开启任务下载资源
 */
- (void)download:(NSString *)url withDic:(NSDictionary*)dic progress:(void (^)(NSInteger, NSInteger, CGFloat))progressBlock state:(void (^)(DownloadState))stateBlock
{
    if (!url) return;
    if ([self isCompletion:dic]) {
//        stateBlock(DownloadStateCompleted);
        DDLog(@"----该资源已下载完成");
        return;
    }
    
    // 暂停
    if ([self.tasks valueForKey:HSFileName(dic)]) {
//        [self handle:title];
           NSURLSessionDataTask *task = [[HSDownloadManager sharedInstance] getTask:dic];
        if (task == nil) {
        }else{
            [self handle:dic];
            return;
        }
    }
    
    // 创建缓存目录文件
    [self createCacheDirectory];
    
   NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[self queue]];
    
    // 创建流
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:HSFileFullpath(dic) append:YES];
    
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 设置请求头
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-", HSDownloadLength(dic)];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    // 创建一个Data任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    NSUInteger taskIdentifier = arc4random() % ((arc4random() % 10000 + arc4random() % 10000));
    [task setValue:@(taskIdentifier) forKeyPath:@"taskIdentifier"];

    // 保存任务
    [self.tasks setValue:task forKey:HSFileName(dic)];

    HSSessionModel *sessionModel = [[HSSessionModel alloc] init];
    sessionModel.url = url;
    sessionModel.progressBlock = progressBlock;
    sessionModel.stateBlock = stateBlock;
    sessionModel.stream = stream;
    sessionModel.dic = dic;
    [self.sessionModels setValue:sessionModel forKey:@(task.taskIdentifier).stringValue];
    
    [self start:dic];
}
- (void)download2:(NSString *)url withDic:(NSDictionary*)dic progress:(void (^)(NSInteger, NSInteger, CGFloat))progressBlock state:(void (^)(DownloadState))stateBlock
{
    if (!url) return;
    if ([self isCompletion:dic]) {
        stateBlock(DownloadStateCompleted);
        DDLog(@"----该资源已下载完成");
        return;
    }
    
    // 暂停
    if ([self.tasks valueForKey:HSFileName(dic)]) {
        
        [self handle:dic];
        
        return;
    }
    
    // 创建缓存目录文件
    [self createCacheDirectory];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[self queue]];
    
    // 创建流
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:HSFileFullpath(dic) append:YES];
    
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 设置请求头
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-", HSDownloadLength(dic)];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    // 创建一个Data任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    NSUInteger taskIdentifier = arc4random() % ((arc4random() % 10000 + arc4random() % 10000));
    [task setValue:@(taskIdentifier) forKeyPath:@"taskIdentifier"];
    
    // 保存任务
    [self.tasks setValue:task forKey:HSFileName(dic)];

    HSSessionModel *sessionModel = [[HSSessionModel alloc] init];
    sessionModel.url = url;
    sessionModel.progressBlock = progressBlock;
    sessionModel.stateBlock = stateBlock;
    sessionModel.stream = stream;
    sessionModel.dic = dic;
    [self.sessionModels setValue:sessionModel forKey:@(task.taskIdentifier).stringValue];
    
    [self start:dic];
}


- (void)handle:(NSDictionary *)dic
{
    NSURLSessionDataTask *task = [self getTask:dic];
    if (task.state == NSURLSessionTaskStateRunning) {
        [self pause:dic];
    } else {
        [self start:dic];
    }
}

/**
 *  开始下载
 */
- (void)start:(NSDictionary *)dic
{
    NSURLSessionDataTask *task = [self getTask:dic];
    [task resume];

    [self getSessionModel:task.taskIdentifier].stateBlock(DownloadStateStart);
}

/**
 *  暂停下载
 */
- (void)pause:(NSDictionary *)dic
{
    NSURLSessionDataTask *task = [self getTask:dic];
    [task suspend];

    [self getSessionModel:task.taskIdentifier].stateBlock(DownloadStateSuspended);
}

/**
 *  根据url获得对应的下载任务
 */
- (NSURLSessionDataTask *)getTask:(NSDictionary *)dic
{
    return (NSURLSessionDataTask *)[self.tasks valueForKey:HSFileName(dic)];
}

/**
 *  根据url获取对应的下载信息模型
 */
- (HSSessionModel *)getSessionModel:(NSUInteger)taskIdentifier
{
    return (HSSessionModel *)[self.sessionModels valueForKey:@(taskIdentifier).stringValue];
}

/**
 *  判断该文件是否下载完成
 */
- (BOOL)isCompletion:(NSDictionary *)dic
{
    if ([self fileTotalLength:dic] && HSDownloadLength(dic) == [self fileTotalLength:dic]) {
        return YES;
    }
    return NO;
}

/**
 *  查询该资源的下载进度值
 */
- (CGFloat)progress:(NSDictionary *)dic
{
    return [self fileTotalLength:dic] == 0 ? 0.0 : 1.0 * HSDownloadLength(dic) /  [self fileTotalLength:dic];
}

/**
 *  获取该资源总大小
 */
- (NSInteger)fileTotalLength:(NSDictionary *)dic
{
    DDLog(@"HSTotalLengthFullpath=======%@",HSTotalLengthFullpath);
    return [[NSDictionary dictionaryWithContentsOfFile:HSTotalLengthFullpath][HSFileName(dic)] integerValue];
}

#pragma mark - 删除
/**
 *  删除该资源
 */
- (void)deleteFile:(NSDictionary *)dic
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:HSFileFullpath(dic)]) {

        // 删除沙盒中的资源
        [fileManager removeItemAtPath:HSFileFullpath(dic) error:nil];
        // 删除任务
        [self.tasks removeObjectForKey:HSFileName(dic)];
        [self.sessionModels removeObjectForKey:@([self getTask:dic].taskIdentifier).stringValue];
        // 删除资源总长度
        if ([fileManager fileExistsAtPath:HSTotalLengthFullpath]) {
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:HSTotalLengthFullpath];
            [dict removeObjectForKey:HSFileName(dic)];
            [dict writeToFile:HSTotalLengthFullpath atomically:YES];
        
        }
    }
}

/**
 *  清空所有下载资源
 */
- (void)deleteAllFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:HSCachesDirectory]) {
        // 删除沙盒中所有资源
        [fileManager removeItemAtPath:HSCachesDirectory error:nil];
        // 删除任务
        [[self.tasks allValues] makeObjectsPerformSelector:@selector(cancel)];
        [self.tasks removeAllObjects];
        
        for (HSSessionModel *sessionModel in [self.sessionModels allValues]) {
            [sessionModel.stream close];
        }
        [self.sessionModels removeAllObjects];
        
        // 删除资源总长度
        if ([fileManager fileExistsAtPath:HSTotalLengthFullpath]) {
            [fileManager removeItemAtPath:HSTotalLengthFullpath error:nil];
        }
    }
}

#pragma mark - 代理
#pragma mark NSURLSessionDataDelegate
/**
 * 接收到响应
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    
    HSSessionModel *sessionModel = [self getSessionModel:dataTask.taskIdentifier];
    
    // 打开流
    [sessionModel.stream open];
    
    // 获得服务器这次请求 返回数据的总长度
    NSInteger totalLength = [response.allHeaderFields[@"Content-Length"] integerValue] + HSDownloadLength(sessionModel.dic);
    sessionModel.totalLength = totalLength;
    
    // 存储总长度
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:HSTotalLengthFullpath];
    if (dict == nil) dict = [NSMutableDictionary dictionary];
    dict[HSFileName(sessionModel.dic)] = @(totalLength);
    [dict writeToFile:HSTotalLengthFullpath atomically:YES];
    
    // 接收这个请求，允许接收服务器的数据
    completionHandler(NSURLSessionResponseAllow);
}

/**
 * 接收到服务器返回的数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    HSSessionModel *sessionModel = [self getSessionModel:dataTask.taskIdentifier];
    
    // 写入数据
    [sessionModel.stream write:data.bytes maxLength:data.length];
    
    // 下载进度
    NSUInteger receivedSize = HSDownloadLength(sessionModel.dic);
    NSUInteger expectedSize = sessionModel.totalLength;
    CGFloat progress = 1.0 * receivedSize / expectedSize;

    sessionModel.progressBlock(receivedSize, expectedSize, progress);
}

/**
 * 请求完毕（成功|失败）
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    HSSessionModel *sessionModel = [self getSessionModel:task.taskIdentifier];
    if (!sessionModel) return;
    
    if ([self isCompletion:sessionModel.dic]) {
        // 下载完成
        sessionModel.stateBlock(DownloadStateCompleted);
    } else if (error){
        // 下载失败
        sessionModel.stateBlock(DownloadStateFailed);
    }
    if ( sessionModel.totalLength <2000) {
        // 下载失败
        sessionModel.stateBlock(DownloadStateFailed);
    }
    // 关闭流
    [sessionModel.stream close];
    sessionModel.stream = nil;
    
    // 清除任务
    [self.tasks removeObjectForKey:HSFileName(sessionModel.dic)];
    [self.sessionModels removeObjectForKey:@(task.taskIdentifier).stringValue];
}

@end
