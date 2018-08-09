//
//  HXServerDetailCell.h
//  HXTG
//  服务列表详情
//  Created by grx on 2017/5/5.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXServerDetailVerCell : UITableViewCell

@property (strong, nonatomic) UIView *bgPriceView;
@property (strong, nonatomic) UIImageView *picImageView;
@property (strong, nonatomic) UILabel *monPriceLable;
@property (strong, nonatomic) UILabel *yearPriceLable;

@property (strong, nonatomic) NSDictionary *infoDic;

@end
