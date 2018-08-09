//
//  HXLrvingListModel.h
//  HXTG
//  军团列表
//  Created by grx on 2017/5/8.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXLrvingListModel : NSObject

/** 军团ID */
@property (nonatomic ,strong) NSString *lid;
/** 军团名称 */
@property (nonatomic ,strong) NSString *lrving_name;
/*! 军团图片 */
@property (strong, nonatomic) NSString *lrving_img;

/** 带头人 */
@property (nonatomic ,strong) NSString *lrving_username;
/** 军团简介 */
@property (nonatomic ,strong) NSString *legion_info;
/** 风格 */
@property (nonatomic ,strong) NSString *lrving_style;
/** 资格证号 */
@property (nonatomic ,strong) NSString *lrving_dictate;
/** 当前页数 */
@property (nonatomic ,strong) NSString *pagenum;
/** 总页数 */
@property (nonatomic ,strong) NSString *pagecount;



@end
