//
//  HXNetBoxView.m
//  HXTG
//
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXNetBoxView.h"
#define boxViewHight 35

@implementation HXNetBoxView

static HXNetBoxView *boxView;

/*! 管理单例 */
+ (HXNetBoxView *)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        boxView = [[HXNetBoxView alloc]init];
        boxView.frame = CGRectMake(0, navBarHeight, Main_Screen_Width, boxViewHight);
        boxView.alpha = 0;
    });
    return boxView;
}
/*! 懒加载 */
-(UILabel *)boxlable
{
    if (!_boxlable) {
        self.backgroundColor = ColorWithRGB(234, 57, 69);
        _boxlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _boxlable.textColor = [UIColor whiteColor];
        _boxlable.textAlignment = NSTextAlignmentCenter;
        _boxlable.font = [UIFont systemFontOfSize:13];
        [self addSubview:_boxlable];
    }
    return _boxlable;
}

-(void)showTitle:(UIView *)superView withTitle:(NSString *)title
{
    __weak typeof(self) weakSelf = self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [superView addSubview:boxView];
    });
    [UIView animateWithDuration:0.5 animations:^{
//        boxView.frame = CGRectMake(0, navBarHeight, Main_Screen_Width, 40);
        boxView.alpha = 1;
        weakSelf.boxlable.text = title;
        /*! 创建定时器 */
        [weakSelf createTimer];
    }];
}

#pragma mark - 创建定时器
-(void)createTimer
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        /*! 提示框消失 */
        [UIView animateWithDuration:0.5 animations:^{
//            boxView.frame = CGRectMake(0, -navBarHeight, Main_Screen_Width, 40);
            boxView.alpha = 0;
        }];
        
    });
}


@end
