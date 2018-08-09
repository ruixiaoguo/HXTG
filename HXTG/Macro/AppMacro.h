//
//  AppMacro.h
//  HXTG
//
//  Created by grx on 2017/2/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

/*! 系统控件 */
#define kStatusBarHeight        (20.f)
#define kNavigationBarHeight    (44.f)
#define kTabBarHeight           (49.f)
#define navBarHeight           (64.f)
#define VIEW_OFFSET             ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0f?20.0f:0.0f)
#define NAV_OFFSET             ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0f?20.0f:10.0f)

/*! app尺寸 */
#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width  [[UIScreen mainScreen] bounds].size.width

/*! 颜色 */
#define ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ColorWithRGB(r,g,b) ColorWithRGBA(r,g,b,1)
#define ColorWithHexRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#define ColorWithHexRGB(rgbValue) ColorWithHexRGBA(rgbValue,1.0)
/*! 使用十六进制色值 0xC8C8C8 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorWhite [UIColor whiteColor]
#define UIColorClear [UIColor clearColor]
/*! ===========================================全局颜色============================================== */
/*! 全局黑字体颜色 */
#define UIColorBlackTheme ColorWithHexRGB(0x333333)
/*! 全局灰字体颜色 */
#define UIColorLightTheme ColorWithHexRGB(0x999999)

/*! 全局背景灰颜色 */
#define UIColorBgLightTheme ColorWithHexRGB(0xededed)
/*! 全局背景白颜色 */
#define UIColorBgWhiteTheme ColorWithHexRGB(0xffffff)
/*! 全局分割线颜色 */
#define UIColorLineTheme ColorWithHexRGB(0xcacaca)
/*! 列表点击颜色 */
#define UIColorCellSelectTheme ColorWithHexRGB(0xf2f2f2)

/*! 全局红字体颜色 */
#define UIColorRedTheme ColorWithHexRGB(0xef3540)
/*! 全局高亮红字体颜色 */
#define UIColorHigRedTheme ColorWithHexRGB(0xf14953)

/*! 全局辅助蓝色颜色 */
#define UIColorBlueTheme ColorWithHexRGB(0x2f89ff)
/*! ===========================================全局字体============================================== */
/*! 字体 */
#define UIFontSystem(x)     [UIFont systemFontOfSize:x]
#define UIFontBoldSystem(x) [UIFont boldSystemFontOfSize:x]
#define UIFontSystem11     [UIFont systemFontOfSize:11]
#define UIFontSystem12     [UIFont systemFontOfSize:12]
#define UIFontSystem13     [UIFont systemFontOfSize:13]
#define UIFontSystem14     [UIFont systemFontOfSize:14]
#define UIFontSystem15     [UIFont systemFontOfSize:15]
#define UIFontSystem16     [UIFont systemFontOfSize:16]
#define UIFontSystem18     [UIFont systemFontOfSize:18]


/*! 其他 */
//#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#ifndef __OPTIMIZE__
#define DDLog(...) NSLog(__VA_ARGS__)
#else
#define DDLog(...) {}
#endif

#define WeakSelf(x) __weak typeof(self) x = self
#define StandardUserDefaults [NSUserDefaults standardUserDefaults]

#endif /* AppMacro_h */
