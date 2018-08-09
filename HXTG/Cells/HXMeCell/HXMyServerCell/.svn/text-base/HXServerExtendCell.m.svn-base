//
//  HXServerExtendCell.m
//  HXTG
//
//  Created by grx on 2017/4/1.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXServerExtendCell.h"

@implementation HXServerExtendCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *upLine=[UIView new];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        upLine.backgroundColor = UIColorBgLightTheme;
        [self.contentView addSubview:upLine];
        upLine.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(1);
        [self markCell];
    }
    return self;
}

-(void)markCell
{
    
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = UIFontSystem14;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,0).rightSpaceToView(self.contentView, 15).heightIs(45);
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    self.titleLable.text = infoDic[@"title"];
}

@end



#pragma mark - 服务周期
@implementation HXServerCycleCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self markCell];
    }
    return self;
}

-(void)markCell
{
    /*! 单选按钮 */
    self.selectBtn = [UIButton new];
    [self.selectBtn setImage:[UIImage imageNamed:@"yuan1"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"yuan2"] forState:UIControlStateSelected];
    [self.contentView addSubview:self.selectBtn];
    self.selectBtn.sd_layout.leftSpaceToView(self.contentView,30).topSpaceToView(self.contentView,15).widthIs(15).heightIs(15);
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = UIFontSystem14;
    self.titleLable.textColor = UIColorBlackTheme;
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.selectBtn,10).topSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,30).heightIs(45);
}

-(void)selectBtnClick:(UIButton *)sender
{
    
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    self.titleLable.text = infoDic[@"title"];
}

@end


