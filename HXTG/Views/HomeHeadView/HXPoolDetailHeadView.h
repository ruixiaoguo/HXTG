//
//  HXPoolDetailHeadView.h
//  HXTG
//
//  Created by grx on 2017/3/27.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXStockPoolModel.h"

@interface HXPoolDetailTopView : UIView

@property (strong, nonatomic) UILabel *stockTitle;
@property (strong, nonatomic) UILabel *sealTitle;
@property (strong, nonatomic) UILabel *discrTitle;
@property (strong, nonatomic) UILabel *followTitle;
@property (strong, nonatomic) UIImageView *followImg;
@property (strong, nonatomic) void(^followClickBlock)();/*! 关注 */

@property (strong, nonatomic) HXStockPoolModel *stockModel;
@property (strong, nonatomic) NSString *stock_oper_desc;

@end

@interface HXPoolDetailHeadView : UIView

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UILabel *contentLable;

@property (assign, nonatomic) CGFloat headViewHight;

@end


