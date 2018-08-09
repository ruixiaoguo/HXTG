//
//  HXStockDetailController.h
//  HXTG
//
//  Created by grx on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseViewController.h"
#import "HXStockPoolModel.h"

@interface HXStockDetailController : HXBaseViewController

@property (strong, nonatomic) HXStockPoolModel *model;
@property (strong, nonatomic) void (^refreshMyFollow)();
@property (strong, nonatomic) NSString *poolTitle;

@end
