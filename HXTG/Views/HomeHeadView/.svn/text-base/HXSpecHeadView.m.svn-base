//
//  HXSpecHeadView.m
//  HXTG
//
//  Created by grx on 2017/3/27.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXSpecHeadView.h"

@implementation HXSpecHeadView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = UIColorWhite;
        [self markeView];
    }
    return self;
}

/*! 炒股攻略详情头部 */
-(void)markeView
{
    /*! 标题 */
    titleLable = [UILabel new];
    titleLable.font = UIFontSystem16;
    titleLable.textColor = UIColorBlackTheme;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLable];
    titleLable.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).topSpaceToView(self,0).heightIs(35);
    /*! 时间 */
    self.timeLable = [UILabel new];
    self.timeLable.font = UIFontSystem11;
    self.timeLable.textColor = UIColorLightTheme;
    self.timeLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.timeLable];
    self.timeLable.sd_layout.rightSpaceToView(self,15).topSpaceToView(titleLable, -5).widthIs(150).heightIs(20);
    
}

-(void)setModel:(HXHomeCellModel *)model
{
    titleLable.text = model.post_title;
    self.timeLable.text = [NSString stringWithFormat:@"%@ 华讯投资",model.post_date];
}

@end
