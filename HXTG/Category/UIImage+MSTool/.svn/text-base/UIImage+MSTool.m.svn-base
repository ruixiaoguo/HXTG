//
//  UIImage+MSTool.m
//  HXTG
//
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "UIImage+MSTool.h"

@implementation UIImage (MSTool)

//生成一个带圆环的圆形图片
+ (UIImage *)imageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    //圆环宽度
    CGFloat borderW = borderWidth;
    //加载原始图片
    UIImage *originImage = [UIImage imageNamed:name];
    //新的图片的尺寸
    CGFloat imageW = originImage.size.width+2*borderW;
    CGFloat imageH = originImage.size.height+2*borderW;
    //设置新的图片的尺寸
    CGFloat circleW = imageW>imageH?imageH:imageW;
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleW, circleW), NO, 0.0);
    //画圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circleW, circleW)];
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //设置渲染颜色
    [borderColor setFill];
    
    //渲染
    CGContextFillPath(ctx);
    
    CGFloat clipW = originImage.size.width;
    CGFloat clipH = originImage.size.height;
    CGFloat clipCircleW = clipW>clipH?clipH:clipW;
    
    CGRect clipR = CGRectMake(borderW, borderW,clipCircleW, clipCircleW);
    //画圆
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipR];
    //设置裁剪区域
    [clipPath addClip];
    //画图
    [originImage drawAtPoint:CGPointMake(borderW, borderW)];
    //获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

//截屏方法
+ (instancetype)imageWithCaptureView:(UIView *)view
{
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0f);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //渲染控制器的view的图层到上下文
    //图层只能用render（渲染） 不能用draw（画）
    [view.layer renderInContext:ctx];
    
    //获取截屏图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}


@end
