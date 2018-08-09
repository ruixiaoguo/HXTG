//
//  HXHandleImageView.m
//  HXTG
//
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXHandleImageView.h"
#import "UIImage+MSTool.h"

@interface HXHandleImageView ()<UIGestureRecognizerDelegate,HXHandleImageViewDelegate>

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation HXHandleImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        /*! 子视图超出父视图的时候被裁剪 */
        self.clipsToBounds = YES;
        
        [self addPinchGesture];
        [self addRotationGesture];
        [self addPanGesture];
        [self addLongPressGesture];
    }
    
    return self;
}

#pragma mark - 懒加载方法

-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        _imageView.userInteractionEnabled = YES;
        
        
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
    
}

#pragma mark - 自定义方法
#pragma mark - 长按手势
-(void)addLongPressGesture
{
    //创建一个长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    
    longPressGesture.delegate = self;
    //添加手势
    [self.imageView addGestureRecognizer:longPressGesture];
    
    
}

-(void)longPress:(UILongPressGestureRecognizer *)longPressGesture
{
    if (longPressGesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.imageView.alpha = 0.5;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2
                                              animations:^{
                                                  self.imageView.alpha = 1.0f;
                                              }
                                              completion:^(BOOL finished) {
                                                  //1.截屏
                                                  UIImage *image = [UIImage imageWithCaptureView:self];
                                                  //2.如果代理执行handleImageView:didCaptureImage:方法 将图片传过去 然后画图
                                                  if ([self.delegate respondsToSelector:@selector(handleImageView:didCaptureImage:)]) {
                                                      [self.delegate handleImageView:self didCaptureImage:image];
                                                  }
                                                  
                                                  //3.把自己移除
                                                  [self removeFromSuperview];
                                                  
                                                  
                                              }];
                         }];
        
    }
    
}


#pragma mark - 拖拽手势
-(void)addPanGesture
{
    //创建一个拖拽手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    panGesture.delegate = self;
    
    //添加手势
    [self.imageView addGestureRecognizer:panGesture];
}

-(void)pan:(UIPanGestureRecognizer *)panGesture
{
    CGPoint point = [panGesture translationInView:self.imageView];
    //拖拽
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, point.x, point.y);
    
    //复位
    
    [panGesture setTranslation:CGPointZero inView:self.imageView];
}

#pragma mark - 旋转手势
-(void)addRotationGesture
{
    //创建一个旋转手势
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    
    rotationGesture.delegate = self;
    //添加手势
    [self.imageView addGestureRecognizer:rotationGesture];
    
}

-(void)rotation:(UIRotationGestureRecognizer *)rotationGesture
{
    //旋转
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotationGesture.rotation);
    
    //复位
    rotationGesture.rotation = 0.0f;
}

#pragma mark - 捏合手势
-(void)addPinchGesture
{
    //创建一个捏合手势
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    
    pinchGesture.delegate = self;
    //添加手势
    [self.imageView addGestureRecognizer:pinchGesture];
    
}

-(void)pinch:(UIPinchGestureRecognizer *)pinchGesture
{
    //缩放
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinchGesture.scale, pinchGesture.scale);
    
    //复位
    pinchGesture.scale = 1.0f;
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
    
}

@end
