//
//  HXMyOrderCell.m
//  HXTG
//
//  Created by grx on 2017/5/4.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMyOrderCell.h"

@implementation HXMyOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView=[[UIView alloc]initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor=UIColorBgLightTheme;
        self.backgroundColor = UIColorWhite;
        [self markCell];
    }
    return self;
}

-(void)markCell
{
    /*! 分割线 */
    UIView *downLineViwe = [UIView new];
    downLineViwe.backgroundColor = UIColorBgLightTheme;
    [self.contentView addSubview:downLineViwe];
    downLineViwe.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(5);
    /*! 时间 */
    self.timeLable = [UILabel new];
    self.timeLable.font = UIFontSystem13;
    self.timeLable.textColor = UIColorBlackTheme;
    self.timeLable.text = @"2016-11-06";
    [self.contentView addSubview:self.timeLable];
    self.timeLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,8).widthIs(80).heightIs(30);
    /*! 订单号 */
    self.orderLable = [UILabel new];
    self.orderLable.font = UIFontSystem13;
    self.orderLable.textColor = UIColorBlackTheme;
    self.orderLable.text = @"订单号: 3434332345";
    [self.contentView addSubview:self.orderLable];
    self.orderLable.sd_layout.leftSpaceToView(self.timeLable,10).topEqualToView(self.timeLable).rightSpaceToView(self.contentView, 10).heightIs(30);
    /*! 订单图片 */
    self.orderImage = [UIImageView new];
    [self.contentView addSubview:self.orderImage];
    self.orderImage.sd_layout.leftEqualToView(self.timeLable).topSpaceToView(self.timeLable,5).widthIs(43).heightIs(38);
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = UIFontSystem14;
    self.titleLable.textColor = UIColorBlackTheme;
    self.titleLable.text = @"华讯投顾专业版";
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.orderImage,15).topSpaceToView(self.orderLable,self.orderImage.frame.size.height/2-6).rightSpaceToView(self.contentView,70).heightIs(20);
    /*! 审核状态 */
    self.stateLable = [UILabel new];
    self.stateLable.font = UIFontSystem13;
    self.stateLable.textColor = UIColorBlueTheme;
    self.stateLable.text = @"审核中";
    self.stateLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.stateLable];
    self.stateLable.sd_layout.rightSpaceToView(self.contentView,15).topEqualToView(self.titleLable).widthIs(60).heightIs(20);
    
}

-(void)setOrderModel:(HXMyOrderModel *)orderModel
{
    self.timeLable.text = orderModel.order_time;
    self.orderLable.text = [NSString stringWithFormat:@"订单号: %@",orderModel.order_sn];
    self.titleLable.text = orderModel.product_name;
    self.stateLable.text = orderModel.state;
    if ([orderModel.parent_name isEqualToString:@"专业版"]) {
        self.orderImage.image = [UIImage imageNamed:@"1"];
    }else if ([orderModel.parent_name isEqualToString:@"VIP版"]){
        self.orderImage.image = [UIImage imageNamed:@"2"];
    }else if ([orderModel.parent_name isEqualToString:@"机构版"]){
        self.orderImage.image = [UIImage imageNamed:@"3"];
    }else if ([orderModel.parent_name isEqualToString:@"VIP机构版"]){
        self.orderImage.image = [UIImage imageNamed:@"4"];
    }else if ([orderModel.parent_name isEqualToString:@"定制版"]){
        self.orderImage.image = [UIImage imageNamed:@"5"];
    }
    if ([self.stateLable.text isEqualToString:@"待审核"] || [self.stateLable.text isEqualToString:@"待签约"]|| [self.stateLable.text isEqualToString:@"待支付"]||[self.stateLable.text isEqualToString:@"审核中"]) {
        self.stateLable.textColor = UIColorBlueTheme;
    }else if ([self.stateLable.text isEqualToString:@"服务中"] || [self.stateLable.text isEqualToString:@"待开通"]|| [self.stateLable.text isEqualToString:@"已开通"]){
        self.stateLable.textColor = UIColorBlackTheme;
    }else if ([self.stateLable.text isEqualToString:@"已过期"] || [self.stateLable.text isEqualToString:@"已取消"]){
        self.stateLable.textColor = UIColorRedTheme;
    }
}


@end
