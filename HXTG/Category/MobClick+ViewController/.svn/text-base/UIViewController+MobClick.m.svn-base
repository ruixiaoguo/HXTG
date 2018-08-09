//
//  UIViewController+MobClick.m
//  HXTG
//
//  Created by grx on 2017/5/2.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "UIViewController+MobClick.h"
#import "UMMobClick/MobClick.h"
#import "HXNavigationController.h"
#import "HXLoginController.h"

@implementation UIViewController (MobClick)

+ (void)load
{
    
    Method m1;
    Method m2;
    /*! 运行时替换方法 */
    m1 = class_getInstanceMethod(self, @selector(statisticsViewWillAppear:));
    m2 = class_getInstanceMethod(self, @selector(viewWillAppear:));
    
    method_exchangeImplementations(m1, m2);
    
    
    m1 = class_getInstanceMethod(self, @selector(statisticsViewWillDisappear:));
    m2 = class_getInstanceMethod(self, @selector(viewWillDisappear:));
    
    method_exchangeImplementations(m1, m2);
}


- (void) statisticsViewWillAppear:(BOOL)animated
{
    [self statisticsViewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    /*! 重复登录 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHome) name:@"NotiLoginOut" object:nil];
}

-(void) statisticsViewWillDisappear:(BOOL)animated
{
    [self statisticsViewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"NotiLoginOut" object:nil];
}

-(void)refreshHome
{
    if ([ISOutLogin isEqualToString:@"YES"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //执行事件
            if ([ISOutLogin isEqualToString:@"YES"])
            {
            HXLoginController *loginVC=[[HXLoginController alloc]init];
            HXNavigationController * loginNC = [[HXNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:loginNC animated:YES completion:nil];
            [StandardUserDefaults setObject:@"NO" forKey:@"isOutLogin"];
            }
        });
    }
}

@end
