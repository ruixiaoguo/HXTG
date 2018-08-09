//
//  HXTgReferenceCell.h
//  HXTG
//  投顾内参
//  Created by grx on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTgRefeModel.h"

@interface HXTgReferenceCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) HXTgRefeModel *model;

@end
