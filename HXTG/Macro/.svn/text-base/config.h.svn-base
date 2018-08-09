//
//  config.h
//  HXTG
//
//  Created by grx on 2017/2/15.
//  Copyright © 2017年 grx. All rights reserved.
//

#ifndef config_h
#define config_h
#import "AFNetworking.h"
#import "IdentifierMacro.h"
#import "MBProgressHUD+MS.h"
#import "MBProgressHUD.h"
#import "UtilityFunction.h"
#import "HXNetBoxView.h"
#import "HXAlterview.h"
#import "HXLoadingView.h"
#import "HXProgressHUD.h"
#import "GlobalFile.h"
#import "HXNoDataView.h"
#import "HtmlNetUrlMacro.h"
#import "NotificationMacro.h"
#import "WZLBadgeImport.h"
#import "UIViewController+MobClick.h"

/** 定义返回请求数据的block类型 */
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(AFNetworkReachabilityStatus netConnetState);

#ifdef DEBUG
/*! 测试环境 */
//#define HXBASEURL  @"https://tougubang.com/AppApi/"
//#define HXBASEURL  @"http://192.168.1.59/AppApi/"
#define HXBASEURL  @"http://tgb.huaxuntouzi.com.cn/AppApi/"
//#define HXBASEURL  @"http://tgbtest.huaxuntouzi.com.cn/AppApi/"

//NSString *const HXHostURL = @"https://www.tgb.com/index.php/AppApi/user/";
#else
//#define HXBASEURL  @"http://192.168.1.59/AppApi/"
#define HXBASEURL  @"http://tgb.huaxuntouzi.com.cn/AppApi/"

#endif
/**
 *  极光推送开放平台
 */
/*! 正式环境 */
//#define JPushAppKey @"7984ee8714aecca95278b45a"
//#define JPushAppSecret @"fdbcdc559fab147862e2b0b3"
/*! 正式环境1.0版 */
#define JPushAppKey @"ef0de1ae5703d3131be08649"
#define JPushAppSecret @"85c45ae51150d7e79de2f135"
/*! 测试环境 */
//#define JPushAppKey @"e3f0b3eff86003410e676c74"
//#define JPushAppSecret @"b271f07934d8bfeb5c91acfd"
/**
 *  推送标示
 */
#define Push_marking @"http"

/*! 友盟统计 */
#define UMConfigAppKey @"58bf6f44f5ade428a10022be"

/**
 *  微信开放平台
 */
#define kWXChatAppKey @""
#define kWXChatAppSecret @""

/**
 *  融云开放平台
 */
/*! 开发环境 */
//#define RONGCLOUD_IM_APPKEY @"e0x9wycfeaj1q"
/*! 正式环境 */
#define RONGCLOUD_IM_APPKEY @"x18ywvqfxldec"

/*! 文件管理 */
#define DefaultFileManager [NSFileManager defaultManager]

/**
 *  UserDefaults
 */
#define userDefaults [NSUserDefaults standardUserDefaults]
/*! 视频缓存主目录 */
#define HSCachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HSCache"]
/*! 首页轮播图缓存目录 */
#define HMAd_CachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HMAdCache"]
/*! 首页每日一股缓存目录 */
#define HMStock_CachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HMStockCache"]


/*! 用户信息路径 */
#define HX_FILE_KEY                          @"HXDate"
#define USERINFO_KEY                         @"/UserDate"           /*! 用户信息 */

/*! 保存文件名 */
#define HSFileName(dic) [NSString stringWithFormat:@"%@.%@",dic[@"title"],[[dic[@"url"] componentsSeparatedByString:@"."] lastObject]]

/*! 文件的存放路径（caches） */
#define HSFileFullpath(dic) [HSCachesDirectory stringByAppendingPathComponent:HSFileName(dic)]

/*! 文件的已下载长度 */
#define HSDownloadLength(dic) [[[NSFileManager defaultManager] attributesOfItemAtPath:HSFileFullpath(dic) error:nil][NSFileSize] integerValue]

/*! 存储文件总长度的文件路径（caches） */
#define HSTotalLengthFullpath [HSCachesDirectory stringByAppendingPathComponent:@"totalLength.plist"]

#endif /* config_h */
