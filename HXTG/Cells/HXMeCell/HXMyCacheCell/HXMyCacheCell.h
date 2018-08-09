//
//  HXMyCacheCell.h
//  HXTG
//  离线缓存
//  Created by grx on 2017/4/11.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXMyCacheModel.h"

@interface HXMyCacheCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *downLoadLable;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) HXMyCacheModel *cacheModel;

@end


@interface HXMyEditCacheCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *downLoadLable;
@property (strong, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) HXMyCacheModel *cacheModel;

@property (strong, nonatomic) void (^selectBtnClick)();


@end
