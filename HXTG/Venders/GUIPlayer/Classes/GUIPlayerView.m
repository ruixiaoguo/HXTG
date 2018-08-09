//
//  GUIPlayerView.m
//  GUIPlayerView
//
//  Created by Guilherme Araújo on 08/12/14.
//  Copyright (c) 2014 Guilherme Araújo. All rights reserved.
//

#import "GUIPlayerView.h"
#import "CXSlider.h"
#import "GUIVolumeView.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "UIView+UpdateAutoLayoutConstraints.h"

@interface GUIPlayerView () <AVAssetResourceLoaderDelegate, NSURLConnectionDataDelegate>
{
    CGPoint _startPoint;
    
    // 创建约束
    NSArray *horizontalConstraints;
    NSArray *verticalConstraints;
}
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;
@property (strong, nonatomic) AVPlayerItem *currentItem;

@property (strong, nonatomic) UIView *controllersView;
@property (strong, nonatomic) UILabel *airPlayLabel;

@property (strong, nonatomic) UIView *gestureView;
@property (strong, nonatomic) UIView *topBgView;
@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *backButton;
@property (nonatomic,assign) CGFloat systemVolume;
//@property (nonatomic,strong) CXSlider *volumeViewSlider;
@property (nonatomic , strong) GUIVolumeView * customVoluView;
@property (nonatomic , strong) MPMusicPlayerController * musicPlayer;

@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIButton *fullscreenButton;
@property (strong, nonatomic) MPVolumeView *volumeView;
//@property (strong, nonatomic) GUISlider *progressIndicator;
@property (strong, nonatomic) CXSlider * progressIndicator;
@property (strong, nonatomic) UILabel *currentTimeLabel;
@property (strong, nonatomic) UILabel *remainingTimeLabel;
@property (strong, nonatomic) UILabel *liveLabel;

@property (strong, nonatomic) UIView *spacerView;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSTimer *progressTimer;
@property (strong, nonatomic) NSTimer *controllersTimer;
@property (assign, nonatomic) BOOL seeking;
@property (assign, nonatomic) BOOL fullscreen;
@property (assign, nonatomic) CGRect defaultFrame;

@end

@implementation GUIPlayerView

@synthesize player, playerLayer, currentItem;
@synthesize controllersView, airPlayLabel;

@synthesize gestureView, topBgView , titleLabel , downLoadBtn ,backButton , musicPlayer , customVoluView;

@synthesize playButton, fullscreenButton, volumeView, progressIndicator, currentTimeLabel, remainingTimeLabel, liveLabel, spacerView;
@synthesize activityIndicator, progressTimer, controllersTimer, seeking, fullscreen, defaultFrame;

@synthesize videoURL, controllersTimeoutPeriod, delegate;

#pragma mark - View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  defaultFrame = frame;
  [self setup];
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  [self setup];
  return self;
}

- (void)setup {
    
    [self setBackgroundColor:[UIColor blackColor]];
    
    //获取系统音量
    musicPlayer = [MPMusicPlayerController applicationMusicPlayer];

    _systemVolume = musicPlayer.volume;
    
    [self addNotification];
    
    [self clearSystemVolumeView];

    [self _initGestureView];
    
    
    
    [self _initTopView];
    
    [self _initBottomView];

    [self addControlAction];
    
    [self _initCoverView];
    
  /** Loading Indicator ***********************************************************************************************/
  activityIndicator = [UIActivityIndicatorView new];
  [activityIndicator stopAnimating];
  
  CGRect frame = self.frame;
  frame.origin = CGPointZero;
  [activityIndicator setFrame:frame];
  
  [self addSubview:activityIndicator];
  
  // 展示视图
  [self showControllers];
  
  controllersTimeoutPeriod = 3;
}

#pragma mark - 添加通知
- (void)addNotification
{
    // Set up notification observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidFinishPlaying:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFailedToPlayToEnd:)
                                                 name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerStalled:)
                                                 name:AVPlayerItemPlaybackStalledNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(airPlayAvailabilityChanged:)
                                                 name:MPVolumeViewWirelessRoutesAvailableDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(airPlayActivityChanged:)
                                                 name:MPVolumeViewWirelessRouteActiveDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(volumeChanged:)
                                                 name:@"AVSystemController_SystemVolumeDidChangeNotification"
                                               object:nil];
}

