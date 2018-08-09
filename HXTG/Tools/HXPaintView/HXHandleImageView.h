//
//  HXHandleImageView.h
//  HXTG
//
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXHandleImageView;
@protocol HXHandleImageViewDelegate <NSObject>

@optional;

-(void)handleImageView:(HXHandleImageView *)handleImageView didCaptureImage:(UIImage *)image;

@end

@interface HXHandleImageView : UIView

@property (nonatomic, strong)UIImage *image;
@property (nonatomic, weak) id delegate;

@end
