//
//  HXTgRefeModel.h
//  HXTG
//  投顾内参
//  Created by grx on 2017/3/30.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXTgRefeModel : NSObject

/** 投顾内参id */
@property (nonatomic ,strong) NSString *post_id;
/*! 投顾内参日期 */
@property (nonatomic ,strong) NSString *post_date;
/** 投顾内参标题 */
@property (nonatomic ,strong) NSString *post_title;
/*! 总页数 */
@property (nonatomic ,strong) NSString *PageCount;
/*! 当前页数 */
@property (nonatomic ,strong) NSString *pagenum;
/*! 类型名称 */
@property (nonatomic ,strong) NSString *name;

@end
