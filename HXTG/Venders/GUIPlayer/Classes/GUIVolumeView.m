//
//  VolumeView.m
//  CXCollege
//
//  Created by ios on 16/3/2.
//  Copyright © 2016年 北京畅想未来科技有限公司 网址：http://cxwlbj.com. All rights reserved.
//

#import "GUIVolumeView.h"

@interface GUIVolumeView ()
{
    // 遮罩视图
    UIImageView * _shadeView;
    
    // 喇叭视图
    UIImageView * _imageView;
}

@end

@implementation GUIVolumeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _initGUIViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initGUIViews];
    }
    return self;
}

- (void)_initGUIViews
{
//    self.backgroundColor = [UIColor blackColor];
//    self.layer.cornerRadius = 10;
//    self.alpha = 0.7;
//    
//    
//    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
//    titleLabel.text = @"音量";
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.textColor = [UIColor whiteColor];
//    [self addSubview:titleLabel];
//    
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((150 - 75) / 2, titleLabel.bottom + 10, 75, 65)];
//    _imageView.image = [UIImage imageNamed:@"volume.png"];
//    [self addSubview:_imageView];
//    
//    UIImageView * volumeBgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, _imageView.bottom + 10, 130, 7)];
//    volumeBgView.image = [UIImage imageNamed:@"volumeProgressBg.png"];
//    [self addSubview:volumeBgView];
//    
//    UIImageView * volumeProgressView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 128, 5)];
//    volumeProgressView.image = [UIImage imageNamed:@"volumeProgress.png"];
//    [volumeBgView addSubview:volumeProgressView];
//    
//    // 遮罩视图
//    _shadeView = [[UIImageView alloc] initWithFrame:CGRectMake(10, _imageView.bottom + 10, 130, 7)];
//    _shadeView.image = [UIImage imageNamed:@"volumeProgressBg.png"];
//    [self addSubview:_shadeView];
}

- (void)setValue:(float)value
{
    _value = value;
//    NSLog(@"qwesdzxcasda:%f",130 * (1 - value));
    _shadeView.width = 130 * (1 - value);
    _shadeView.right = 140;
}

@end
