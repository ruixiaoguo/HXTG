//
//  HXPastEarlyModel.h
//  HXTG
//  今日早盘/往日早盘列表
//  Created by grx on 2017/3/30.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXPastEarlyModel : NSObject

/** 文章ID */
@property (nonatomic ,strong) NSString *post_id;
/** 文章日期 */
@property (nonatomic ,strong) NSString *post_date;
/*! 文章标题 */
@property (nonatomic ,strong) NSString *post_title;
/*! 文章内容 */
@property (nonatomic ,strong) NSString *post_content;
/*! pdf文件 */
@property (nonatomic ,strong) NSString *file1_url;
/*! pdf文件名 */
@property (nonatomic ,strong) NSString *file1_name;
/*! 音频文件 */
@property (nonatomic ,strong) NSString *file2_url;
/*! 音频文件名 */
@property (nonatomic ,strong) NSString *file2_name;
/*! 视频源 */
@property (nonatomic ,strong) NSString *video_url;
/*! 视频封面 */
@property (nonatomic ,strong) NSString *video_pic;

@end
