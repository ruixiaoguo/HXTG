//
//  HXMyCacheCell.m
//  HXTG
//
//  Created by grx on 2017/4/11.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMyCacheCell.h"

@implementation HXMyCacheCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorWhite;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self markCell];
    }
    return self;
}

-(void)markCell
{
    /*! 分割线 */
    UIView *downLineViwe = [UIView new];
    downLineViwe.backgroundColor = UIColorBgLightTheme;
//    [self.contentView addSubview:downLineViwe];
    downLineViwe.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(5);
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = UIFontSystem14;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,8).rightSpaceToView(self.contentView,15).heightIs(20);
    /*! 进度条 */
    self.progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    //设置的高度对进度条的高度没影响，整个高度=进度条的高度，进度条也是个圆角矩形
    //但slider滑动控件：设置的高度对slider也没影响，但整个高度=设置的高度，可以设置背景来检验
    //设置进度条颜色
    self.progressView.trackTintColor = UIColorLineTheme;
    //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
    [self.progressView setProgress:0.0 animated:NO];
    //设置进度条上进度的颜色
    self.progressView.progressTintColor = [UIColor redColor];
    [self.contentView addSubview:self.progressView];
    self.progressView.sd_layout.leftEqualToView(self.titleLable).rightSpaceToView(self.contentView,60).topSpaceToView(self.titleLable,6).heightIs(10);

        /*! 下载状态 */
    self.downLoadLable = [UILabel new];
    self.downLoadLable.font = UIFontSystem12;
    self.downLoadLable.textColor = UIColorLightTheme;
    [self.contentView addSubview:self.downLoadLable];
    self.downLoadLable.sd_layout.leftEqualToView(self.titleLable).rightEqualToView(self.titleLable).bottomSpaceToView(self.contentView,0).heightIs(30);
}

-(void)setCacheModel:(HXMyCacheModel *)cacheModel
{
    self.titleLable.text = cacheModel.title;
    self.downLoadLable.text = cacheModel.downLoadState;
    [self.progressView setProgress:cacheModel.f animated:NO];
}

@end


#pragma mark - 编辑状态下cell
@implementation HXMyEditCacheCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorWhite;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self markCell];
    }
    return self;
}

-(void)markCell
{
    /*! 分割线 */
    UIView *downLineViwe = [UIView new];
    downLineViwe.backgroundColor = UIColorBgLightTheme;
//    [self.contentView addSubview:downLineViwe];
    downLineViwe.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(5);
    /*! 选择按钮 */
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"yuan1"] forState:UIControlStateNormal];
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"yuan2"] forState:UIControlStateSelected];
    [self.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectButton];
    self.selectButton.sd_layout.leftSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).widthIs(20).heightIs(20);

    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = UIFontSystem14;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.selectButton,15).topSpaceToView(self.contentView,8).rightSpaceToView(self.contentView,25).heightIs(20);

    /*! 下载状态 */
    self.downLoadLable = [UILabel new];
    self.downLoadLable.font = UIFontSystem12;
    self.downLoadLable.textColor = UIColorLightTheme;
    [self.contentView addSubview:self.downLoadLable];
    self.downLoadLable.sd_layout.leftEqualToView(self.titleLable).rightEqualToView(self.titleLable).bottomSpaceToView(self.contentView,0).heightIs(30);
    
}

-(void)setCacheModel:(HXMyCacheModel *)cacheModel
{
    self.titleLable.text = cacheModel.title;
    self.downLoadLable.text = cacheModel.downLoadState;
    self.selectButton.selected = cacheModel.isSelect;

}

-(void)selectButtonClick:(UIButton *)sender
{
    if (self.selectBtnClick) {
        self.selectBtnClick();
    }
}


@end

