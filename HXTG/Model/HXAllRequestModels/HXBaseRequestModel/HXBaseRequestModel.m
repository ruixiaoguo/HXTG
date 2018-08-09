//
//  HXBaseRequestModel.m
//  HXTG
//
//  Created by grx on 2017/3/16.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseRequestModel.h"

@implementation HXBaseRequestModel

-(NSString *)business_id
{
    NSString *businessId;
    if (USERBUSINESSID==nil) {
        businessId = @"";
    }else{
        businessId = USERBUSINESSID;
    }
    return businessId;
}

-(NSString *)sign
{
    NSString *signStr;
    if (SIGN==nil) {
        signStr = @"";
    }else{
        signStr = SIGN;
    }
    return signStr;
}

-(NSString *)user_id
{
    NSString *userIdStr;
    if (USERID ==nil) {
        userIdStr = @"";
    }else{
        userIdStr = USERID;
    }
    return userIdStr;
}


@end
