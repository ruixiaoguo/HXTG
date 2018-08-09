//
//  HXStockPoolHeadView.m
//  HXTG
//
//  Created by grx on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXStockPoolHeadView.h"

@implementation HXStockPoolHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorBgLightTheme;
        [self markeView];
    }
    return self;
}

-(void)markeView
{
    /*! 股票风格 */
    NSArray *styleArray = [NSArray arrayWithObjects:@"全部",@"短线",@"中线",@"长线",nil];
    UISegmentedControl *styleSegment = [[UISegmentedControl alloc]initWithItems:styleArray];
    styleSegment.selectedSegmentIndex = 0;
    styleSegment.tintColor = UIColorRedTheme;
    [self addSubview:styleSegment];
    styleSegment.sd_layout.leftSpaceToView(self,15).topSpaceToView(self,10).rightSpaceToView(self,15).heightIs(35);
    [styleSegment addTarget:self action:@selector(styleSegmentChange:) forControlEvents:UIControlEventValueChanged];
}


/*! 全部/短信/中线 */
-(void)styleSegmentChange:(UISegmentedControl *)sender{
    if (self.styleSelectAction) {
        self.styleSelectAction(sender.selectedSegmentIndex);
    }
}


@end
