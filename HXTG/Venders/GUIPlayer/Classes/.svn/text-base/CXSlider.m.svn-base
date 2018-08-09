//
//  CXSlider.m
//  CXCollege
//
//  Created by ios on 16/3/1.
//  Copyright © 2016年 北京畅想未来科技有限公司 网址：http://cxwlbj.com. All rights reserved.
//

#define kThumbSize  10

#import "CXSlider.h"

@implementation CXSlider

- (id)init
{
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews
{
    _value = 0.0f;
    _minimumValue = 0.0f;
    _maximumValue = 1.0f;
    _continuous = YES;
    
    _minView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _minView.contentMode = UIViewContentModeScaleToFill;
    _minView.backgroundColor = [UIColor blueColor];
    
    _maxView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _maxView.contentMode = UIViewContentModeScaleToFill;
    _maxView.backgroundColor = [UIColor lightTextColor];
    
    _thumbView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _thumbView.backgroundColor = [UIColor clearColor];
    
    
    
    UIImage *minImg = [UIImage imageNamed:@"progress_red_bar"];
    minImg = [minImg resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 2, 2)];
    UIImage *maxImg = [UIImage imageNamed:@"line"];
    maxImg = [maxImg resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0, 0, 0)];
    
    [self setMinimumImage:minImg];
    [self setMaximumImage:maxImg];
    [self setThumbImage:[UIImage imageNamed:@"pointRed"]];
    
    
    [self addSubview:_minView];
    [self addSubview:_maxView];
    [self addSubview:_thumbView];
}

-(void)setMinimumImage:(UIImage *)minimumImage
{
    if (_minimumImage != minimumImage) {
        
        
        _minView.backgroundColor = [UIColor clearColor];
        _minView.image = minimumImage;
    }
}

-(void)setMaximumImage:(UIImage *)maximumImage
{
    if (_maximumImage != maximumImage) {
        
        
        _maxView.backgroundColor = [UIColor clearColor];
        _maxView.image = maximumImage;
    }
}

-(void)setThumbImage:(UIImage *)thumbImage
{
    if (_thumbImage != thumbImage) {
        
        _thumbView.backgroundColor = [UIColor clearColor];
        _thumbView.image = thumbImage;
    }
}

-(void)setMinimumValue:(float)minimumValue {
    _minimumValue = MIN(1.0,MAX(0,minimumValue));
}

-(void)setMaximumValue:(float)maximumValue {
    _maximumValue = MIN(1.0,MAX(0,maximumValue));
}

-(void)setValue:(float)value
{
    _value = MIN(MAX(_minimumValue, value), _maximumValue);
    
    [self setNeedsLayout];
}

-(void)resetValueWithTouchPoint:(CGPoint)touchPoint
{
    int startX = _thumbImage.size.width/2;
    int totalLen = self.bounds.size.width-_thumbImage.size.width;
    
    if (touchPoint.x < startX) {
        touchPoint.x = startX;
    }
    if (touchPoint.x > self.bounds.size.width-startX) {
        touchPoint.x = self.bounds.size.width-startX;
    }
    
    self.value = (touchPoint.x-startX)/totalLen;
}

#pragma mark
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int startX = _thumbImage.size.width/2;
    int startY = (self.bounds.size.height-4)/2;
    int totalLen = self.bounds.size.width-_thumbImage.size.width;
    
    _minView.frame = CGRectMake(startX, startY, totalLen*_value, 4.5);
    _maxView.frame = CGRectMake(startX+totalLen*_value, startY, totalLen-totalLen*_value, 4);
    
    _thumbView.frame = CGRectMake(0, 0, kThumbSize, kThumbSize);
    _thumbView.center = CGPointMake(startX+totalLen * _value, self.bounds.size.height/2);
}

#pragma mark Touch tracking

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint firstTouch = [touch locationInView:self];
    
    if ( CGRectContainsPoint(_thumbView.frame, firstTouch))  {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    [self resetValueWithTouchPoint:touchPoint];
    
    if (_continuous) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    [self resetValueWithTouchPoint:touchPoint];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end
