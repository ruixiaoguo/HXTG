//
//  HXEveDayHeadView.m
//  HXTG
//
//  Created by grx on 2017/3/27.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXEveDayHeadView.h"

@implementation HXEveDayHeadView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = UIColorWhite;
        [self markeView];
    }
    return self;
}

/*! 每日一股详情头部 */
-(void)markeView
{
    /*! 标题 */
    titleLable = [UILabel new];
    titleLable.font = UIFontSystem14;
    titleLable.textColor = UIColorBlackTheme;
    [self addSubview:titleLable];
    titleLable.sd_layout.leftSpaceToView(self,15).rightSpaceToView(self,60).topSpaceToView(self,0).heightIs(35);
    /*! 时间 */
    timeLable = [UILabel new];
    timeLable.font = UIFontSystem11;
    timeLable.textColor = UIColorLightTheme;
    timeLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:timeLable];
    timeLable.sd_layout.rightSpaceToView(self,15).topSpaceToView(self,0).widthIs(150).heightIs(35);
    
    /*! 内容小标题 */
    NSArray *titleArray = @[@"昨收",@"市值",@"换手率",@"市盈率",@"12138.12元",@"212.23亿元",@"88.88%",@"22.22%"];
    for (int i=0; i<2; i++) {
        for (int j=0; j<4; j++) {
            UILabel *columLable = [[UILabel alloc]init];
            float lableHight = 20;
            columLable.frame = CGRectMake(0, 0, 80, lableHight);
            columLable.centerX = (j*2+1)*Main_Screen_Width/8;
            columLable.centerY = 53+i*35;
            columLable.textAlignment = NSTextAlignmentCenter;
            columLable.font = UIFontSystem13;
            columLable.textColor = UIColorBlackTheme;
            [self addSubview:columLable];
            columLable.tag = 100+i*10+j;
            if (i==0) {
                columLable.text = titleArray[columLable.tag-100];
            }else{
                columLable.text = titleArray[columLable.tag-106];
                columLable.textColor = UIColorHigRedTheme;
            }
        }
    }
    /*! 分割线 */
    for (int i=0; i<3; i++) {
        /*! 横向 */
        UIView *herView = [UIView new];
        herView.backgroundColor = UIColorBgLightTheme;
        [self addSubview:herView];
        herView.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).topSpaceToView(self,34+i*35).heightIs(1);
        /*! 纵向 */
        UIView *verView = [UIView new];
        verView.backgroundColor = UIColorBgLightTheme;
        [self addSubview:verView];
        verView.sd_layout.leftSpaceToView(self,(i+1)*Main_Screen_Width/4).widthIs(1).topSpaceToView(self,34).heightIs(70);
    }
    
    /*! 推荐理由 */
    UIView *reasionView = [UIView new];
    reasionView.backgroundColor = UIColorRedTheme;
    [self addSubview:reasionView];
    reasionView.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0).heightIs(30);
    UILabel *reasionLable = [UILabel new];
    reasionLable.font = UIFontSystem13;
    reasionLable.textColor = UIColorWhite;
    reasionLable.text = @"推荐理由";
    [reasionView addSubview:reasionLable];
    reasionLable.sd_layout.leftSpaceToView(reasionView,15).topSpaceToView(reasionView,0).widthIs(200).heightIs(30);
}

-(void)setModel:(HXDailystockModel *)model
{
    if ([model.shares_name isEqualToString:@"(null)"]||model.shares_name.length==0) {
        titleLable.text = [NSString stringWithFormat:@""];
    }else{
        titleLable.text = [NSString stringWithFormat:@"%@ %@",model.shares_name,model.shares_code];
    }
    timeLable.text = [NSString stringWithFormat:@"华讯投资"];
    UILabel *shares_yes = (UILabel *)[self viewWithTag:110];
    UILabel *shares_value = (UILabel *)[self viewWithTag:111];
    UILabel *shares_conversion = (UILabel *)[self viewWithTag:112];
    UILabel *shares_earning = (UILabel *)[self viewWithTag:113];
    NSString *valueStr = [NSString stringWithFormat:@"%@",model.shares_yes];
    if ([valueStr isEqualToString:@"(null)"]||valueStr.length==0) {
        shares_yes.text = [NSString stringWithFormat:@""];
        shares_value.text = [NSString stringWithFormat:@""];
        shares_conversion.text = [NSString stringWithFormat:@""];
        shares_earning.text = [NSString stringWithFormat:@""];
    }else{
        shares_yes.text = [NSString stringWithFormat:@"%@元",model.shares_yes];
        shares_value.text = [NSString stringWithFormat:@"%@亿元",model.shares_value];
        shares_conversion.text = [NSString stringWithFormat:@"%@%%",model.shares_conversion];
        shares_earning.text = [NSString stringWithFormat:@"%@倍",model.shares_earning];
    }
}

@end
