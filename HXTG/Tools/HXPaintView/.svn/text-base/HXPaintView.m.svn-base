//
//  HXPaintView.m
//  HXTG
//
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXPaintView.h"
#import "HXpaintPath.h"

@interface HXPaintView (){
    HXpaintPath *_path;
}
@property (nonatomic, strong)NSMutableArray *paths;

@end

@implementation HXPaintView

#pragma mark - 懒加载方法
-(NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}


#pragma mark - 重写方法
-(void)setImage:(UIImage *)image
{
    _image = image;
    
    //将图片加到数组paths中
    [self.paths addObject:image];
    
    //重绘
    [self setNeedsDisplay];
    
}

#pragma mark - 自定义方法
//获取触摸点
-(CGPoint)getPointOfTouches:(NSSet*)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    return point;
}
//撤销
-(void)undo
{
    //移除最后一个路径
    [self.paths removeLastObject];
    //重绘
    [self setNeedsDisplay];
}
//清屏
-(void)clearScreen
{
    //清空所有路径
    [self.paths removeAllObjects];
    //重绘
    [self setNeedsDisplay];
}


#pragma mark - 重写父类的方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取起始点
    CGPoint startPoint = [self getPointOfTouches:touches];
    
    //创建一个路径
    _path = [HXpaintPath bezierPath];
    //设置路径的线宽
    _path.lineWidth = self.lineWidth;
    //设置线的颜色
    _path.lineColor = self.lineColor;
    
    [_path moveToPoint:startPoint];
    
    //将新建的path添加到可变数组paths中
    [self.paths addObject:_path];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取移动点
    CGPoint movePoint = [self getPointOfTouches:touches];
    
    [_path addLineToPoint:movePoint];
    
    //重绘
    [self setNeedsDisplay];
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.lineWidth = 1.0f;
}

//当自己第一次显示的时候默认调用 或者手动调用［self setNeedsDisplay］时调用 用来重绘自己
- (void)drawRect:(CGRect)rect {
    //如果路径数组中无内容 则直接return
    if (!self.paths.count) return;
    
    for (HXpaintPath *path in self.paths) {
        
        //取出paths数组中的image 然后画图
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawAtPoint:CGPointZero];
        }else{
            //设置上下文的颜色
            [path.lineColor setStroke];
            [path setLineCapStyle:kCGLineCapRound];
            //画线
            [path stroke];
        }
        
    }
    
}

@end
