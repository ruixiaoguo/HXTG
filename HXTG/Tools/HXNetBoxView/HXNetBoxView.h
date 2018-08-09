//
//  HXNetBoxView.h
//  HXTG
//  网络状态（无网络连接时吐司框）
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXNetBoxView : UIView

@property (strong, nonatomic) UILabel *boxlable;

+ (HXNetBoxView *)getInstance;

-(void)showTitle:(UIView *)superView withTitle:(NSString *)title;

@end
