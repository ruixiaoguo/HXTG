//
//  HXStockPoolHeadView.h
//  HXTG
//  股票池头视图
//  Created by grx on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXStockPoolHeadView : UIView

@property (strong, nonatomic) void (^styleSelectAction)(NSInteger segmentIndex);

@end
