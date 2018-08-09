//
//  HXTabBarController.m
//  HXTG
//
//  Created by grx on 2017/2/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXTabBarController.h"
#import "HXBaseViewController.h"
#import "HXHomeViewController.h"
#import "HXFindViewController.h"
#import "HXMeViewController.h"
#import "HXNavigationController.h"
#import "TabBarButton.h"

@interface HXTabBarController (){
    TabBarButton *tabButton;
}

@property (nonatomic, strong) NSMutableArray *TabbarBtnArray;

@end

@implementation HXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TabbarBtnArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    NSArray *imageArr = [NSArray arrayWithObjects:@"tougu",@"faxian",@"wode",nil];
    NSArray *selectImageArr = [NSArray arrayWithObjects:@"tougu_sel",@"faxian_sel",@"wode_sel",nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"投顾",@"发现",@"我的",nil];

    NSArray *viewControllers = [NSArray arrayWithObjects:@"HXHomeViewController",@"HXFindViewController",@"HXMeViewController",nil];
    NSMutableArray *arr = [NSMutableArray array];
    /*! 分割线 */
    UIView *downLineViwe = [UIView new];
    downLineViwe.backgroundColor = UIColorBgLightTheme;
    [self.tabBar addSubview:downLineViwe];
    downLineViwe.sd_layout.leftSpaceToView(self.tabBar,0).rightSpaceToView(self.tabBar,0).topSpaceToView(self.tabBar,0).heightIs(1);
    /*! 自定义tabbar */
    for (NSInteger i = 0; i < viewControllers.count; i++)
    {
        HXBaseViewController *baseVC = [[NSClassFromString(viewControllers[i]) alloc] init];
        HXNavigationController *nav = [[HXNavigationController alloc] initWithRootViewController:baseVC];
        nav.tabBarItem.tag = i;
        [arr addObject:nav];
        
        tabButton = [[TabBarButton alloc]initWithFrame:CGRectMake(i * Main_Screen_Width/imageArr.count, 0, Main_Screen_Width/imageArr.count, kTabBarHeight)];
        [tabButton setShowsTouchWhenHighlighted:YES];
        tabButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [tabButton setImage:[UIImage imageNamed:[imageArr objectAtIndex:i]] forState:UIControlStateNormal];
        [tabButton setImage:[UIImage imageNamed:[selectImageArr objectAtIndex:i]] forState:UIControlStateSelected];
        tabButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [tabButton.titleLabel setFont:UIFontSystem(11)];
        tabButton.tag=i+10;
        [tabButton setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [tabButton setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
        [tabButton setTitleColor:UIColorRedTheme forState: UIControlStateSelected];
        if (i == 0)
        {
            [tabButton setSelected:YES];
        }
        [self.tabBar addSubview:tabButton];
        [self.TabbarBtnArray addObject:tabButton];

    }
    
    self.viewControllers = arr;
    self.selectedIndex = 0;
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
    
    self.tabBar.tintColor = [UIColor colorWithRed:55 / 255.0 green:196 / 255.0 blue:242 / 255.0 alpha:1];
    self.tabBar.barTintColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    self.tabBar.backgroundColor = [UIColor whiteColor];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
//    if (item.tag == 2 && ![[StandardUserDefaults objectForKey:ISLOGIN]boolValue] )
//    {
//        return;
//    }
    
    for (TabBarButton *button in self.TabbarBtnArray)
    {
        [button setSelected:NO];
    }
    self.selectedIndex = item.tag;
    TabBarButton *button = [self.TabbarBtnArray objectAtIndex:item.tag];
    [button setSelected:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