#pragma mark - 清除系统音量视图
- (void)clearSystemVolumeView
{
    // 功能：清除系统音量视图
//    MPVolumeView * systemVolumeView = [[MPVolumeView alloc] init];
//    systemVolumeView.frame = CGRectMake(-1000, -1000, 100, 100);
//    UISlider* myVolumeViewSlider = nil;
//    for (UIView *view in [systemVolumeView subviews]){
//        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
//            myVolumeViewSlider = (UISlider*)view;
//            break;
//        }
//    }
//    systemVolumeView.hidden = NO;
//    [self addSubview:systemVolumeView];
}

#pragma mark - 创建中间视图-手势视图
- (void)_initGestureView
{
    // 创建手势视图，用于接收手势
    gestureView = [UIView new];
    [gestureView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [gestureView setBackgroundColor:[UIColor clearColor]];
    gestureView.hidden = YES;
    [self addSubview:gestureView];
    
    // 给手势视图添加约束
    horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view" : gestureView}];
    
    verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[view]-40-|" options:0 metrics:nil views:@{@"view" : gestureView}];
    
    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints];
    
    // 创建平移手势，添加到手势视图上
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [gestureView addGestureRecognizer:pan];
    
    // 音量控件
    customVoluView = [[GUIVolumeView alloc] init];
    customVoluView.backgroundColor = [UIColor redColor];
    customVoluView.frame = CGRectMake(0, 0, 150, 150);
//    customVoluView.center = CGPointMake(Main_Screen_Height / 2, Main_Screen_Width / 2 - 40);
    [customVoluView setAlpha:0.0f];
//    [gestureView addSubview:customVoluView];
    
}

#pragma mark - 封面图
- (void)_initCoverView
{
    self.coverImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.coverImageView.clipsToBounds = YES;
    self.coverImageView.contentMode = UIViewContentModeScaleToFill;
    self.firstPlayButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.firstPlayButton.centerX = self.centerX;
    self.firstPlayButton.centerY = Main_Screen_Height/3.15/2;
    [self.firstPlayButton setImage:[UIImage imageNamed:@"dabofang"] forState:UIControlStateNormal];
    [self.firstPlayButton addTarget:self action:@selector(firstPlayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    /*! 灰色遮罩 */
    UIView *bgLightview = [[UIView alloc]initWithFrame:self.coverImageView.bounds];
    bgLightview.backgroundColor = UIColorBlackTheme;
    bgLightview.alpha = 0.2;
    [self.coverImageView addSubview:bgLightview];
}

-(void)firstPlayBtnClick:(UIButton *)sender
{
    if (self.firstPlayBtnClick) {
        self.firstPlayBtnClick();
    }
}

#pragma mark - 顶部视图
- (void)_initTopView
{
    // 顶部的视图的背景视图
    topBgView = [UIView new];
    [topBgView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [topBgView setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.45f]];
    [self addSubview:topBgView];
    
    // 添加约束条件
    horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[TB]|" options:0 metrics:nil views:@{@"TB" : topBgView}];
    verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TB(40)]|" options:0 metrics:nil views:@{@"TB" : topBgView}];
    
    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints];
    
    // 顶部视图的返回按钮
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [backButton setImage:[UIImage imageNamed:@"home_back"] forState:UIControlStateNormal];
    backButton.hidden = YES;
    
    // 顶部标题
    titleLabel = [UILabel new];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleLabel setText:@""];
    [titleLabel setTextColor:[UIColor lightGrayColor]];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setNumberOfLines:1];
    
    // 顶部下载
    downLoadBtn = [UIButton new];
    [downLoadBtn setImage:[UIImage imageNamed:@"xiazai"] forState:UIControlStateNormal];
    [downLoadBtn addTarget:self action:@selector(downLoadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topBgView addSubview:backButton];
    [topBgView addSubview:titleLabel];
    [topBgView addSubview:downLoadBtn];
    downLoadBtn.sd_layout.rightSpaceToView(topBgView,10).topSpaceToView(topBgView,0).widthIs(40).heightIs(40);
    
    // 添加约束条件
    horizontalConstraints = [NSLayoutConstraint
                             constraintsWithVisualFormat:@"H:|-15-[B(40)]-(-40)-[T]-5-|"
                             options:0
                             metrics:nil
                             views:@{@"B" : backButton,
                                     @"T" : titleLabel}];
    
    
    verticalConstraints = [NSLayoutConstraint
                           constraintsWithVisualFormat:@"V:|[B(40)][T(40)]|"
                           options:0
                           metrics:nil
                           views:@{@"B" : backButton,
                                   @"T" : titleLabel,}];
    
    [topBgView addConstraints:horizontalConstraints];
    [topBgView addConstraints:verticalConstraints];
}


