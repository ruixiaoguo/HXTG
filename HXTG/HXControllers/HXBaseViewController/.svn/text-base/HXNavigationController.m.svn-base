//
//  HXNavigationController.m
//  HXTG
//
//  Created by grx on 2017/2/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXNavigationController.h"
#import "HXNavigationBar.h"

@interface HXNavigationController ()

@end

@implementation HXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*! 去掉导航栏半透明效果自定义navbar */
- (id)init {
    self = [super initWithNavigationBarClass:[HXNavigationBar class] toolbarClass:nil];
    if(self) {
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithNavigationBarClass:[HXNavigationBar class] toolbarClass:nil];
    if(self) {
        self.viewControllers = @[rootViewController];
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
