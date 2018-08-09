//
//  HXStockPoolCell.h
//  HXTG
//  股票池
//  Created by grx on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXStockPoolModel.h"

@interface HXStockPoolCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) UILabel *styleLable;  /*! 风格 */
@property (strong, nonatomic) UILabel *gradeLable;  /*! 评级 */

@property (strong, nonatomic) HXStockPoolModel *model;

@end
