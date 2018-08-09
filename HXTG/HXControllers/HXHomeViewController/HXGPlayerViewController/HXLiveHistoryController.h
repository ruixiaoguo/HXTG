//
//  HXLiveHistoryController.h
//  HXTG
//
//  Created by grx on 2017/4/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseViewController.h"
#import "HXLiveHistoryModel.h"

@interface HXLiveHistoryController : HXBaseViewController

@property (strong, nonatomic) void (^liveHistoryClick)(HXLiveHistoryModel *model);

@end
