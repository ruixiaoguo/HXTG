//
//  MeHeadView.h
//  HXTG
//
//  Created by grx on 2017/3/1.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeHeadView : UIView{
    UIView *lineView;
}

@property (strong, nonatomic) UIImageView *bgImage;
@property (strong, nonatomic) UIImageView *headImage;
@property (strong, nonatomic) UILabel *userName;

@property (strong, nonatomic) void(^bgImageClickBlock)();

@end
