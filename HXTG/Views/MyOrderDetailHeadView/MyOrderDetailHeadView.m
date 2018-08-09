//
//  MyOrderDetailHeadView.m
//  HXTG
//
//  Created by grx on 2017/5/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "MyOrderDetailHeadView.h"
#import "UILabel+ContentSize.h"
#import "NSString+TxtHeight.h"
@implementation MyOrderDetailHeadView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = UIColorBgLightTheme;
        
        [self markeHeadView];
    }
    return self;
}

/*! 创建MeView */
-(void)markeHeadView
{
    /*! ================================订单信息========================================== */
    /*! 订单名称 */
    UILabel *orderName = [UILabel new];
    orderName.font = UIFontSystem15;
    orderName.textColor = UIColorBlackTheme;
    orderName.text = @"订单信息";
    [self addSubview:orderName];
    orderName.sd_layout.leftSpaceToView(self, 15).rightSpaceToView(self, 15).topSpaceToView(self, 10).heightIs(34);
    /*! 订单内容 */
    UIView *orderBgView = [UIView new];
    orderBgView.backgroundColor = UIColorWhite;
    [self addSubview:orderBgView];
    orderBgView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(orderName, 0).heightIs(169);
    /*! 订单编号 */
    self.orderNum = [UILabel new];
    self.orderNum.font = UIFontSystem14;
    self.orderNum.textColor = UIColorBlackTheme;
    [orderBgView addSubview:self.orderNum];
    self.orderNum.sd_layout.leftSpaceToView(orderBgView, 15).rightSpaceToView(orderBgView, 15).topSpaceToView(orderBgView, 10).heightIs(25);
    /*! 客户姓名 */
    self.customName = [UILabel new];
    self.customName.font = UIFontSystem13;
    self.customName.textColor = UIColorBlackTheme;
    [orderBgView addSubview:self.customName];
    self.customName.sd_layout.leftSpaceToView(orderBgView, 15).rightSpaceToView(orderBgView, 15).topSpaceToView(self.orderNum, 0).heightIs(25);
    /*! 身份证号 */
    self.customIdCart = [UILabel new];
    self.customIdCart.font = UIFontSystem14;
    self.customIdCart.textColor = UIColorBlackTheme;
    [orderBgView addSubview:self.customIdCart];
    self.customIdCart.sd_layout.leftSpaceToView(orderBgView, 15).rightSpaceToView(orderBgView, 15).topSpaceToView(self.customName, 0).heightIs(25);
    /*! 手机号 */
    self.phoneNum = [UILabel new];
    self.phoneNum.font = UIFontSystem14;
    self.phoneNum.textColor = UIColorBlackTheme;
    [orderBgView addSubview:self.phoneNum];
    self.phoneNum.sd_layout.leftSpaceToView(orderBgView, 15).rightSpaceToView(orderBgView, 15).topSpaceToView(self.customIdCart, 0).heightIs(25);
    /*! 下单时间 */
    self.orderTime = [UILabel new];
    self.orderTime.font = UIFontSystem14;
    self.orderTime.textColor = UIColorBlackTheme;
    [orderBgView addSubview:self.orderTime];
    self.orderTime.sd_layout.leftSpaceToView(orderBgView, 15).rightSpaceToView(orderBgView, 15).topSpaceToView(self.phoneNum, 0).heightIs(25);
    /*! 订单状态 */
    self.orderState = [UILabel new];
    self.orderState.font = UIFontSystem14;
    self.orderState.textColor = UIColorBlackTheme;
    [orderBgView addSubview:self.orderState];
    self.orderState.sd_layout.leftSpaceToView(orderBgView, 15).rightSpaceToView(orderBgView, 15).topSpaceToView(self.orderTime, 0).heightIs(25);
    /*! ================================版本服务信息========================================== */
    /*! 服务名称 */
    UILabel *serverName = [UILabel new];
    serverName.font = UIFontSystem15;
    serverName.textColor = UIColorBlackTheme;
    serverName.text = @"版本服务信息";
    [self addSubview:serverName];
    serverName.sd_layout.leftSpaceToView(self, 15).rightSpaceToView(self, 15).topSpaceToView(orderBgView, 10).heightIs(34);
    /*! 服务内容 */
    serverBgView = [UIView new];
    serverBgView.backgroundColor = UIColorWhite;
    [self addSubview:serverBgView];
    serverBgView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(serverName, 0).heightIs(145);
    /*! 服务版本 */
    self.serverVersion = [UILabel new];
    self.serverVersion.font = UIFontSystem14;
    self.serverVersion.textColor = UIColorBlackTheme;
    [serverBgView addSubview:self.serverVersion];
    self.serverVersion.sd_layout.leftSpaceToView(serverBgView, 15).rightSpaceToView(serverBgView, 15).topSpaceToView(serverBgView, 10).heightIs(25);
    /*! 服务期限 */
    self.serverTime = [UILabel new];
    self.serverTime.font = UIFontSystem14;
    self.serverTime.textColor = UIColorBlackTheme;
    [serverBgView addSubview:self.serverTime];
    self.serverTime.sd_layout.leftSpaceToView(serverBgView, 15).rightSpaceToView(serverBgView, 5).topSpaceToView(self.serverVersion, 0).heightIs(25);
    /*! 应收款 */
    self.receivables = [UILabel new];
    self.receivables.font = UIFontSystem14;
    self.receivables.textColor = UIColorBlackTheme;
    self.receivables.text = @"金额：";
    [serverBgView addSubview:self.receivables];
    self.receivables.sd_layout.leftSpaceToView(serverBgView, 15).widthIs(72).topSpaceToView(self.serverTime, 0).heightIs(25);
    /*! 应付收款 */
    self.allreceivables = [UILabel new];
    self.allreceivables.font = UIFontSystem14;
    self.allreceivables.textColor = UIColorBlackTheme;
    [serverBgView addSubview:self.allreceivables];
    self.allreceivables.sd_layout.leftSpaceToView(self.receivables, 0).widthIs(100).topSpaceToView(self.serverTime, 0).heightIs(25);

    /*! 实付收款 */
    self.factreceivables = [UILabel new];
    self.factreceivables.font = UIFontSystem14;
    self.factreceivables.textColor = UIColorBlackTheme;
    [serverBgView addSubview:self.factreceivables];
//    self.factreceivables.sd_layout.leftSpaceToView(self.allreceivables, 10).rightSpaceToView(serverBgView, 15).topSpaceToView(self.serverTime, 0).heightIs(25);

    /*! 赠送日期 */
    self.giveTime = [UILabel new];
    self.giveTime.font = UIFontSystem14;
    self.giveTime.textColor = UIColorBlackTheme;
    [serverBgView addSubview:self.giveTime];
    self.giveTime.sd_layout.leftSpaceToView(serverBgView, 15).rightSpaceToView(serverBgView, 5).topSpaceToView(self.receivables, 0).heightIs(25);
    /*! 赠送期限 */
    self.giveDay = [UILabel new];
    self.giveDay.font = UIFontSystem14;
    self.giveDay.textColor = UIColorBlackTheme;
    [serverBgView addSubview:self.giveDay];
    self.giveDay.sd_layout.leftSpaceToView(serverBgView, 15).rightSpaceToView(serverBgView, 5).topSpaceToView(self.giveTime, 0).heightIs(25);
    /*! ================================投顾军团信息========================================== */
    /*! 军团名称 */
    UILabel *legionTipName = [UILabel new];
    legionTipName.font = UIFontSystem15;
    legionTipName.textColor = UIColorBlackTheme;
    legionTipName.text = @"投顾军团信息";
    [self addSubview:legionTipName];
    legionTipName.sd_layout.leftSpaceToView(self, 15).rightSpaceToView(self, 15).topSpaceToView(serverBgView, 10).heightIs(34);
    
    /*! 查看详情 */
    UIButton *checkMoreBtn = [UIButton new];
    [checkMoreBtn setTitle:@"详情>>" forState:UIControlStateNormal];
    checkMoreBtn.titleLabel.font = UIFontSystem13;
    [checkMoreBtn setTitleColor:UIColorRedTheme forState:UIControlStateNormal];
    [checkMoreBtn addTarget:self action:@selector(checkMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:checkMoreBtn];
    checkMoreBtn.sd_layout.rightSpaceToView(self, 0).topSpaceToView(serverBgView, 10).widthIs(80).heightIs(34);

    /*! 军团内容 */
    self.legionBgView = [UIView new];
    self.legionBgView.backgroundColor = UIColorWhite;
    [self addSubview:self.legionBgView];
    self.legionBgView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(legionTipName, 0).heightIs(100);
    /*! 军团名称 */
    self.legionName = [UILabel new];
    self.legionName.font = UIFontSystem14;
    self.legionName.textColor = UIColorBlackTheme;
    [self.legionBgView addSubview:self.legionName];
    self.legionName.sd_layout.leftSpaceToView(self.legionBgView, 15).rightSpaceToView(self.legionBgView, 15).topSpaceToView(self.legionBgView, 10).heightIs(25);
    /*! 带头人 */
    self.leaderName = [UILabel new];
    self.leaderName.font = UIFontSystem14;
    self.leaderName.textColor = UIColorBlackTheme;
    [self.legionBgView addSubview:self.leaderName];
    self.leaderName.sd_layout.leftSpaceToView(self.legionBgView, 15).rightSpaceToView(self.legionBgView, 15).topSpaceToView(self.legionName, 0).heightIs(25);
    /*! 军团风格 */
    self.legioStyle = [UILabel new];
    self.legioStyle.font = UIFontSystem14;
    self.legioStyle.textColor = UIColorBlackTheme;
    self.legioStyle.numberOfLines = 0;
    [self.legionBgView addSubview:self.legioStyle];
    self.legioStyle.sd_layout.leftSpaceToView(self.legionBgView, 15).rightSpaceToView(self.legionBgView, 15).topSpaceToView(self.leaderName, 0).heightIs(25);
    /*! ================================合同信息========================================== */
    /*! 合同名称 */
    UILabel *contractName = [UILabel new];
    contractName.font = UIFontSystem15;
    contractName.textColor = UIColorBlackTheme;
    contractName.text = @"合同信息";
    [self addSubview:contractName];
    contractName.sd_layout.leftSpaceToView(self, 15).rightSpaceToView(self, 15).topSpaceToView(self.legionBgView, 10).heightIs(34);
}

-(void)checkMoreBtnClick:(UIButton *)sender
{
    if (self.jumpToLegionDetail) {
        self.jumpToLegionDetail();
    }
}

-(void)setOrderDic:(NSDictionary *)orderDic
{
    /*! ========订单编号========= */
    self.orderNum.text = [NSString stringWithFormat:@"订单编号：%@",orderDic[@"order_sn"]];
    /*! ========客户姓名========= */
    /*! 加星 */
    NSString *nameStr= orderDic[@"full_name"];
    NSString *customNameStr = [orderDic[@"full_name"] stringByReplacingOccurrencesOfString:[orderDic[@"full_name"] substringWithRange:NSMakeRange(1,nameStr.length-1)]withString:@"**"];
    self.customName.text = [NSString stringWithFormat:@"客户姓名：%@",customNameStr];
    /*! ========身份证号========= */
    
    NSString *cartStr= [NSString stringWithFormat:@"%@",orderDic[@"idcard"]];
    if ([cartStr isEqualToString:@"<null>"]||[cartStr isEqualToString:@"(null)"]||cartStr.length==0) {
        self.customIdCart.text = [NSString stringWithFormat:@"身份证号："];
    }else{
        NSString *idCartStr = [orderDic[@"idcard"] stringByReplacingOccurrencesOfString:[orderDic[@"idcard"] substringWithRange:NSMakeRange(3,cartStr.length-7)]withString:@"***********"];
        self.customIdCart.text = [NSString stringWithFormat:@"身份证号：%@",idCartStr];
    }
    /*! ========手机号========= */
    NSString *telStr= orderDic[@"user_phone"];
    NSString *phoneStr = [orderDic[@"user_phone"] stringByReplacingOccurrencesOfString:[orderDic[@"user_phone"] substringWithRange:NSMakeRange(3,telStr.length-7)]withString:@"****"];
    self.phoneNum.text = [NSString stringWithFormat:@"手机号：%@",phoneStr];
    /*! ========下单时间========= */
    self.orderTime.text = [NSString stringWithFormat:@"下单时间：%@",orderDic[@"order_time"]];
    /*! ========订单状态========= */
    self.orderState.text = [NSString stringWithFormat:@"订单状态：%@",orderDic[@"state"]];
    /*! ========服务版本========= */
    self.serverVersion.text = [NSString stringWithFormat:@"服务版本：%@",orderDic[@"product_name"]];
    /*! ========服务期限========= */
    NSString *serverSrart = [NSString stringWithFormat:@"%@",orderDic[@"start"]];
    NSString *serverend = [NSString stringWithFormat:@"%@",orderDic[@"end"]];
    if (serverSrart.length==0||serverend.length==0) {
        self.serverTime.text = [NSString stringWithFormat:@"服务期限：%@",orderDic[@"term_name"]];
    }else{
        self.serverTime.text = [NSString stringWithFormat:@"服务期限：%@-%@",orderDic[@"start"],orderDic[@"end"]];
    }
    /*! ========金额========= */
    /*! 订单状态 */
    NSString *orderState = [NSString stringWithFormat:@"%@",orderDic[@"state"]];

    if ([orderState isEqualToString:@"审核中"]) {
        self.receivables.text = @"产品金额:";
        self.allreceivables.text = [NSString stringWithFormat:@"%@",orderDic[@"order_amount"]];
    }else if ([orderState isEqualToString:@"已开通"]){
        self.receivables.text = @"实收金额:";
        self.allreceivables.text = [NSString stringWithFormat:@"%@",orderDic[@"paid_amount"]];
    }else{
        self.receivables.text = @"应付金额:";
        self.allreceivables.text = [NSString stringWithFormat:@"%@",orderDic[@"order_realamount"]];
    }
    
//    NSString *amountStr = [NSString stringWithFormat:@"%@",orderDic[@"order_amount"]];
//    CGFloat width = [self getWidthWithTitle:amountStr font:UIFontSystem14];
//    DDLog(@"width======%f",width);
//    NSString *realamountStr = [NSString stringWithFormat:@"%@",orderDic[@"order_realamount"]];
//    if (![amountStr isEqualToString:@"(null)"]) {
//        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",amountStr]];
//        NSRange contentRange = {0,amountStr.length};
//        [content addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
//        self.allreceivables.attributedText = content;
//        self.factreceivables.hidden = NO;
//        self.factreceivables.text = realamountStr;
//        self.factreceivables.sd_layout.leftSpaceToView(self.allreceivables,-100+width+10).rightSpaceToView(serverBgView, 15).topSpaceToView(self.serverTime, 0).heightIs(25);
//    }else{
//        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",realamountStr]];
//        self.allreceivables.attributedText = content;
//        self.factreceivables.hidden = YES;
//    }
    // 赋值
    
    /*! ========赠送期限========= */
    NSString *giveSrart = [NSString stringWithFormat:@"%@",orderDic[@"givestart"]];
    NSString *giveend = [NSString stringWithFormat:@"%@",orderDic[@"giveend"]];
    if (giveSrart.length==0||giveend.length==0) {
        self.giveTime.text = [NSString stringWithFormat:@"赠送期限："];
    }else{
        self.giveTime.text = [NSString stringWithFormat:@"赠送期限：%@-%@",orderDic[@"givestart"],orderDic[@"giveend"]];
    }
    /*! ========赠送天数========= */
    NSString *giveDay = [NSString stringWithFormat:@"%@",orderDic[@"give_day"]];
    if (giveDay.length==0||giveDay==nil) {
        self.giveDay.text = [NSString stringWithFormat:@""];
    }else{
        self.giveDay.text = [NSString stringWithFormat:@"赠送天数：%@",giveDay];
    }
}

/*! 获取文本宽度 */
- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

-(void)setLegionDic:(NSDictionary *)legionDic
{
    /*! ========军团名称========= */
    self.legionName.text = [NSString stringWithFormat:@"军团名称：%@",legionDic[@"lrving_name"]];
    /*! ========带头人========= */
    self.leaderName.text = [NSString stringWithFormat:@"军团成员：%@",legionDic[@"lrving_username"]];
    CGFloat contentStrHight1 = [self.leaderName.text heightWithLabelFont:UIFontSystem14 withLabelWidth:Main_Screen_Width-30];
    self.leaderName.sd_layout.heightIs(contentStrHight1+8);
    /*! ========军团风格========= */
    self.legioStyle.text = [NSString stringWithFormat:@"军团风格：%@",legionDic[@"lrving_style"]];
    CGFloat contentStrHight = [self.legioStyle.text heightWithLabelFont:UIFontSystem14 withLabelWidth:Main_Screen_Width-30];
        self.legioStyle.sd_layout.heightIs(contentStrHight+8);
}

@end
