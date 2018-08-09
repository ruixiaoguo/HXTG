//
//  HXMyCacheModel.h
//  HXTG
//  离线缓存
//  Created by grx on 2017/4/12.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXMyCacheModel : NSObject

/** 离线缓存id */
@property (nonatomic ,strong) NSString *cache_id;
/*! 离线缓存时间 */
@property (nonatomic ,strong) NSString *time;
/** 离线缓存标题 */
@property (nonatomic ,strong) NSString *title;
/** 离线缓存URL */
@property (nonatomic ,strong) NSString *url;
/**  下载状态 */
@property (nonatomic ,strong) NSString *downLoadState;
/**  下载进度 */
@property (nonatomic ,assign) CGFloat f;
/**  编辑状态选中 */
@property (nonatomic ,assign) BOOL isSelect;

@end
