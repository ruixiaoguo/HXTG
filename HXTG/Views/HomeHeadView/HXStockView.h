//
//  HXStockView.h
//  HXTG
//  每日一股
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXDailystockModel.h"

@interface HXStockView : UIView{
    UILabel *dateLable;
    UILabel *reasionContion;
    HXDailystockModel *model;
    UIView *stockView;
    UILabel *reasionLable;
}

@property (strong, nonatomic) void(^stockViewClickBlock)(HXDailystockModel *stockModel);/*! 每日一股 */
@property (strong, nonatomic) HXDailystockModel *stockModel;

@end
