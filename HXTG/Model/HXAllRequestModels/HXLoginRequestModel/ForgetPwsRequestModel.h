//
//  ForgetPwsRequestModel.h
//  HXTG
//
//  Created by grx on 2017/3/21.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseRequestModel.h"

@interface ForgetPwsRequestModel : HXBaseRequestModel

/*! 手机号 */
@property (nonatomic, strong) NSString *mobile;

/*! 新密码 */
@property (nonatomic, strong) NSString *password;

/*! 确认密码 */
@property (nonatomic, strong) NSString *repassword;

@end
