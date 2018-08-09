//
//  RCIMHttpTools.m
//  HXTG
//
//  Created by grx on 2017/4/19.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "RCIMHttpTools.h"
#import "HomeRequestModel.h"
//#import "RYUser+CoreDataClass.h"

@implementation RCIMHttpTools

+ (RCIMHttpTools *)shareInstance {
    
    static RCIMHttpTools *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[[self class] alloc] init];
    });
    return instance;
}

#pragma mark - 获取用户个人基本信息
- (void)getUserInfoWithUserID:(NSString *)userID completion:(void (^)(RCUserInfo *))completion {
    
    HomeRequestModel *model = [[HomeRequestModel alloc]init];
    model.user_id = USERID;
    model.lrving_id = userID;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"User/FindLegion" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
    NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
       if ([status isEqualToString:@"1"]) {
          NSString *teachName = [NSString stringWithFormat:@"%@",responseDict[@"user_nicename"]];
          RCUserInfo *user = [[RCUserInfo alloc] init];
          user.userId = userID;
          user.portraitUri = @"http://oq6doxvnn.bkt.clouddn.com/admin/20170525/juntuatouxiang.png";
          user.name = [NSString stringWithFormat:@"%@老师",teachName];
          completion(user);
       }else{
           RCUserInfo *user = [[RCUserInfo alloc] init];
           user.userId = @"";
           user.portraitUri = @"http://oq6doxvnn.bkt.clouddn.com/admin/20170525/juntuatouxiang.png";
           user.name = [NSString stringWithFormat:@""];
           completion(user);
       }
} WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
    
} WithFailureBlock:^{
    
}];
}


@end
