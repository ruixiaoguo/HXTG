//
//  EarlyRequestModel.h
//  HXTG
//  往日早盘/详情
//  Created by grx on 2017/3/30.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseRequestModel.h"

@interface EarlyRequestModel : HXBaseRequestModel

/*! id */
@property (strong, nonatomic) NSString *post_id;

/*! 页数 */
@property (nonatomic, strong) NSString *pagenum;

@end
