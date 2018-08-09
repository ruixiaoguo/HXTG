//
//  ViewModelClass.m
//  HXTG
//
//  Created by grx on 2017/2/15.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "ViewModelClass.h"

@implementation ViewModelClass

#pragma 获取网络可到达状态
-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock;
{
    [[HXNetClient sharedInstance]netWorkReachabilityWithReturnNetWorkStatusBlock:^(AFNetworkReachabilityStatus status) {
        netConnectBlock(status);
    }];
}

#pragma 接收穿过来的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}


@end
