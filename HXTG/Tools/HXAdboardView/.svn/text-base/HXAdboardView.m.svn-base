//
//  HXAdboardView.m
//  HXTG
//
//  Created by grx on 2017/2/16.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXAdboardView.h"
#import "AdboardModel.h"

#define AD_SCROLL_RunloopTime 5.0

@implementation HXAdboardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        // test
        _scrollView.backgroundColor = [UIColor clearColor];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.bounds) - 80) / 2, CGRectGetMaxY(self.frame) - 25, 80, 19)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.alpha = 0.8;
        
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        
        _pictureArr = [[NSArray alloc] init];
    }
    return self;
}

- (void)setBannerPictureArr:(NSArray *)bannerArr
{
    
    if(bannerArr.count!=0)
    {
        if( bannerArr.count <= 0 )
            return;
        
        if( [self viewWithTag:7] )
        {
            [[self viewWithTag:7] removeFromSuperview];
        }
        // 关闭定时器
        [self stopTimer];
        _pageControl.currentPage = 0;
        [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        self.pictureArr = bannerArr;
        
        for( int i = 0; i < self.pictureArr.count + 2; i++ )
        {
            AdboardModel *adverModel;
            
            UIImageView* imageView =[[UIImageView alloc] initWithFrame:CGRectMake(Main_Screen_Width * i, 0, Main_Screen_Width, self.bounds.size.height)];
            imageView.clipsToBounds = YES;
            imageView.userInteractionEnabled = YES;
            imageView.backgroundColor = UIColorWhite;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
            [imageView addGestureRecognizer:tap];
            
            if( i == 0 )
            {
                adverModel = self.pictureArr[_pictureArr.count-1];
            }
            else if( i == _pictureArr.count + 1 )
            {
                adverModel = self.pictureArr[0];
                
            }
            else
            {
                adverModel = self.pictureArr[i -1 ];
            }
            NSString *picStr = [NSString stringWithFormat:@"%@",adverModel.slide_pic];
            picStr = [picStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

            [imageView sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:[UIImage imageNamed:@"banner"]];
            [_scrollView addSubview:imageView];
        }
        
        [_scrollView setContentSize:CGSizeMake(Main_Screen_Width * (_pictureArr.count+2), self.bounds.size.height)];
        [_scrollView setContentOffset:CGPointMake(Main_Screen_Width, 0)];
    
        if (self.pictureArr.count==1) {
            _pageControl.numberOfPages = 0;
            // 关闭定时器
            [self stopTimer];
            _scrollView.scrollEnabled = NO;
        }else{
            _pageControl.numberOfPages = self.pictureArr.count;
            // 开启定时器
            [self startTimer];
            _scrollView.scrollEnabled = YES;
        }
    }

    else {
        for (UIView * view in _scrollView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                UIImageView * imgImage = (UIImageView *)view;
                [imgImage removeFromSuperview];
            }
        }
        UIImageView* defaultImage =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.bounds.size.height)];
        defaultImage.tag = 7;
        defaultImage.backgroundColor = [UIColor whiteColor];
        defaultImage.clipsToBounds = YES;
        defaultImage.image = [UIImage imageNamed:@"banner"];
        // 监听点击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap1:)];
        [self addGestureRecognizer:singleTap];
        [self addSubview:defaultImage];
    }
}

- (void)startTimer
{
    if( !_myTimer )
    {
        _myTimer = [NSTimer timerWithTimeInterval:AD_SCROLL_RunloopTime target:self selector:@selector(playForAd) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer
{
    if( _myTimer )
    {
        [_myTimer invalidate];
        _myTimer = nil;
    }
}

- (void)playForAd
{
    _currentNum = (NSInteger)_scrollView.contentOffset.x / self.frame.size.width;
    
    if( _currentNum == _pictureArr.count + 1 )
    {
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, _scrollView.contentOffset.y);
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x + _scrollView.frame.size.width, _scrollView.contentOffset.y);
    
    [UIView commitAnimations];
    
    _currentNum = (NSInteger)_scrollView.contentOffset.x / _scrollView.frame.size.width;
    if( _currentNum == _pictureArr.count + 1 )
    {
        _pageControl.currentPage = 0;
    }
    else
    {
        _pageControl.currentPage = _currentNum - 1;
    }
    
}

#pragma **点击

- (void)handleSingleTap:(UITapGestureRecognizer *)tap
{
    
    if( _pageControl.numberOfPages <= 0 )
        return;
    
    AdboardModel *adverModel = self.pictureArr[_pageControl.currentPage];
    if (self.tapAdboardView)
    {
        self.tapAdboardView(adverModel);
    }
}

- (void)handleSingleTap1:(UITapGestureRecognizer *)tap
{
    
}


#pragma mark - UIScrollViewDelegate

// 结束拖拽
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self stopTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentNum = (NSInteger)scrollView.contentOffset.x / scrollView.frame.size.width;
    if( _currentNum == 0 )
    {
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - 2 * scrollView.bounds.size.width, scrollView.contentOffset.y);
    }
    if( _currentNum == scrollView.contentSize.width / scrollView.bounds.size.width - 1 )
    {
        [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width, scrollView.contentOffset.y)];
    }
    _currentNum = (NSInteger)scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = _currentNum - 1;
    
    [self startTimer];
}

- (void)dealloc
{
    [self stopTimer];
}


@end
