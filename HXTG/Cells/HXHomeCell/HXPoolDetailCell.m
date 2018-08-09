//
//  HXPoolDetailCell.m
//  HXTG
//
//  Created by grx on 2017/3/27.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXPoolDetailCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@implementation HXPoolDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell];
        [self layoutFrame];
    }
    return self;
}

-(void)createCell
{
    
    /*! 标题 */
    titleLable = [UILabel new];
    titleLable.textColor = UIColorRedTheme;
    titleLable.font = UIFontSystem13;
    /*! 内容 */
    contentLable = [UILabel new];
    contentLable.textColor = UIColorWhite;
    contentLable.font = UIFontSystem13;
    /*! 时间 */
    timeLable = [UILabel new];
    timeLable.textColor = UIColorWhite;
    timeLable.font = UIFontSystem15;
    timeLable.textAlignment = NSTextAlignmentCenter;
    /*! 日期 */
    dateLable = [UILabel new];
    dateLable.textColor = UIColorLightTheme;
    dateLable.font = UIFontSystem14;
    dateLable.textAlignment = NSTextAlignmentCenter;
    /*! 进度图片 */
    speedImage = [UIImageView new];
    /*! 上分割线 */
    self.upLine = [UIView new];
    self.upLine.backgroundColor = UIColorLightTheme;
    /*! 下分割线 */
    self.downLine = [UIView new];
    self.downLine.backgroundColor = UIColorLightTheme;
    
    bgView = [UIView new];
    bgView.layer.cornerRadius = 5;
    bgView.backgroundColor = ColorWithRGB(153, 153, 153);
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = ColorWithRGB(153, 153, 153).CGColor;
    
    [self.contentView addSubview:bgView];
    [self.contentView addSubview:titleLable];
    [self.contentView addSubview:contentLable];
    [self.contentView addSubview:timeLable];
    [self.contentView addSubview:dateLable];
    [self.contentView addSubview:speedImage];
    [self.contentView addSubview:self.upLine];
    [self.contentView addSubview:self.downLine];

}

-(void)layoutFrame
{

    timeLable.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,5)
    .widthIs(80)
    .heightIs(35);
    
    dateLable.sd_layout
    .topSpaceToView(timeLable,-15)
    .leftSpaceToView(self.contentView,7)
    .widthIs(80)
    .heightIs(35);
    
    speedImage.sd_layout
    .topSpaceToView(self.contentView, 30)
    .leftSpaceToView(timeLable, 5)
    .widthIs(22)
    .heightIs(22);
    
    self.upLine.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(timeLable, 16)
    .widthIs(1)
    .heightIs(29);
    
    self.downLine.sd_layout
    .topSpaceToView(speedImage, 0)
    .leftSpaceToView(timeLable, 16)
    .widthIs(1);
    
    titleLable.sd_layout
    .topSpaceToView(self.contentView, 35)
    .rightSpaceToView(self.contentView, 30)
    .leftSpaceToView(timeLable, 55)
    .heightIs(20);
    
    contentLable.sd_layout
    .topSpaceToView(titleLable, 3)
    .rightSpaceToView(self.contentView, 30)
    .leftSpaceToView(timeLable, 55)
    .autoHeightRatio(0);
    
    bgView.sd_layout
    .topSpaceToView(self.contentView, 30)
    .leftSpaceToView(timeLable, 45)
    .rightSpaceToView(self.contentView, 25);
}

