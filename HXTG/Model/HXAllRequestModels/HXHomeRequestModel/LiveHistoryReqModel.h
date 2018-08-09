//
//  LiveHistoryReqModel.h
//  HXTG
//  直播解盘
//  Created by grx on 2017/4/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseRequestModel.h"

@interface LiveHistoryReqModel : HXBaseRequestModel

/*! id */
@property (strong, nonatomic) NSString *post_id;
/*! 军团Id */
@property (strong, nonatomic) NSString *legion_id;

/*! 页数 */
@property (nonatomic, strong) NSString *pagenum;

@end
