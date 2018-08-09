//
//  FindHeadView.h
//  HXTG
//
//  Created by grx on 2017/3/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindHeadView : UIView

@property (strong, nonatomic) void (^bgViewClickTapClickBlock)(NSInteger tag);

@end
