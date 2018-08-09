//
//  HXApplayCartCell.m
//  HXTG
//
//  Created by grx on 2017/4/7.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXApplayCartCell.h"
#pragma mark - **************************基本信息**************************

@implementation HXApplayCartCell

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
    /*! 必填星号 */
    self.starImage = [UIImageView new];
    self.starImage.image = [UIImage imageNamed:@"xinghao"];
    [self.contentView addSubview:self.starImage];
    self.starImage.sd_layout.leftSpaceToView(self.contentView,10).centerYEqualToView(self.contentView).widthIs(7).heightIs(7);
    /*! 标题 */
    self.titleLable = [UILabel new];
    self.titleLable.font = UIFontSystem13;
    self.titleLable.textColor = UIColorBlackTheme;
    self.titleLable.text = @"身份证号码:";
    [self.contentView addSubview:self.titleLable];
    self.titleLable.sd_layout.leftSpaceToView(self.starImage,2).topSpaceToView(self.contentView,0).widthIs(80).heightIs(45);
    /*! 内容 */
    self.contentLable = [UITextField new];
    self.contentLable.font = UIFontSystem13;
    self.contentLable.textColor = UIColorBlackTheme;
    self.contentLable.textAlignment = NSTextAlignmentRight;
    self.contentLable.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentLable setValue:UIFontSystem14 forKeyPath:@"_placeholderLabel.font"];
    [self.contentView addSubview:self.contentLable];
    self.contentLable.sd_layout.leftSpaceToView(self.titleLable,8).topSpaceToView(self.contentView,2).rightSpaceToView(self.contentView,15).heightIs(44);
    /*! 选择 */
    self.selectButton = [UIButton new];
    //[self.contentView addSubview:self.selectButton];
    self.selectButton.sd_layout.leftSpaceToView(self.titleLable,8).topSpaceToView(self.contentView,2).rightSpaceToView(self.contentView,15).heightIs(44);

}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    self.titleLable.text = infoDic[@"title"];
    self.contentLable.placeholder = infoDic[@"placeholder"];

    if ([infoDic[@"isMust"] isEqualToString:@"yes"]) {
        self.starImage.hidden = NO;
    }else{
        self.starImage.hidden = YES;
    }
    if ([infoDic[@"isSelect"] isEqualToString:@"yes"]) {
        self.selectButton.hidden = NO;
        self.contentLable.enabled = NO;
    }else{
        self.selectButton.hidden = YES;
        self.contentLable.enabled = YES;
    }

}

@end

#pragma mark - **************************已购服务**************************
@implementation HXBuyServerCell

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
    
    self.bgView = [UIView new];
    [self.contentView addSubview:self.bgView];
    self.bgView.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).heightIs(180);
    selectProductArray = [NSMutableArray arrayWithCapacity:0];
    allProductArray = [NSMutableArray arrayWithCapacity:0];
}

-(void)setProductArray:(NSArray *)productArray
{
    if (self.selectImage) {
        return;
    }
    [allProductArray addObjectsFromArray:productArray];
    NSUInteger count;
    if (productArray.count%2==0) {
        count = productArray.count/2;
    }else{
        count = productArray.count/2+1;
    }
    for (int i=0; i<count; i++) {
        for (int j=0; j<2; j++) {
            self.selectImage = [UIImageView new];
            self.selectImage.image = [UIImage imageNamed:@"bank_bg"];
            [self.bgView addSubview:self.selectImage];
            self.selectImage.tag = (i+1)*10+j+1;
            self.selectImage.sd_layout.leftSpaceToView(self.bgView,20+j*(Main_Screen_Width/2)).topSpaceToView(self.bgView,15+i*26).widthIs(13).heightIs(13);
            /*! 标题 */
            UILabel *titlelable = [UILabel new];
            titlelable.font = UIFontSystem13;
            titlelable.textColor = UIColorBlackTheme;
            titlelable.tag = (i+1)*100+j+1;
            if(i==productArray.count/2 && productArray.count%2==1){
                if (j==0) {
                    titlelable.text = productArray[titlelable.tag-(101+i*98)];
                }else{
                    titlelable.text = @"";
                }
            }else{
                titlelable.text = productArray[titlelable.tag-(101+i*98)];
            }

            [self.bgView addSubview:titlelable];
            titlelable.sd_layout.leftSpaceToView(self.selectImage,8).topSpaceToView(self.bgView,11+i*26).widthIs(Main_Screen_Width/2-40).heightIs(20);
            /*! 选择按钮 */
            self.selectButton = [UIButton new];
            [self.bgView addSubview:self.selectButton];
            self.selectButton.tag = (i+1)*1000+j+1;
            self.selectButton.selected = NO;
            [self.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            self.selectButton.sd_layout.leftSpaceToView(self.bgView,15+j*(Main_Screen_Width/2)).topSpaceToView(self.bgView,10+i*24).widthIs(24).heightIs(24);
            if (self.selectImage.tag == (productArray.count/2+1)*10+productArray.count%2+1) {
                self.selectImage.hidden = YES;
            }
            if (titlelable.tag == (productArray.count/2+1)*100+productArray.count%2+1) {
                titlelable.hidden = YES;
            }
            if (self.selectButton.tag == (productArray.count/2+1)*1000+productArray.count%2+1) {
                self.selectButton.hidden = YES;
            }
        }
    }
    /*! 分割线 */
    NSInteger lastTag = ((productArray.count/2+1)*1000+productArray.count%2+1);
    UIButton *lastSelectBtn = (UIButton *)[self.contentView viewWithTag:lastTag];
    UIView *upLine=[UIView new];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    upLine.backgroundColor = UIColorBgLightTheme;
    [self.bgView addSubview:upLine];
    upLine.sd_layout.leftSpaceToView(self.bgView,0).rightSpaceToView(self.bgView,0).topSpaceToView(lastSelectBtn,14).heightIs(1);
    UIView *downLine=[UIView new];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    downLine.backgroundColor = UIColorBgLightTheme;
    [self.bgView addSubview:downLine];
    downLine.sd_layout.leftSpaceToView(self.bgView,0).rightSpaceToView(self.bgView,0).topSpaceToView(upLine,44).heightIs(1);
    /*! 其他服务 */
    self.otherServer = [UITextField new];
    self.otherServer.font = UIFontSystem13;
    self.otherServer.textColor = UIColorBlackTheme;
    self.otherServer.placeholder = @"如有其它服务请填写";
    self.otherServer.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.otherServer setValue:UIFontSystem13 forKeyPath:@"_placeholderLabel.font"];
    [self.bgView addSubview:self.otherServer];
    self.otherServer.sd_layout.leftSpaceToView(self.bgView,20).topSpaceToView(upLine,0).rightSpaceToView(self.bgView,15).heightIs(44);

}

#pragma mark - 复选框选择
-(void)selectButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    NSInteger selImageTag = sender.tag-(990+(sender.tag/1000-1)*990);
    UIImageView *selImage = (UIImageView *)[self.contentView viewWithTag:selImageTag];
    NSInteger selArrayTag = sender.tag-1001-(sender.tag/1000-1)*998+10;
    if (sender.selected==YES) {
        [selectProductArray addObject:allProductArray[selArrayTag-10]];
        selImage.image = [UIImage imageNamed:@"bank_selectd"];
        
    }else{
        selImage.image = [UIImage imageNamed:@"bank_bg"];
        [selectProductArray removeObject:allProductArray[selArrayTag-10]];
    }
    if (self.selectProArray) {
        self.selectProArray(selectProductArray);
    }
}

@end


