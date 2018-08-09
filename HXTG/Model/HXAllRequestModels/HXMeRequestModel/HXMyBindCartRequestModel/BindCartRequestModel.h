//
//  BindCartRequestModel.h
//  HXTG
//
//  Created by grx on 2017/4/13.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseRequestModel.h"

@interface BindCartRequestModel : HXBaseRequestModel

@property (strong, nonatomic) NSString *user_login;/*! 用户名 */
@property (strong, nonatomic) NSString *cardno;    /*! 会员卡号 */


/*! 申请会员卡 */
@property (strong, nonatomic) NSString *realname;    /*! 真实姓名 */
@property (strong, nonatomic) NSString *number;      /*! 身份证号 */
@property (strong, nonatomic) NSString *vip_id;      /*! 会员类型 */
@property (strong, nonatomic) NSString *job_id;      /*! 职能类别 */
@property (strong, nonatomic) NSString *year_id;     /*! 年收入 */
@property (strong, nonatomic) NSString *amount_id;   /*! 资金量 */
@property (strong, nonatomic) NSString *investment_experience;    /*! 投资经验 */
@property (strong, nonatomic) NSString *invest_id;   /*! 投资风格 */
@property (strong, nonatomic) NSString *province;    /*! 省 */
@property (strong, nonatomic) NSString *city;        /*! 市 */
@property (strong, nonatomic) NSString *county;      /*! 区 */
@property (strong, nonatomic) NSString *address;      /*! 详细地址 */

@property (strong, nonatomic) NSString *lrving_id;   /*! 产品名称 */
@property (strong, nonatomic) NSString *content;     /*! 备注 */


@end
