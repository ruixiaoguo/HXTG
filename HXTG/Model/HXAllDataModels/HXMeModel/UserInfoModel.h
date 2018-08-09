//
//  UserInfoModel.h
//  HXTG
//
//  Created by grx on 2017/4/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

/** 手机号 */
@property (nonatomic ,strong) NSString *mobile;
/** 邮箱 */
@property (nonatomic ,strong) NSString *user_email;
/** qq */
@property (nonatomic ,strong) NSString *uqq;
/** 真实姓名 */
@property (nonatomic ,strong) NSString *realname;
/** 身份证号 */
@property (nonatomic ,strong) NSString *unumber;
/** 详细地址 */
@property (nonatomic ,strong) NSString *address;
/** 是否实名认证 1已认证0未认证 */
@property (nonatomic ,strong) NSString *ischeck;
/** 省 */
@property (nonatomic ,strong) NSString *province;
@property (nonatomic ,strong) NSString *provinceId;

/** 市 */
@property (nonatomic ,strong) NSString *city;
@property (nonatomic ,strong) NSString *cityId;

/** 区 */
@property (nonatomic ,strong) NSString *county;
@property (nonatomic ,strong) NSString *countyId;

@end
