//
//  HXCustomCell.h
//  HXTG
//  客户服务
//  Created by grx on 2017/5/4.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXCustomCell : UITableViewCell{
    UIImageView *tipImage;
}

@property (strong, nonatomic) UIImageView *iconImage;
@property (strong, nonatomic) UILabel *titlelable;
@property (strong, nonatomic) UILabel *disLable;

@property (strong, nonatomic) NSDictionary *infoDic;

@end
