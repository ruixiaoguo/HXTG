//
//  YBCommentPhotoView.h
//  YongBar
//  上传多张图片
//  Created by lixiao on 16/1/15.
//  Copyright © 2016年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXPhotoWall : UIView

@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSMutableArray *deleteButtonArray;
//数据
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, copy) void(^tapImageViewClickBlock)(UIImageView *imageView);
@property (nonatomic, copy) void (^tapDeleteButtonClickBlock)(NSInteger index);

- (void)gaintImageArray:(NSMutableArray *)imageArray IsDelete:(BOOL)isDelete;

@end