#pragma mark - 下载
-(void)downLoadBtnClick:(UIButton *)sender
{
    if (self.downLoadBtnClick) {
        self.downLoadBtnClick();
    }
}

#pragma mark - 底部视图
- (void)_initBottomView
{
    // 创建播放器下面的一组控件
    controllersView = [UIView new];
    [controllersView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [controllersView setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.45f]];
    [self addSubview:controllersView];
    
    // 添加约束条件
    horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[CV]|" options:0 metrics:nil views:@{@"CV" : controllersView}];
    
    verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[CV(40)]|" options:0 metrics:nil views:@{@"CV" : controllersView}];
    
    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints];
    
    airPlayLabel = [UILabel new];
    [airPlayLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [airPlayLabel setText:@"AirPlay is enabled"];
    [airPlayLabel setTextColor:[UIColor lightGrayColor]];
    [airPlayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f]];
    [airPlayLabel setTextAlignment:NSTextAlignmentCenter];
    [airPlayLabel setNumberOfLines:0];
    [airPlayLabel setHidden:YES];
    
    [self addSubview:airPlayLabel];
    
    // 添加约束条件
    horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[AP]|" options:0 metrics:nil views:@{@"AP" : airPlayLabel}];
    
    verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[AP]-40-|"  options:0 metrics:nil views:@{@"AP" : airPlayLabel}];
    
    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints];
    
    
    playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [playButton setImage:[UIImage imageNamed:@"gui_play"] forState:UIControlStateNormal];
    [playButton setImage:[UIImage imageNamed:@"gui_pause"] forState:UIControlStateSelected];
    
    volumeView = [MPVolumeView new];
    [volumeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [volumeView setShowsRouteButton:YES];
    [volumeView setShowsVolumeSlider:NO];
    [volumeView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    fullscreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [fullscreenButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [fullscreenButton setImage:[UIImage imageNamed:@"gui_expand_red"] forState:UIControlStateNormal];
    [fullscreenButton setImage:[UIImage imageNamed:@"gui_shrink_red"] forState:UIControlStateSelected];
    
    currentTimeLabel = [UILabel new];
    [currentTimeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [currentTimeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f]];
    [currentTimeLabel setTextAlignment:NSTextAlignmentCenter];
    [currentTimeLabel setTextColor:[UIColor whiteColor]];
    
    remainingTimeLabel = [UILabel new];
    [remainingTimeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [remainingTimeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f]];
    [remainingTimeLabel setTextAlignment:NSTextAlignmentCenter];
    [remainingTimeLabel setTextColor:[UIColor whiteColor]];
    
    
    progressIndicator = [[CXSlider alloc] init];
    [progressIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [progressIndicator setContinuous:YES];
    
    liveLabel = [UILabel new];
    [liveLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [liveLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f]];
    [liveLabel setTextAlignment:NSTextAlignmentCenter];
    [liveLabel setTextColor:[UIColor whiteColor]];
    [liveLabel setText:@"Live"];
    [liveLabel setHidden:YES];
    
    spacerView = [UIView new];
    [spacerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [controllersView addSubview:playButton];
    [controllersView addSubview:fullscreenButton];
    [controllersView addSubview:volumeView];
    [controllersView addSubview:currentTimeLabel];
    [controllersView addSubview:progressIndicator];
    [controllersView addSubview:remainingTimeLabel];
    [controllersView addSubview:liveLabel];
    [controllersView addSubview:spacerView];
    
    horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[P(40)][S(10)][C]-10-[I]-10-[R][F(50)][V(40)]|" options:0 metrics:nil
                                                                      views:@{@"P" : playButton,
                                                                              @"S" : spacerView,
                                                                              @"C" : currentTimeLabel,
                                                                              @"I" : progressIndicator,
                                                                              @"R" : remainingTimeLabel,
                                                                              @"V" : volumeView,
                                                                              @"F" : fullscreenButton}];
    
    [controllersView addConstraints:horizontalConstraints];
    
    [volumeView hideByWidth:YES];
    [spacerView hideByWidth:YES];
    
    horizontalConstraints = [NSLayoutConstraint
                             constraintsWithVisualFormat:@"H:|-5-[L]-5-|"
                             options:0
                             metrics:nil
                             views:@{@"L" : liveLabel}];
    
    [controllersView addConstraints:horizontalConstraints];
    
    for (UIView *view in [controllersView subviews]) {
        verticalConstraints = [NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[V(40)]"
                               options:NSLayoutFormatAlignAllCenterY
                               metrics:nil
                               views:@{@"V" : view}];
        [controllersView addConstraints:verticalConstraints];
    }
}

- (void)addControlAction
{
    [playButton addTarget:self action:@selector(togglePlay:) forControlEvents:UIControlEventTouchUpInside];
    [fullscreenButton addTarget:self action:@selector(toggleFullscreen:) forControlEvents:UIControlEventTouchUpInside];
    [backButton addTarget:self action:@selector(toggleFullscreen:) forControlEvents:UIControlEventTouchUpInside];
    
    [progressIndicator addTarget:self action:@selector(seek:) forControlEvents:UIControlEventValueChanged];
    [progressIndicator addTarget:self action:@selector(pauseRefreshing) forControlEvents:UIControlEventTouchDown];
    [progressIndicator addTarget:self action:@selector(resumeRefreshing) forControlEvents:UIControlEventTouchUpInside|
     UIControlEventTouchUpOutside];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showControllers)]];
}

