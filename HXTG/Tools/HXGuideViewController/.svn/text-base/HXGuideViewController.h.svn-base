//
//  HXGuideViewController.h
//  HXTG
//  引导页
//  Created by grx on 2017/2/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectedEnter)();

@interface HXGuideViewController : UIViewController

@property (nonatomic, strong) UIScrollView *pagingScrollView;
@property (nonatomic, strong) UIButton *enterButton;

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;

@property (nonatomic, strong) NSArray *backgroundImageNames;

@property (nonatomic, strong) NSArray *coverImageNames;

- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames;


- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames button:(UIButton*)button;


@end
