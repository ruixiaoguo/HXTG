//
//  HXNetClient.h
//  HXTG
//
//  Created by grx on 2017/2/15.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HXNetClient : AFHTTPSessionManager

/*! 定义返回请求数据的block类型 */
typedef void (^HXReturnValueBlock)(NSURLSessionDataTask *task, NSDictionary *responseDict);
typedef void (^HXErroeBlock)(NSURLSessionDataTask *task, NSError* error);
typedef void (^HXFailureBlock)();
typedef void (^HXNetWorkStatusBlock)(AFNetworkReachabilityStatus status);

/*! 初始化 */
+ (HXNetClient *)sharedInstance;

/*! 监测网络的可链接性 */
- (void)netWorkReachabilityWithReturnNetWorkStatusBlock:(HXNetWorkStatusBlock)block;

/*! GET请求 */
- (void)NetRequestGETWithRequestURL: (NSString *) requestURLString
                      WithParameter: (NSDictionary *) parameter
               WithReturnValeuBlock: (HXReturnValueBlock) block
                   WithErrorBlock: (HXErroeBlock) errorBlock
                   WithFailureBlock: (HXFailureBlock) failureBlock;

/*! POST请求 */
- (void)NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (HXReturnValueBlock) block
                      WithErrorBlock: (HXErroeBlock) errorBlock
                    WithFailureBlock: (HXFailureBlock) failureBlock;

/*! POST上传单张图片 */
- (void) NetRequestPOSTIMGWithRequestURL: (NSString *) requestURLString
                           WithParameter: (NSDictionary *) parameter
                           WithUpLoadImg: (UIImage *) image
                    WithReturnValeuBlock: (HXReturnValueBlock) block
                          WithErrorBlock: (HXErroeBlock) errorBlock
                        WithFailureBlock: (HXFailureBlock) failureBlock;

/*! POST上传多张图片 */
- (void)  NetRequestPOSTMoreImgWithRequestURL: (NSString *) requestURLString
                                WithParameter: (NSDictionary *) parameter
                                WithUpLoadImg: (NSMutableArray *) imageArray
                         WithReturnValeuBlock: (HXReturnValueBlock) block
                               WithErrorBlock: (HXErroeBlock) errorBlock
                             WithFailureBlock: (HXFailureBlock) failureBlock;
@end
