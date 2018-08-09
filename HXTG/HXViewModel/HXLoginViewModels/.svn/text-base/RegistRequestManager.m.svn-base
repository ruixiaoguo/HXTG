//
//  RigistRequestManager.m
//  HXTG
//
//  Created by grx on 2017/3/20.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "RegistRequestManager.h"
#import "RegistRequestModel.h"

@implementation RegistRequestManager

/** 判断用户是否存在 */
-(void)requestIsExistUserInterface:(NSDictionary *)dic
{
    
    RegistRequestModel *model = [[RegistRequestModel alloc]init];
    model.user_login = dic[@"user_login"];
    NSDictionary *dict = [model mj_keyValues];
    WeakSelf(weakSelf);
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/checkUsername" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        weakSelf.returnBlock(responseDict);
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf errorCodeWithDic:error];
    } WithFailureBlock:^{
        [weakSelf netFailure];
    }];
}

/*! 发送短信验证码 */
-(void)requestSendSNSInterface:(NSDictionary *)dic
{
    
    RegistRequestModel *model = [[RegistRequestModel alloc]init];
    model.mobile = dic[@"mobile"];
    model.type = dic[@"type"];
    NSDictionary *dict = [model mj_keyValues];
    WeakSelf(weakSelf);
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/sengSms" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        weakSelf.returnBlock(responseDict);
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf errorCodeWithDic:error];
    } WithFailureBlock:^{
        [weakSelf netFailure];
    }];
}

/** 验证短信验证码 */
-(void)requestCheckSNSInterface:(NSDictionary *)dic
{
    
    RegistRequestModel *model = [[RegistRequestModel alloc]init];
    model.code = dic[@"code"];
    NSDictionary *dict = [model mj_keyValues];
     WeakSelf(weakSelf);
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/checkVerity" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        weakSelf.returnBlock(responseDict);
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf errorCodeWithDic:error];
    } WithFailureBlock:^{
        [weakSelf netFailure];
    }];
}

/*! 注册 */
-(void)requestRigistInterface:(NSDictionary *)dic
{
    RegistRequestModel *model = [[RegistRequestModel alloc]init];
    model.user_login = dic[@"user_login"];
    model.user_pass = dic[@"user_pass"];
    model.user_repass = dic[@"user_repass"];
    model.mobile = dic[@"mobile"];
    model.code = dic[@"code"];
    model.invitation = dic[@"invitation"];
    NSDictionary *dict = [model mj_keyValues];
    WeakSelf(weakSelf);
    
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/register" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        DDLog(@"注册responseDict======%@",responseDict);
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
