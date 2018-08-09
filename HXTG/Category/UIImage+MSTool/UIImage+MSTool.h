//
//  UIImage+MSTool.h
//  HXTG
//  屏幕截图
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MSTool)

/**
 *  生成一个带圆环的圆形图片
 *
 *  @param name        原始图片名称
 *  @param borderWidth 圆环的宽度
 *  @param borderColor 圆环的颜色
 *
 *  @return 一个带圆环的圆形图片
 */
+ (instancetype)imageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;

/**
 *  截屏方法
 *
 *  @param view 被截屏的视图
 *
 *  @return 截屏图片
 */
+ (instancetype)imageWithCaptureView:(UIView *)view;

@end
