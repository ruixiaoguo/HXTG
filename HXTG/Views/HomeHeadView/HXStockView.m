//
//  HXStockView.m
//  HXTG
//
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXStockView.h"

@implementation HXStockView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self markeHeadView];
    }
    return self;
}

/*! 创建每日一股View */
-(void)markeHeadView
{
    /*! stockHeaderView */
    UIView *stockHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    stockHeaderView.backgroundColor = UIColorWhite;
    [self addSubview:stockHeaderView];
    /*! 手势 */
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stockHeaderClickTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [stockHeaderView addGestureRecognizer:singleRecognizer];
    /*! 分割线 */
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 7, 5, stockHeaderView.frame.size.height-14)];
    lineView.layer.cornerRadius = 2;
    lineView.backgroundColor = ColorWithRGB(231, 150, 73);
//    [stockHeaderView addSubview:lineView];
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 29, Main_Screen_Width, 1)];
    lineView1.backgroundColor = UIColorBgLightTheme;
    [stockHeaderView addSubview:lineView1];

    /*! 标题 */
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, stockHeaderView.frame.size.height)];
    titleLable.text = @"每日一股";
    titleLable.font = UIFontSystem12;
    titleLable.textColor = UIColorBlackTheme;
    [stockHeaderView addSubview:titleLable];
    /*! 日期 */
    dateLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-195, 0, 180, stockHeaderView.frame.size.height)];
    dateLable.textAlignment = NSTextAlignmentRight;
    dateLable.font = UIFontSystem12;
    dateLable.textColor = UIColorLightTheme;
    [stockHeaderView addSubview:dateLable];
    
    /*! stockView */
    stockView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(stockHeaderView.frame), Main_Screen_Width, 110)];
    stockView.backgroundColor = UIColorWhite;
    [self addSubview:stockView];
    /*! 手势 */
    UITapGestureRecognizer* singleRecognizer1;
    singleRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stockHeaderClickTap1:)];
    singleRecognizer1.numberOfTapsRequired = 1;
    [stockView addGestureRecognizer:singleRecognizer1];
    /*! 标题 */
    for (int i=0; i<2; i++) {
        for (int j=0; j<2; j++) {
            UILabel *stockLable = [[UILabel alloc]init];
            float lableHight = 20;
            float herSpacing = Main_Screen_Width/2;
            float verSpacing = 21;
            stockLable.frame = CGRectMake(CGRectGetMaxX(lineView.frame)+j*herSpacing, 6+i*verSpacing, 40, lableHight);

            stockLable.font = [UIFont systemFontOfSize:12];
            stockLable.textAlignment = NSTextAlignmentLeft;
            stockLable.textColor = ColorWithRGB(168, 168, 168);
            [stockView addSubview:stockLable];
            stockLable.tag = i*10+j+1;
            switch (stockLable.tag) {
                case 1:
                    stockLable.text = @"昨收";
                    break;
                case 2:
                    stockLable.text = @"市值";
                    break;
                case 11:
                    stockLable.text = @"换手率";
                    break;
                case 12:
                    stockLable.text = @"市盈率";
                    break;
                default:
                    break;
            }
        }
    }
    /*! 内容 */
    for (int i=0; i<2; i++) {
        for (int j=0; j<2; j++) {
            UILabel *contentLable = [[UILabel alloc]init];
            float lableWidth = Main_Screen_Width/2-CGRectGetMaxX(lineView.frame)-5-50;
            float lableHight = 20;
            float herSpacing = Main_Screen_Width/2;
            float verSpacing = 21;
            contentLable.frame = CGRectMake(CGRectGetMaxX(lineView.frame)+58+j*herSpacing, 6+i*verSpacing, lableWidth, lableHight);
            contentLable.font = [UIFont systemFontOfSize:13];
            contentLable.textColor = [UIColor blackColor];
            [stockView addSubview:contentLable];
            contentLable.tag = i*100+j+100;
        }
    }
    /*! 推荐理由 */
    UILabel *bottemLable = (UILabel *)[stockView viewWithTag:11];
    reasionLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame), CGRectGetMaxY(bottemLable.frame)-4, 60, 30)];
    reasionLable.text = @"推荐理由";
    reasionLable.font = [UIFont systemFontOfSize:13];
    reasionLable.textColor = ColorWithRGB(168, 168, 168);
    [stockView addSubview:reasionLable];
    /*! 推荐内容 */
    reasionContion = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(reasionLable.frame)-2, CGRectGetMaxY(bottemLable.frame)-3, Main_Screen_Width-reasionLable.frame.size.width-30, 60)];
    reasionContion.numberOfLines = 3;
    reasionContion.font = UIFontSystem13;
    reasionContion.textColor = UIColorBlackTheme;
    [stockView addSubview:reasionContion];
    
}

-(void)setStockModel:(HXDailystockModel *)stockModel
{
    UILabel *bottemLable = (UILabel *)[stockView viewWithTag:11];
    reasionContion.frame = CGRectMake(CGRectGetMaxX(reasionLable.frame)-2, CGRectGetMaxY(bottemLable.frame)+3, Main_Screen_Width-reasionLable.frame.size.width-30, stockModel.reasionHight);
    dateLable.text = stockModel.shares_addtime;
    UILabel *shares_yes = (UILabel *)[self viewWithTag:100];
    UILabel *shares_value = (UILabel *)[self viewWithTag:101];
    UILabel *shares_conversion = (UILabel *)[self viewWithTag:200];
    UILabel *shares_earning = (UILabel *)[self viewWithTag:201];
    NSString *vlueStr = [NSString stringWithFormat:@"%@",stockModel.shares_yes];
    if ([vlueStr isEqualToString:@"(null)"]||vlueStr.length==0) {
        shares_yes.text = [NSString stringWithFormat:@""];
        shares_value.text = [NSString stringWithFormat:@""];
        shares_conversion.text = [NSString stringWithFormat:@""];
        shares_earning.text = [NSString stringWithFormat:@""];
    }else{
        shares_yes.text = [NSString stringWithFormat:@"%@元",stockModel.shares_yes];
        shares_value.text = [NSString stringWithFormat:@"%@亿元",stockModel.shares_value];
        shares_conversion.text = [NSString stringWithFormat:@"%@%%",stockModel.shares_conversion];
        shares_earning.text = [NSString stringWithFormat:@"%@倍",stockModel.shares_earning];
    }
    if (stockModel.shares_reason.length==0) {
        reasionContion.text = @"";
    }else{
        reasionContion.text = stockModel.shares_reason;
    }
    model = stockModel;
}

#pragma mark - 每日一股手势事件
-(void)stockHeaderClickTap:(UITapGestureRecognizer *)recognizer
{
    
    if (self.stockViewClickBlock) {
        self.stockViewClickBlock(model);
    }
}

#pragma mark - 每日一股手势事件
-(void)stockHeaderClickTap1:(UITapGestureRecognizer *)recognizer
{
    
    if (self.stockViewClickBlock) {
        self.stockViewClickBlock(model);
    }
}


@end
