//
//  HXPastEarlyCell.h
//  HXTG
//  往期早盘
//  Created by grx on 2017/3/8.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPastEarlyModel.h"

@interface HXPastEarlyCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) HXPastEarlyModel *model;

@end
