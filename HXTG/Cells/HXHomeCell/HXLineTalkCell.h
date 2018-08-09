//
//  HXLineTalkCell.h
//  HXTG
//  线下会谈
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistRequestManager.h"
#import "HXDatePickView.h"
#import "OfflineTalksReqModel.h"

@interface HXLineTalkCell : UITableViewCell<HXDatePickViewDelegate,UITextViewDelegate>{
    RegistRequestManager *registmanager;
    UILabel *placeholderLable;
    UIButton *submitBtn;
}

@property (nonatomic,strong) HXDatePickView *datePickview;
@property (strong, nonatomic) UILabel *expectFeild;
@property (strong, nonatomic) UITextView *messageFeild;
@property (strong, nonatomic) UITextField *talkFeild;

@property (strong, nonatomic) void (^keyBoadShow)();
@property (strong, nonatomic) void (^popToUpViewController)();

@end
