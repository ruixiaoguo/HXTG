//
//  HXTrainingCourseModel.h
//  HXTG
//  培训课程
//  Created by grx on 2017/4/1.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXTrainingCourseModel : NSObject

/** 培训课程id */
@property (nonatomic ,strong) NSString *post_id;
/*! 培训课程日期 */
@property (nonatomic ,strong) NSString *post_date;
/** 培训课程标题 */
@property (nonatomic ,strong) NSString *post_title;

@end
