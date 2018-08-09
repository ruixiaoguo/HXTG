//
//  HXHomeHeadView.h
//  HXTG
//  首页头部视图
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXAdboardView.h"
#import "HXStockView.h"
#import "HXColumnView.h"
#import "HXStrateView.h"

@interface HomeHeadView : UIView

@property (strong, nonatomic) void(^tapHXAdboardView)(AdboardModel *model);   /*! 广告位 */
@property (strong, nonatomic) void (^bjHeadColumClick)(NSInteger headColumTag);
@property (strong, nonatomic) void (^cqHeadColumClick)(NSInteger headColumTag);

@property (strong, nonatomic) void(^everStockClickBlock)(HXDailystockModel *stockModel);/*! 每日一股 */
@property (strong, nonatomic) void(^strateClickBlock)();/*! 炒股攻略 */

@property (strong, nonatomic) HXAdboardView *adboardView;
@property (strong, nonatomic) HXStockView *stockView;
@property (strong, nonatomic) HXColumnView * columnView;
@property (strong, nonatomic) HXColumnView * CqcolumnView;

@property (strong, nonatomic) HXStrateView *strateView;


@property (assign, nonatomic) CGFloat ClumnHight;

@property (assign, nonatomic) CGFloat CQlumnHight;

@property (strong, nonatomic) NSString *ischeck;

@end
