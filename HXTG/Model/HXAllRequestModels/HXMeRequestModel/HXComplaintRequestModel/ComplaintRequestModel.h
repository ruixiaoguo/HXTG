//
//  ComplaintRequestModel.h
//  HXTG
//  投诉反馈
//  Created by grx on 2017/4/7.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseRequestModel.h"

@interface ComplaintRequestModel : HXBaseRequestModel

/*! 用户名 */
@property (nonatomic, strong) NSString *user_login;
/*! 用户姓名 */
@property (nonatomic, strong) NSString *username;

/*! 内容 */
@property (nonatomic, strong) NSString *content;
/*! 机型（例如：iPhone5，华为） */
@property (nonatomic, strong) NSString *phone_type;
/*! 系统(例如：iOS10，Android4.0) */
@property (nonatomic, strong) NSString *client_type;
/*! app版本 */
@property (nonatomic, strong) NSString *client_version;
/*! 用户联系方式 */
@property (nonatomic, strong) NSString *phone;
/*! 图片 */
@property (nonatomic, strong) NSMutableDictionary *imgDict;

@end
