//
//  HXApplayCartCell.h
//  HXTG
//  在线申请
//  Created by grx on 2017/4/7.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - 基本信息/投资调查
@interface HXApplayCartCell : UITableViewCell

@property (strong, nonatomic) UIImageView *starImage;
@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UITextField *contentLable;
@property (strong, nonatomic) UIButton *selectButton;

@property (strong, nonatomic) NSDictionary *infoDic;

@end

/*! 已购服务 */
@interface HXBuyServerCell : UITableViewCell{
    NSMutableArray *selectProductArray;
    NSMutableArray *allProductArray;

}

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) NSArray *productArray;
@property (strong, nonatomic) UIImageView *selectImage;
@property (strong, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) UITextField *otherServer;

@property (strong, nonatomic) void (^selectProArray)(NSMutableArray *selArray);

@end
