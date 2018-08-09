//
//  HXLoginViewModel.h
//  HXTG
//
//  Created by grx on 2017/3/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "ViewModelClass.h"

@interface LoginRequestManager : ViewModelClass

/** 用户登录 */
-(void)requestLoginInterface:(NSDictionary *)dic;

@end