#pragma mark - 手势方法
- (void)panAction:(UIPanGestureRecognizer *)pan
{
    // 获取手指点击位置
    if (pan.state == UIGestureRecognizerStateBegan) {
        // 滑动开始-记录手指的位置
        _startPoint = [pan locationInView:gestureView];
        
        NSUserDefaults * userDefaults1 = [NSUserDefaults standardUserDefaults];
         _systemVolume = [[userDefaults1 objectForKey:@"volume"] floatValue];

    } else if (pan.state == UIGestureRecognizerStateChanged) {
        
        // 获取手指的当前的位置
        CGPoint endPoint = [pan locationInView:gestureView];
        // 获取上下滑动的距离
        float lenghtY = fabs(endPoint.y) - fabs(_startPoint.y);
        float lenghtX = fabs(endPoint.x) - fabs(_startPoint.x);
        
        if (fabs(lenghtY) > fabs(lenghtX)) {
            musicPlayer.volume = _systemVolume - lenghtY / 100;
            [customVoluView setValue:musicPlayer.volume];
        } else
        {
            _startPoint = endPoint;
        }
        
    } else {
        // 手指手势为刚刚停止状态
    }
}



- (void)setVideoTitle:(NSString *)videoTitle
{
    titleLabel.text = videoTitle;
}

- (void)setTintColor:(UIColor *)tintColor {
  [super setTintColor:tintColor];
  
  [progressIndicator setTintColor:tintColor];
}

- (void)setBufferTintColor:(UIColor *)tintColor {
//  [progressIndicator setSecondaryTintColor:tintColor];
}

- (void)setLiveStreamText:(NSString *)text {
  [liveLabel setText:text];
}

- (void)setAirPlayText:(NSString *)text {
  [airPlayLabel setText:text];
}

