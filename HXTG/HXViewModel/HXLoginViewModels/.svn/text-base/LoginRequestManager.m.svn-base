//
//  HXLoginViewModel.m
//  HXTG
//
//  Created by grx on 2017/3/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "LoginRequestManager.h"
#import "LoginRequestModel.h"

@implementation LoginRequestManager

/** 用户登录 */
-(void)requestLoginInterface:(NSDictionary *)dic
{

    LoginRequestModel *model = [[LoginRequestModel alloc]init];
    model.user_login = dic[@"user_login"];
    model.user_pass = dic[@"user_pass"];
    NSDictionary *dict = [model mj_keyValues];
    WeakSelf(weakSelf);
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/login" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
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
