//
//  HXStrateView.m
//  HXTG
//
//  Created by grx on 2017/3/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXStrateView.h"

@implementation HXStrateView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = UIColorWhite;
        [self markeView];
    }
    return self;
}

/*! 炒股攻略 */
-(void)markeView
{
    
    /*! stockHeaderView */
    UIView *stockHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    stockHeaderView.backgroundColor = [UIColor whiteColor];
    [self addSubview:stockHeaderView];
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 29, Main_Screen_Width, 1)];
    lineView1.backgroundColor = UIColorBgLightTheme;
    [stockHeaderView addSubview:lineView1];

    /*! 标题 */
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, stockHeaderView.frame.size.height)];
    titleLable.text = @"炒股攻略";
    titleLable.font = UIFontSystem12;
    titleLable.textColor = UIColorBlackTheme;
    [stockHeaderView addSubview:titleLable];
    /*! 更多 */
    UILabel *dateLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-195, 0, 180, stockHeaderView.frame.size.height)];
    dateLable.textAlignment = NSTextAlignmentRight;
    dateLable.text = @"更多>>";
    dateLable.font = UIFontSystem12;
    dateLable.textColor = UIColorLightTheme;
    [stockHeaderView addSubview:dateLable];

}

@end
