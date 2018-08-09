//
//  HXOperatePlanViewController.h
//  HXTG
//  操盘计划
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseViewController.h"
#import "HXTraderPlanModel.h"

@interface HXOperatePlanController : HXBaseViewController

@property (strong, nonatomic) void (^operateClick)(HXTraderPlanModel *model);
@property (nonatomic,strong) UITableView *planTableView;
-(void)gaintThePlanList:(BOOL)isLoadMore;

@end
