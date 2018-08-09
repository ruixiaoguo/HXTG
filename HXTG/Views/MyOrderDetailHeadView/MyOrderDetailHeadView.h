//
//  MyOrderDetailHeadView.h
//  HXTG
//
//  Created by grx on 2017/5/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderDetailHeadView : UIView{
    UIView *serverBgView;
}

/*! ================================订单信息========================================== */
@property (strong, nonatomic) UILabel *orderNum;       /*! 订单编号 */
@property (strong, nonatomic) UILabel *customName;     /*! 客户姓名 */
@property (strong, nonatomic) UILabel *customIdCart;   /*! 身份证号 */
@property (strong, nonatomic) UILabel *phoneNum;       /*! 手机号 */
@property (strong, nonatomic) UILabel *orderTime;      /*! 下单时间 */
@property (strong, nonatomic) UILabel *orderState;     /*! 订单状态 */
/*! ================================版本服务信息========================================== */
@property (strong, nonatomic) UILabel *serverVersion;       /*! 服务版本 */
@property (strong, nonatomic) UILabel *serverTime;          /*! 服务期限 */
@property (strong, nonatomic) UILabel *receivables;         /*! 金额 */
@property (strong, nonatomic) UILabel *allreceivables;         /*! 应付金额 */
@property (strong, nonatomic) UILabel *factreceivables;         /*! 实付金额 */

@property (strong, nonatomic) UILabel *giveTime;            /*! 赠送日期 */
@property (strong, nonatomic) UILabel *giveDay;             /*! 赠送期限 */
/*! ================================投顾军团信息========================================== */
@property (strong, nonatomic) UILabel *legionName;       /*! 军团名称 */
@property (strong, nonatomic) UILabel *leaderName;       /*! 带头人 */
@property (strong, nonatomic) UILabel *legioStyle;       /*! 军团风格 */



@property (strong, nonatomic) NSDictionary *orderDic;
@property (strong, nonatomic) NSDictionary *legionDic;
@property (strong, nonatomic) UIView *legionBgView;


/*! 跳转到投顾军团详情 */
@property (strong, nonatomic) void (^jumpToLegionDetail)();

@end
