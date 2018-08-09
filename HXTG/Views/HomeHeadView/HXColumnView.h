//
//  HXColumnView.h
//  HXTG
//  分类
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXColumnView : UIView{
    UIView *bjBgView;
    UIView *cqBgView;
}

@property (strong, nonatomic) void(^bjColumnClickBlock)(NSInteger columnTag);
@property (strong, nonatomic) void(^cqColumnClickBlock)(NSInteger columnTag);

-(void)markeHeadView:(UIView *)surperView isCheck:(NSString *)isCheck;

@end
