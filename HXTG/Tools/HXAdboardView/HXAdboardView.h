//
//  HXAdboardView.h
//  HXTG
//  轮播广告图
//  Created by grx on 2017/2/16.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdboardModel;

@interface HXAdboardView : UIView<UIScrollViewDelegate>{
    UIScrollView  *_scrollView;
    UIPageControl *_pageControl;
    NSInteger      _currentNum;
    NSTimer       *_myTimer;
    NSString      *imageStr;
}

@property (nonatomic, strong) NSArray* pictureArr;
@property(nonatomic,strong) void (^tapAdboardView) (AdboardModel *model);    /*! 广告位点击 */

- (void)setBannerPictureArr:(NSArray *)bannerArr;

@end
