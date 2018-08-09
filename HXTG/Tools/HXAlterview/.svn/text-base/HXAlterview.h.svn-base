//
//  XWAlterview.h
//  new
//
//  Created by chinat2t on 14-11-6.
//  Copyright (c) 2014年 chinat2t. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXAlterview ;
@interface HXAlterview : UIView
- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
   rightButtonTitle:(NSString *)leftTitle
    leftButtonTitle:(NSString *)rigthTitle;

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
   centerButtonTitle:(NSString *)centerTitle;


- (void)show;
@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t centerBlock;
@property (nonatomic, strong) UILabel *alertContentLabel;

/*! 点击左右按钮都会触发该消失的block */
@property (nonatomic, copy) dispatch_block_t dismissBlock;

+(HXAlterview*)showmessage:(NSString *)message subtitle:(NSString *)subtitle cancelbutton:(NSString *)cancle;
+(void)showMessage:(NSString *)message;

@end

