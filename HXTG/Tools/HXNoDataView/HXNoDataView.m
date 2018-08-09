//
//  HXNoDataView.m
//  HXTG
//
//  Created by grx on 2017/4/10.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXNoDataView.h"
static HXNoDataView *noDataView;

@interface HXNoDataView()

@end

@implementation HXNoDataView

-(id)initWithFrame:(CGRect)frame showView:(UIView *)superView Stype:(HXNoDataViewStyle)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorBgLightTheme;
        
        UIImageView *imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@"kong"];
        [self addSubview:imageview];
        self.imageview = imageview;
        self.frame = frame;
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = UIFontSystem13;
        self.label = label;
        if (type==HXNoDataType) {
            label.text = [NSString stringWithFormat:@"抱歉,没有找到您要的数据"];
        }else if (type==HXNoServerType){
            label.text = [NSString stringWithFormat:@"服务器异常，请稍后再试"];
        }else if (type==HXNoNetType){
            label.text = [NSString stringWithFormat:@"暂无网络,请重新连接"];
        }else if (type==HXNoPlayType){
            label.text = [NSString stringWithFormat:@"当前暂无直播"];
        }
        label.textColor = UIColorLineTheme;
        [self addSubview:label];
    }
    self.hidden = YES;
    [superView addSubview:self];
    self.imageview.frame = CGRectMake(0, 0, 62, 70);
    self.imageview.centerX = Main_Screen_Width/2;
    self.imageview.centerY = self.frame.size.height/2-100;
    self.label.frame = CGRectMake(0, CGRectGetMaxY(self.imageview.frame), self.width, 40);
    return self;
}

//-(instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        self.backgroundColor = [UIColor whiteColor];
//        
//        UIImageView *imageview = [[UIImageView alloc]init];
//        self.imageview = imageview;
//        imageview.image = [UIImage imageNamed:@"kulian"];
//        [self addSubview:imageview];
//        self.frame = frame;
//        UILabel *label = [[UILabel alloc]init];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = UIFontSystem13;
//        self.label = label;
//        label.text = [NSString stringWithFormat:@"抱歉,没有找到您要的数据"];
//        label.textColor = UIColorLineTheme;
//        [self addSubview:label];
//        
//    }
//    return self;
//}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    self.imageview.frame = CGRectMake(0, 0, 62, 70);
//    self.imageview.centerX = Main_Screen_Width/2;
//    self.imageview.centerY = self.frame.size.height/2-100;
//    self.label.frame = CGRectMake(0, CGRectGetMaxY(self.imageview.frame), self.width, 40);
//}

-(void)setStype:(HXNoDataViewStyle)stype
{
    if (stype==0) {
        self.label.text = [NSString stringWithFormat:@"抱歉,没有找到您要的数据"];
        self.imageview.image = [UIImage imageNamed:@"kong"];
    }else if (stype==1){
        self.label.text = [NSString stringWithFormat:@"服务器异常，请稍后再试"];
        self.imageview.image = [UIImage imageNamed:@"fuwq"];
    }else if (stype==2){
        self.label.text = [NSString stringWithFormat:@"暂无网络,请重新连接"];
        self.imageview.image = [UIImage imageNamed:@"wuwangluo"];
    }else if (stype==3){
        self.label.text = [NSString stringWithFormat:@"当前暂无直播"];
        self.imageview.image = [UIImage imageNamed:@"kong"];
    }
}

@end
