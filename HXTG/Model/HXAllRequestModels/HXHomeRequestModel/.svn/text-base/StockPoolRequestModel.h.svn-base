//
//  StockPoolRequestModel.h
//  HXTG
//  股票池列表/详情
//  Created by grx on 2017/4/5.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseRequestModel.h"

@interface StockPoolRequestModel : HXBaseRequestModel

/*! 股票Id */
@property (strong, nonatomic) NSString *stock_id;

/*! 页数 */
@property (nonatomic, strong) NSString *pagenum;

/*! 股池风格（默认1）：1全部2短线3中线4长线 */
@property (nonatomic, strong) NSString *stock_style;

@end


#pragma mark - 关注
@interface StockFollowRequestModel : HXBaseRequestModel

/*! 操作类型1关注2取消关注 */
@property (strong, nonatomic) NSString *type;
/*! 股票id */
@property (nonatomic, strong) NSString *stock_id;

@end