#pragma mark - 系统音量改变通知的方法
-(void)volumeChanged:(NSNotification *)noti
{
    float volume = [[[noti userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    
    [customVoluView setValue:volume];
    
    [customVoluView setAlpha:0.7f];
    [UIView animateWithDuration:2.5f animations:^{
        [customVoluView setAlpha:0.0f];
    }];
    
    NSUserDefaults * userDefaults1 = [NSUserDefaults standardUserDefaults];
    [userDefaults1 setObject:@(volume) forKey:@"volume"];
    [userDefaults1 synchronize];
}

#pragma mark - Actions

- (void)togglePlay:(UIButton *)button {
  if ([button isSelected]) {
    [button setSelected:NO];
    [player pause];
    
    if ([delegate respondsToSelector:@selector(playerDidPause)]) {
      [delegate playerDidPause];
    }
  } else {
    [button setSelected:YES];
    [self play];
    
    if ([delegate respondsToSelector:@selector(playerDidResume)]) {
      [delegate playerDidResume];
    }
  }
  
  [self showControllers];
}
- (void)setBenDi:(BOOL)benDi{
    if (_benDi != benDi) {
        _benDi = benDi;
    }
    if (_benDi == YES) {
        fullscreenButton.hidden = YES;
        [self toggleFullscreen:fullscreenButton];
    }
}

- (void)toggleFullscreen:(UIButton *)button {
    if (button == backButton) {
        if (_benDi == YES) {
            [self.viewController.navigationController popViewControllerAnimated:YES];
        }
    }
  if (fullscreen) {
    if ([delegate respondsToSelector:@selector(playerWillLeaveFullscreen)]) {
      self.coverImageView.frame = CGRectMake(0, 0, Main_Screen_Width, 180);
      [delegate playerWillLeaveFullscreen];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
      [self setTransform:CGAffineTransformMakeRotation(0)];
      [self setFrame:defaultFrame];
      
      CGRect frame = defaultFrame;
      frame.origin = CGPointZero;
      [playerLayer setFrame:frame];
      [activityIndicator setFrame:frame];
    } completion:^(BOOL finished) {
      fullscreen = NO;
      
      if ([delegate respondsToSelector:@selector(playerDidLeaveFullscreen)]) {
        [delegate playerDidLeaveFullscreen];
      }
    }];
    
    [fullscreenButton setSelected:NO];
      backButton.hidden = YES;
      gestureView.hidden = YES;
  } else {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    CGRect frame;
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
      CGFloat aux = width;
      width = height;
      height = aux;
      frame = CGRectMake((height - width) / 2, (width - height) / 2, width, height);
    } else {
      frame = CGRectMake(0, 0, width, height);
    }
    
    if ([delegate respondsToSelector:@selector(playerWillEnterFullscreen)]) {
      self.coverImageView.frame = CGRectMake(0, 0, Main_Screen_Height, Main_Screen_Width);
      [delegate playerWillEnterFullscreen];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
      [self setFrame:frame];
      [playerLayer setFrame:CGRectMake(0, 0, width, height)];
      
      [activityIndicator setFrame:CGRectMake(0, 0, width, height)];
      if (UIInterfaceOrientationIsPortrait(orientation)) {
        [self setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        [activityIndicator setTransform:CGAffineTransformMakeRotation(M_PI_2)];
      }
      
    } completion:^(BOOL finished) {
      fullscreen = YES;
      
      if ([delegate respondsToSelector:@selector(playerDidEnterFullscreen)]) {
        [delegate playerDidEnterFullscreen];
      }
    }];
    
    [button setSelected:YES];
      backButton.hidden = NO;
      gestureView.hidden = NO;
  }
  
  [self showControllers];
}

- (void)seek:(UISlider *)slider {
  int timescale = currentItem.asset.duration.timescale;
  float time = slider.value * (currentItem.asset.duration.value / timescale);
  [player seekToTime:CMTimeMakeWithSeconds(time, timescale)];
  [controllersView setAlpha:1.0f];
  [topBgView setAlpha:1.0f];
    [self hideControllers];
}

- (void)pauseRefreshing {
  seeking = YES;
}

- (void)resumeRefreshing {
  seeking = NO;
}

- (NSTimeInterval)availableDuration {
  NSTimeInterval result = 0;
  NSArray *loadedTimeRanges = player.currentItem.loadedTimeRanges;
  
  if ([loadedTimeRanges count] > 0) {
    CMTimeRange timeRange = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
    Float64 startSeconds = CMTimeGetSeconds(timeRange.start);
    Float64 durationSeconds = CMTimeGetSeconds(timeRange.duration);
    result = startSeconds + durationSeconds;
  }
  
  return result;
}

- (void)refreshProgressIndicator {
  CGFloat duration = CMTimeGetSeconds(currentItem.asset.duration);
  
  if (duration == 0 || isnan(duration)) {
    // Video is a live stream
    [currentTimeLabel setText:nil];
    [remainingTimeLabel setText:nil];
    [progressIndicator setHidden:YES];
    [liveLabel setHidden:NO];
  }
  
  else {
    CGFloat current = seeking ?
    progressIndicator.value * duration :         // If seeking, reflects the position of the slider
    CMTimeGetSeconds(player.currentTime); // Otherwise, use the actual video position
    
    [progressIndicator setValue:current / duration];
    
    // Set time labels
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:(duration >= 3600 ? @"hh:mm:ss": @"mm:ss")];
    
    NSDate *currentTime = [NSDate dateWithTimeIntervalSince1970:current];
    NSDate *remainingTime = [NSDate dateWithTimeIntervalSince1970:(duration - current)];
    
    [currentTimeLabel setText:[formatter stringFromDate:currentTime]];
    [remainingTimeLabel setText:[NSString stringWithFormat:@"%@", [formatter stringFromDate:remainingTime]]];
    
    [progressIndicator setHidden:NO];
    [liveLabel setHidden:YES];
  }
}

