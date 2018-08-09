//
//  HXServerListCell.h
//  HXTG
//  服务版本
//  Created by grx on 2017/5/4.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXServerVersionCell : UITableViewCell

@property (strong, nonatomic) UIImageView *picImageView;
@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *disLable;

@property (strong, nonatomic) NSDictionary *infoDic;

@end
