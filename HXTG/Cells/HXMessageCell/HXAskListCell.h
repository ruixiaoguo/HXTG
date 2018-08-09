//
//  HXAskListCell.h
//  HXTG
//
//  Created by grx on 2017/6/8.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXAskListModel.h"

@interface HXAskListCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *unReadMessageLable;

@property (strong, nonatomic) HXAskListModel *model;

@end
