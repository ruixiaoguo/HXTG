//
//  HXOperatePlanCell.h
//  HXTG
//  操盘计划
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTraderPlanModel.h"

@interface HXOperatePlanCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) HXTraderPlanModel *model;


@end
