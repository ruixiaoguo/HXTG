//
//  ViewModelClass.h
//  HXTG
//
//  Created by grx on 2017/2/15.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ViewModelClass : NSObject

@property (strong, nonatomic) ReturnValueBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailureBlock failureBlock;

/** 获取网络的链接状态 */

-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock;

/** 传入交互的Block块 */

-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock;


@end
