//
//  MyCacheBotomVoew.m
//  HXTG
//
//  Created by grx on 2017/4/11.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "MyCacheBotomView.h"

@implementation MyCacheBotomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _selectButton = [UIButton new];
        [_selectButton setBackgroundColor:UIColorWhite];
        [_selectButton setTitle:@"全选" forState:UIControlStateNormal];
        [_selectButton setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
        [_selectButton.titleLabel setFont:UIFontSystem16];
        [_selectButton addTarget:self action:@selector(bottomAllselectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectButton];
        _selectButton.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,Main_Screen_Width/2-0.5).widthIs(Main_Screen_Width/2-0.5).heightIs(50);
        /*! 分割线 */
        UIView *lineView = [UIView new];
        lineView.backgroundColor = UIColorLineTheme;
        [self addSubview:lineView];
        lineView.sd_layout.leftSpaceToView(self,Main_Screen_Width/2).topSpaceToView(self,0).widthIs(1).heightIs(50);

        _cancleButton = [UIButton new];
        [_cancleButton setBackgroundColor:UIColorWhite];
        [_cancleButton setTitle:@"删除" forState:UIControlStateNormal];
        [_cancleButton.titleLabel setFont:UIFontSystem16];
        [_cancleButton setTitleColor:UIColorRedTheme forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(bottomAllCancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancleButton];
        _cancleButton.sd_layout.leftSpaceToView(_selectButton,1).rightSpaceToView(self,0).widthIs(Main_Screen_Width/2-0.5).heightIs(50);

    }
    return self;
}

/*! 全选 */
- (void)bottomAllselectButtonClick:(UIButton *)button
{
    if (self.bottomSelectButtonClick)
    {
        self.bottomSelectButtonClick(button);
    }
}

/*! 删除 */
-(void)bottomAllCancleButtonClick:(UIButton *)button
{
    if (self.bottomCancleButtonClick)
    {
        self.bottomCancleButtonClick(button);
    }
}

@end
