//
//  UserInfoRequestModel.h
//  HXTG
//  获取用户信息
//  Created by grx on 2017/4/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseRequestModel.h"

@interface UserInfoRequestModel : HXBaseRequestModel

/*! 用户名 */
@property (nonatomic, strong) NSString *user_login;

@end