- (void)showControllers {
    DDLog(@"显示");
    if (controllersView.alpha == 1) {
        [controllersTimer invalidate];
        [self hideControllers];
    } else if (controllersView.alpha == 0) {
        [UIView animateWithDuration:1.0f animations:^{
            [controllersView setAlpha:1.0f];
            [topBgView setAlpha:1.0f];
        } completion:^(BOOL finished) {
            [controllersTimer invalidate];
            
            if (controllersTimeoutPeriod > 0) {
                controllersTimer = [NSTimer scheduledTimerWithTimeInterval:15
                                                                    target:self
                                                                  selector:@selector(hideControllers)
                                                                  userInfo:nil
                                                                   repeats:NO];
            }
        }];
    }
  
}

- (void)hideControllers {
    DDLog(@"隐藏");
    [UIView animateWithDuration:1.0f animations:^{
        [controllersView setAlpha:0.0f];
        [topBgView setAlpha:0.0f];
    }];

}

#pragma mark - Public Methods

- (void)prepareAndPlayAutomatically:(BOOL)playAutomatically {
  if (player) {
    [self stop];
  }
  
  player = [[AVPlayer alloc] initWithPlayerItem:nil];
  
  AVAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
  NSArray *keys = [NSArray arrayWithObject:@"playable"];
  
    __weak typeof(self) weakSelf = self;
  [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
    weakSelf.currentItem = [AVPlayerItem playerItemWithAsset:asset];
    [weakSelf.player replaceCurrentItemWithPlayerItem:weakSelf.currentItem];
    
    if (playAutomatically) {
      dispatch_sync(dispatch_get_main_queue(), ^{
        [weakSelf play];
      });
    }
  }];
  
  [player setAllowsExternalPlayback:YES];
  playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
  [self.layer addSublayer:playerLayer];
  
  defaultFrame = self.frame;
  
  CGRect frame = self.frame;
  frame.origin = CGPointZero;
  [playerLayer setFrame:frame];
  
  [self bringSubviewToFront:controllersView];
    [self bringSubviewToFront:topBgView];
    [self bringSubviewToFront:gestureView];
  
  [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
  
  [player addObserver:self forKeyPath:@"rate" options:0 context:nil];
  [currentItem addObserver:self forKeyPath:@"status" options:0 context:nil];
  
  [player seekToTime:kCMTimeZero];
  [player setRate:0.0f];
  [playButton setSelected:YES];
  
  if (playAutomatically) {
    [activityIndicator startAnimating];
  }
}

