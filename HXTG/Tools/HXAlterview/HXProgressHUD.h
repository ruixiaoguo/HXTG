/*****************************************************************
 文件名称：NetworkTools.h
 作   者：陈阳阳
 备   注：网络工具单例类
 创建时间：2015-09-21
 版权声明：Copyright (c) 2015 陈阳阳. All rights reserved.
 *****************************************************************/

#import "AFHTTPSessionManager.h"
#import "MBProgressHUD.h"

@interface HXProgressHUD : AFHTTPSessionManager

+ (instancetype)sharedManager;

+ (void)showMessage:(UIView *)view labelText:(NSString *)text mode:(MBProgressHUDMode)mode;

@end