- (void)setModel:(HXPoolDetailModel *)model
{
    _model = model;
    timeLable.text = model.hour;
    dateLable.text = model.day;
    
    NSString *stateStr = [NSString stringWithFormat:@"%@",model.stock_opert_state];
    if ([stateStr isEqualToString:@"买入建议"] ||[stateStr isEqualToString:@"加仓建议"] ||[stateStr isEqualToString:@"清仓建议"] ||[stateStr isEqualToString:@"建仓建议"]) {
        titleLable.hidden = YES;
        contentLable.sd_layout
        .topSpaceToView(self.contentView, 40)
        .rightSpaceToView(self.contentView, 30)
        .leftSpaceToView(timeLable, 55)
        .autoHeightRatio(0);
        
        contentLable.text = model.stock_oper_desc;
    }else{
        titleLable.hidden = NO;
        titleLable.text = model.stock_opert_state;
        contentLable.sd_layout
        .topSpaceToView(titleLable, 3)
        .rightSpaceToView(self.contentView, 30)
        .leftSpaceToView(timeLable, 55)
        .autoHeightRatio(0);
         contentLable.text = model.stock_oper_desc;
}
    
    if ([stateStr isEqualToString:@"清仓"]) {
        speedImage.image = [UIImage imageNamed:@"qingcang"];
        titleLable.textColor = UIColorRedTheme;
        contentLable.textColor = UIColorWhite;
        /*! 清仓建议富文本 */
        [self addQCAttrDescribe:model.stock_oper_desc withChangeDesc:model.selling_price withColor:UIColorRedTheme];
        [self reSetSpeedImageFrame];
    }else if ([stateStr isEqualToString:@"减仓"]){
        speedImage.image = [UIImage imageNamed:@"jiancang"];
        titleLable.textColor = ColorWithHexRGB(0x40a44f);
        contentLable.textColor = UIColorWhite;
        [self reSetSpeedImageFrame];
    }else if ([stateStr isEqualToString:@"加仓"]||[stateStr isEqualToString:@"建仓"]){
        speedImage.image = [UIImage imageNamed:@"jiacang"];
        titleLable.textColor = UIColorRedTheme;
        contentLable.textColor = UIColorRedTheme;
        /*! 加仓建仓富文本 */
        [self addBuyAttrDescribe:model.stock_oper_desc BidPrice:@"买入价:" StopPrice:@"止损价:" SurplusPrice:@"止盈价:" PositionRatio:@"仓位占比:"];
        [self reSetSpeedImageFrame];
    }else if ([stateStr isEqualToString:@"持有"]){
        speedImage.image = [UIImage imageNamed:@"chiyou"];
        titleLable.textColor = ColorWithHexRGB(0xf76e47);
        contentLable.textColor = UIColorWhite;
        [self reSetSpeedImageFrame];
    }else if ([stateStr isEqualToString:@"买入"]){
        speedImage.image = [UIImage imageNamed:@"mairu"];
        titleLable.textColor = UIColorRedTheme;
        contentLable.textColor = UIColorRedTheme;
        /*! 加仓建仓富文本 */
        [self addBuyAttrDescribe:model.stock_oper_desc BidPrice:@"买入价:" StopPrice:@"止损价:" SurplusPrice:@"止盈价:" PositionRatio:@"仓位占比:"];
        [self reSetSpeedImageFrame];
    }else if ([stateStr isEqualToString:@"观望"]||[stateStr isEqualToString:@"取消观望"]){
        speedImage.image = [UIImage imageNamed:@"guanwang"];
        titleLable.textColor = ColorWithHexRGB(0x2f89ff);
        contentLable.textColor = UIColorWhite;
        [self reSetSpeedImageFrame];
    }else if ([stateStr isEqualToString:@"买入建议"] ||[stateStr isEqualToString:@"加仓建议"] ||[stateStr isEqualToString:@"清仓建议"]||[stateStr isEqualToString:@"建仓建议"] ){
        speedImage.image = [UIImage imageNamed:@"hongse"];
        contentLable.textColor = UIColorWhite;
        speedImage.sd_layout
        .topSpaceToView(self.contentView, 30)
        .leftSpaceToView(timeLable, 10.5)
        .widthIs(12)
        .heightIs(12);
    }else{
        contentLable.textColor = UIColorWhite;
    }
    
    
    
    CGFloat bottomMargin = 10;

    //***********************高度自适应cell设置步骤************************
    
    [self setupAutoHeightWithBottomView:contentLable bottomMargin:bottomMargin];
}

-(void)reSetSpeedImageFrame
{
    speedImage.sd_layout
    .topSpaceToView(self.contentView, 30)
    .leftSpaceToView(timeLable, 5)
    .widthIs(22)
    .heightIs(22);
}

-(void)setHight:(CGFloat)hight
{
    //初始化段落，设置段落风格
    NSMutableParagraphStyle *paragraphstyle=[[NSMutableParagraphStyle alloc]init];
    paragraphstyle.lineBreakMode=NSLineBreakByCharWrapping;
    //设置label的字体和段落风格
    NSDictionary *dic=@{NSFontAttributeName:contentLable.font,NSParagraphStyleAttributeName:paragraphstyle.copy};
    //计算label的真正大小,其中宽度和高度是由段落字数的多少来确定的，返回实际label的大小
    CGRect rect=[contentLable.text boundingRectWithSize:CGSizeMake(Main_Screen_Width-160, hight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    contentLable.sd_layout.widthIs(rect.size.width);
    bgView.sd_layout
    .topSpaceToView(self.contentView, 30)
    .leftSpaceToView(timeLable, 45)
    .widthIs(rect.size.width+20)
    .heightIs(hight);
    self.downLine.sd_layout.heightIs(hight);
}

/*! 处理清仓富文本 */
-(void)addQCAttrDescribe:(NSString *)stockDesc withChangeDesc:(NSString *)changeDesc withColor:(id)changeColor
{
    NSMutableAttributedString *attrDescribeStr = [[NSMutableAttributedString alloc] initWithString:stockDesc];
    if (changeDesc!=nil) {
        [attrDescribeStr addAttribute:NSForegroundColorAttributeName
                                value:changeColor
                                range:[stockDesc rangeOfString:changeDesc]];
    }    
    contentLable.attributedText = attrDescribeStr;
}

/*! 处理买入/加仓富文本 */
-(void)addBuyAttrDescribe:(NSString *)stockDesc BidPrice:(NSString *)bidPrice StopPrice:(NSString *)stopPrice SurplusPrice:(NSString *)surplusPrice PositionRatio:(NSString *)positionRatio
{
    NSMutableAttributedString *attrDescribeStr = [[NSMutableAttributedString alloc] initWithString:stockDesc];

    if (bidPrice!=nil) {
    [attrDescribeStr addAttribute:NSForegroundColorAttributeName
                            value:UIColorWhite
                            range:[stockDesc rangeOfString:bidPrice]];
    }
    if (stopPrice!=nil) {
    [attrDescribeStr addAttribute:NSForegroundColorAttributeName
                            value:UIColorWhite
                            range:[stockDesc rangeOfString:stopPrice]];
    }
    if (surplusPrice!=nil) {
    [attrDescribeStr addAttribute:NSForegroundColorAttributeName
                            value:UIColorWhite
                            range:[stockDesc rangeOfString:surplusPrice]];
    }
    if (positionRatio!=nil) {
    [attrDescribeStr addAttribute:NSForegroundColorAttributeName
                            value:UIColorWhite
                            range:[stockDesc rangeOfString:positionRatio]];
    }
    contentLable.attributedText = attrDescribeStr;
}


@end
