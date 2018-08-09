//
//  HXMyFollowModel.h
//  HXTG
//  我的关注
//  Created by grx on 2017/3/31.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXMyFollowModel : NSObject

/** 股票id */
@property (nonatomic ,strong) NSString *stock_id;
/*! 股票标题 */
@property (nonatomic ,strong) NSString *stock_title;
/** 股票名称 */
@property (nonatomic ,strong) NSString *stock_name;
/** 股票代码 */
@property (nonatomic ,strong) NSString *stock_code;
/** 股票添加时间 */
@property (nonatomic ,strong) NSString *stock_addtime;
/** 股票池风格（短线，中线，长线） */
@property (nonatomic ,strong) NSString *stock_type;
/** 评级 */
@property (nonatomic ,strong) NSString *stock_opert_state;
/** 是否关注*/
@property (nonatomic ,strong) NSString *isconcern;
/** 总页数 */
@property (nonatomic ,strong) NSString *PageCount;
/** 当前页数 */
@property (nonatomic ,strong) NSString *pagenum;

@end
