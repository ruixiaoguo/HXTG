//
//  HXPoolDetailModel.h
//  HXTG
//  股票池详情
//  Created by grx on 2017/3/27.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXPoolDetailModel : NSObject

/** 接收时间 */
@property (nonatomic ,strong) NSString *hour;
/*! 日期 */
@property (nonatomic ,strong) NSString *day;
/** 操作建议 */
@property (nonatomic ,strong) NSString *stock_oper_desc;
/** 介绍 */
@property (nonatomic ,strong) NSString *stock_main_desc;
/** 股票代码 */
@property (nonatomic ,strong) NSString *stock_code;
/** 股票名称 */
@property (nonatomic ,strong) NSString *stock_name;
/** 操作状态 */
@property (nonatomic ,strong) NSString *stock_opert_state;
/** 总页数 */
@property (nonatomic ,strong) NSString *PageCount;
/** 当前页数 */
@property (nonatomic ,strong) NSString *pagenum;


/*! 买入价 */
@property (strong, nonatomic) NSString *bid_price;
/*! 止损价 */
@property (strong, nonatomic) NSString *stop_price;
/*! 止盈价 */
@property (strong, nonatomic) NSString *surplus_price;
/*! 卖出价 */
@property (strong, nonatomic) NSString *selling_price;
/*! 仓位占比 */
@property (strong, nonatomic) NSString *position_ratio;
/*! 是否关注0未关注1已关注 */
@property (strong, nonatomic) NSString *isconcern;

@end
