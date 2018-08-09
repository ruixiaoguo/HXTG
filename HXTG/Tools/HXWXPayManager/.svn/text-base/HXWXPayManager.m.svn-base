//
//  HXWXPayManager.m
//  HXTG
//
//  Created by grx on 2017/3/9.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXWXPayManager.h"
//#import "WXApi.h"

@implementation HXWXPayManager

static HXWXPayManager *wxPayManage;

/*! 支付宝管理单例 */
+ (HXWXPayManager *)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wxPayManage = [[HXWXPayManager alloc]init];
    });
    return wxPayManage;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wxPayManage = [super allocWithZone:zone];
    });
    return wxPayManage;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return wxPayManage;
}


-(void)HXWXPayOrder:(NSDictionary *)orderDic{
    /*! NOTE: 调用微信支付结果开始支付 */
//    NSMutableString*stamp= [orderDic objectForKey:@"timestamp"];

//    PayReq* req= [[PayReq alloc]init];
//    
//    req.partnerId= [orderDic objectForKey:@"partnerid"];
//    
//    req.prepayId= [orderDic objectForKey:@"prepayid"];
//    
//    req.nonceStr= [orderDic objectForKey:@"noncestr"];
//    
//    req.timeStamp= stamp.intValue;
//    
//    req.package= [orderDic objectForKey:@"package"];
//    
//    req.sign= [orderDic objectForKey:@"sign"];
//    
//    [WXApi sendReq:req];

}

@end
