/*****************************************************************
 文件名称：NetworkTools.m
 作   者：陈阳阳
 备   注：网络工具单例类
 创建时间：2015-09-21
 版权声明：Copyright (c) 2015 陈阳阳. All rights reserved.
 *****************************************************************/

#import "HXProgressHUD.h"
#import "MBProgressHUD.h"

@implementation HXProgressHUD

+ (instancetype)sharedManager{
    static HXProgressHUD *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:HXBASEURL];
        instance = [[self alloc]initWithBaseURL:baseURL];
    });
    instance.responseSerializer = [AFHTTPResponseSerializer serializer];
    return instance;
}

+ (void)showMessage:(UIView *)view labelText:(NSString *)text mode:(MBProgressHUDMode)mode{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:view];
    [view addSubview:hud];
    hud.labelText = text;
    hud.mode = mode;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
    
}

@end
