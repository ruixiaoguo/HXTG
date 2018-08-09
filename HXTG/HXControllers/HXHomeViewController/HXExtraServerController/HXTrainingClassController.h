//
//  HXTrainingClassController.h
//  HXTG
//  培训课程
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseViewController.h"
#import "HXTrainingCourseModel.h"

@interface HXTrainingClassController : HXBaseViewController

@property (strong, nonatomic) void (^trainingClassClick)(HXTrainingCourseModel *model);
-(void)gaintTrainingCourseList:(BOOL)isLoadMore;

@end
