//
//  StockInfoRequestModel.h
//  HXTG
//  每日一股详情
//  Created by grx on 2017/3/29.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseRequestModel.h"

@interface StockInfoRequestModel : HXBaseRequestModel

/*! 每日详情ID */
@property (nonatomic, strong) NSString *shares_id;

@end
