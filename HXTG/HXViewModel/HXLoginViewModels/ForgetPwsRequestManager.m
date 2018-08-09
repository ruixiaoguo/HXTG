//
//  ForgetPwsRequestManager.m
//  HXTG
//
//  Created by grx on 2017/3/21.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "ForgetPwsRequestManager.h"
#import "ForgetPwsRequestModel.h"

@implementation ForgetPwsRequestManager

/*! 重置密码 */
-(void)requestResetPwsInterface:(NSDictionary *)dic
{
    ForgetPwsRequestModel *model = [[ForgetPwsRequestModel alloc]init];
    model.mobile = dic[@"mobile"];
    model.password = dic[@"password"];
    model.repassword = dic[@"repassword"];
    NSDictionary *dict = [model mj_keyValues];
     WeakSelf(weakSelf);
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/resetPassword" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        weakSelf.returnBlock(responseDict);
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf errorCodeWithDic:error];
    } WithFailureBlock:^{
        [weakSelf netFailure];
    }];
    
}

#pragma 对ErrorCode进行处理
-(void) errorCodeWithDic: (NSError *) errorDic
{
    self.errorBlock(errorDic);
}

#pragma 对网路异常进行处理
-(void) netFailure
{
    self.failureBlock();
}

@end
