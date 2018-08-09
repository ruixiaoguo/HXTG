//
//  HXStockSpecCell.h
//  HXTG
//  炒股攻略
//  Created by grx on 2017/3/24.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXHomeCellModel.h"

@interface HXStockSpecCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *contentLable;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) HXHomeCellModel *model;


@end
