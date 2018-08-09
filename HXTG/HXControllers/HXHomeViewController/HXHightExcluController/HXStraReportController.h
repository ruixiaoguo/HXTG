//
//  HXStraReportcController.h
//  HXTG
//  策略报告
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseViewController.h"
#import "HXStraReportModel.h"

@interface HXStraReportController : HXBaseViewController

@property (strong, nonatomic) void (^straReportClick)(HXStraReportModel *model);

@end
