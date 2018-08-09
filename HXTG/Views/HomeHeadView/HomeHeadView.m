//
//  HXHomeHeadView.m
//  HXTG
//
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HomeHeadView.h"


@implementation HomeHeadView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = ColorWithHexRGB(0xf0f0f0);
        [self markeHeadView];
    }
    return self;
}

/*! 创建HomeView */
-(void)markeHeadView
{
//    NSMutableArray *imageUrlArray = [NSMutableArray arrayWithCapacity:0];
//
//    NSArray *urlArray = @[@"http://img14.photophoto.cn/20100319/0008020330145946_s.jpg",@"http://www.eeppt.com/uploads/allimg/201503/011/yepptbjtp011.jpg",@"http://img29.photophoto.cn/20131129/0020033173254286_s.jpg"];
//    /*! 测试数据 */
//    for (int i=0; i<3; i++) {
//        AdboardModel *adverModel = [[AdboardModel alloc]init];
//        adverModel.src = urlArray[i];
//        [imageUrlArray addObject:adverModel];
//    }
    /*! 广告位 */
    self.adboardView = [[HXAdboardView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height/3.28)];
    DDLog(@"adboardView=====%f",Main_Screen_Height/173);
    [self addSubview:self.adboardView];
    WeakSelf(weakSelf);
    self.adboardView.tapAdboardView = ^(AdboardModel *model){
        if (weakSelf.tapHXAdboardView) {
            weakSelf.tapHXAdboardView(model);
        }
    };
    /*! 栏目位 */
    WeakSelf(WeakSelf);
    /*! 北京事业部 */
    
    self.columnView = [[HXColumnView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.adboardView.frame), Main_Screen_Width, 210)];
    [self addSubview:self.columnView];
    self.columnView.cqColumnClickBlock = ^(NSInteger columnTag){
        if (WeakSelf.cqHeadColumClick) {
            WeakSelf.cqHeadColumClick(columnTag);
        }
    };
    self.columnView.bjColumnClickBlock = ^(NSInteger columnTag){
        if (WeakSelf.bjHeadColumClick) {
            WeakSelf.bjHeadColumClick(columnTag);
        }
    };
    /*! 每日一股 */
    self.stockView = [[HXStockView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.columnView.frame)+10, Main_Screen_Width, 140)];
    [self addSubview:self.stockView];
    self.stockView.stockViewClickBlock = ^(HXDailystockModel *stockModel){
        if (WeakSelf.everStockClickBlock) {
            WeakSelf.everStockClickBlock(stockModel);
        }
    };
    /*! 炒股攻略 */
    self.strateView = [[HXStrateView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.stockView.frame)+10, Main_Screen_Width, 30)];
    [self addSubview:self.strateView];
    /*! 手势 */
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(strateViewClickTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self.strateView addGestureRecognizer:singleRecognizer];
}

#pragma mark - 炒股攻略手势事件
-(void)strateViewClickTap:(UITapGestureRecognizer *)recognizer
{
    if (self.strateClickBlock) {
        self.strateClickBlock();
    }
}

-(void)setClumnHight:(CGFloat)ClumnHight
{
    self.columnView.frame = CGRectMake(0, CGRectGetMaxY(self.adboardView.frame), Main_Screen_Width, ClumnHight);
    self.stockView.frame = CGRectMake(0, CGRectGetMaxY(self.columnView.frame)+10, Main_Screen_Width, 140);
    self.strateView.frame = CGRectMake(0, CGRectGetMaxY(self.stockView.frame)+10, Main_Screen_Width, 30);

}

-(void)setIscheck:(NSString *)ischeck
{
    /*! 创建事业部 */
    [self.columnView markeHeadView:self.columnView isCheck:ischeck];
}


@end
