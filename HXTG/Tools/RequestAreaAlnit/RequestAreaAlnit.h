//
//  RequestAreaAlnit.h
//  YongBar
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 grx. All rights reserved.
//
/*! 获取所在地 */
#import <Foundation/Foundation.h>

@interface RequestAreaAlnit : NSObject{
    NSInteger areaCount;
}

@property (nonatomic, strong) NSMutableArray *allMegelArray;
@property (nonatomic, strong) NSMutableArray *allMegelIdArray;
@property (nonatomic, strong) NSMutableArray *alldistrictIdArray;

+(instancetype) shareInstance;

-(void)getAreaAlnit;

@end
