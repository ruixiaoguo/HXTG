//
//  HXMySetCell.h
//  HXTG
//
//  Created by grx on 2017/3/31.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXMySetCell : UITableViewCell{
    UIImageView *tipImage;
}

@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *versionLable;
@property (strong, nonatomic) NSDictionary *infoDic;

@end