- (void)clean {

  [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:MPVolumeViewWirelessRoutesAvailableDidChangeNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:MPVolumeViewWirelessRouteActiveDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
  
  [player setAllowsExternalPlayback:NO];
  [self stop];
  [player removeObserver:self forKeyPath:@"rate"];
  [self setPlayer:nil];
  [self.playerLayer removeFromSuperlayer];
  [self setPlayerLayer:nil];
  [self removeFromSuperview];
    
}

- (void)play {
  [player play];
  
  [playButton setSelected:YES];
  
  progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                   target:self
                                                 selector:@selector(refreshProgressIndicator)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void)pause {
  [player pause];
  [playButton setSelected:NO];
  
  if ([delegate respondsToSelector:@selector(playerDidPause)]) {
    [delegate playerDidPause];
  }
}

- (void)stop {
  if (player) {
    [player pause];
    [player seekToTime:kCMTimeZero];
    
    [playButton setSelected:NO];
  }
}

- (BOOL)isPlaying {
  return [player rate] > 0.0f;
}

#pragma mark - AV Player Notifications and Observers

- (void)playerDidFinishPlaying:(NSNotification *)notification {
  [self stop];
  
  if (fullscreen) {
    [self toggleFullscreen:fullscreenButton];
  }
  
  if ([delegate respondsToSelector:@selector(playerDidEndPlaying)]) {
    [delegate playerDidEndPlaying];
  }
}

- (void)playerFailedToPlayToEnd:(NSNotification *)notification {
    
  [self stop];
  
  if ([delegate respondsToSelector:@selector(playerFailedToPlayToEnd)]) {
    [delegate playerFailedToPlayToEnd];
  }
}

- (void)playerStalled:(NSNotification *)notification {
  [self togglePlay:playButton];
  
  if ([delegate respondsToSelector:@selector(playerStalled)]) {
    [delegate playerStalled];
  }
}


- (void)airPlayAvailabilityChanged:(NSNotification *)notification {
  [UIView animateWithDuration:0.4f
                   animations:^{
                     if ([volumeView areWirelessRoutesAvailable]) {
                       [volumeView hideByWidth:NO];
                     } else if (! [volumeView isWirelessRouteActive]) {
                       [volumeView hideByWidth:YES];
                     }
                     [self layoutIfNeeded];
                   }];
}


- (void)airPlayActivityChanged:(NSNotification *)notification {
  [UIView animateWithDuration:0.4f
                   animations:^{
                     if ([volumeView isWirelessRouteActive]) {
                       if (fullscreen)
                         [self toggleFullscreen:fullscreenButton];
                       
//                         [playButton hideByHeight:YES];
                       [playButton hideByWidth:YES];
                       [fullscreenButton hideByWidth:YES];
                       [spacerView hideByWidth:NO];
                       
                       [airPlayLabel setHidden:NO];
                       
                       controllersTimeoutPeriod = 0;
                       [self showControllers];
                     } else {
                       [playButton hideByWidth:NO];
                       [fullscreenButton hideByWidth:NO];
                       [spacerView hideByWidth:YES];
                       
                       [airPlayLabel setHidden:YES];
                       
                       controllersTimeoutPeriod = 3;
                       [self showControllers];
                     }
                     [self layoutIfNeeded];
                   }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if ([keyPath isEqualToString:@"status"]) {
    if (currentItem.status == AVPlayerItemStatusFailed) {
      if ([delegate respondsToSelector:@selector(playerFailedToPlayToEnd)]) {
        [delegate playerFailedToPlayToEnd];
      }
    }
  }
  
  if ([keyPath isEqualToString:@"rate"]) {
    CGFloat rate = [player rate];
    if (rate > 0) {
      [activityIndicator stopAnimating];
    }
  }
}

- (void)dealloc {
}

@end
