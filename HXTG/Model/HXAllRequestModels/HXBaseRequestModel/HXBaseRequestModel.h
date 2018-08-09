//
//  HXBaseRequestModel.h
//  HXTG
//
//  Created by grx on 2017/3/16.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBaseRequestModel : NSObject

///*! 平台来源 */
//@property (nonatomic, strong) NSString *from;
///*! 版本号 */
//@property (nonatomic, strong) NSString *version;
/*! 事业部Id */
@property (nonatomic, strong) NSString *business_id;


@property (nonatomic, strong) NSString *sign;

@property (nonatomic, strong) NSString *user_id;

@property (nonatomic, strong) NSString *lrving_id;


@end
