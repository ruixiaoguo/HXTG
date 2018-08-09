//
//  HXNoDataView.h
//  HXTG
//  没有数据时加载的界面
//  Created by grx on 2017/4/10.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HXNoDataType,
    HXNoServerType,
    HXNoNetType,
    HXNoPlayType
} HXNoDataViewStyle;

@interface HXNoDataView : UIView

@property (nonatomic ,strong) UIImageView *imageview;
@property (nonatomic ,strong) UILabel *label;
@property (assign, nonatomic) HXNoDataViewStyle stype;

-(id)initWithFrame:(CGRect)frame showView:(UIView *)superView Stype:(HXNoDataViewStyle)type;

@end
