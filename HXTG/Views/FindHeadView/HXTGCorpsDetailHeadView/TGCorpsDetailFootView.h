//
//  TGCorpsDetailFootView.h
//  HXTG
//  投顾军团详情底部
//  Created by grx on 2017/5/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMYWebView.h"

@interface TGCorpsDetailFootView : UIView<IMYWebViewDelegate>{
    
}

@property (strong, nonatomic) IMYWebView *tGCorpWebView;
@property (strong, nonatomic) void(^gaintWebHight)(CGFloat hight);

@end
