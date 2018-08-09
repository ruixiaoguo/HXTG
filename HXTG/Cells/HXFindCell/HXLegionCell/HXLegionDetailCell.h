//
//  HXLegionDetailCell.h
//  HXTG
//  投顾军团详情
//  Created by grx on 2017/5/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXLrvingDetailModel.h"

@interface HXLegionDetailCell : UITableViewCell

@property (strong, nonatomic) UIImageView *picImageView;
@property (strong, nonatomic) UILabel *lrvingName;        /*! 带头人 */
@property (strong, nonatomic) UILabel *lrvingStyle;       /*! 风格 */
@property (strong, nonatomic) UILabel *certificateNum;    /*! 资格证号 */
@property (strong, nonatomic) UILabel *introduction;      /*! 简介 */

@property (strong, nonatomic) HXLrvingDetailModel *model;

@end
