//
//  HXBaseViewController.h
//  HXTG
//
//  Created by grx on 2017/2/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBaseViewController : UIViewController

@property (strong, nonatomic) UIButton *messageBtn;
@property (strong, nonatomic) UIButton *teacherInfoBtn;

@property (strong, nonatomic) UIButton *backButton;
@property(nonatomic,strong) HXNoDataView *noView;

-(void)initEmptyView:(UIView *)superView;
-(void)initEmptyView:(UIView *)superView withFrame:(CGRect)frame;
-(void)showNoDataView:(NSMutableArray *)allArray;
-(void)showNoServerView:(NSMutableArray *)allArray;
-(void)showNoNetView:(NSMutableArray *)allArray;
-(void)showNoPlarView:(bool)isHave;

@end
