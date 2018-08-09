//
//  GUIPlayerView.h
//  GUIPlayerView
//
//  Created by Guilherme Araújo on 08/12/14.
//  Copyright (c) 2014 Guilherme Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GUIPlayerView;

@protocol GUIPlayerViewDelegate <NSObject>

@optional
- (void)playerDidPause;
- (void)playerDidResume;
- (void)playerDidEndPlaying;
- (void)playerWillEnterFullscreen;
- (void)playerDidEnterFullscreen;
- (void)playerWillLeaveFullscreen;
- (void)playerDidLeaveFullscreen;

- (void)playerFailedToPlayToEnd;
- (void)playerStalled;

@end

@interface GUIPlayerView : UIView

@property (strong, nonatomic) NSURL *videoURL;
@property (assign, nonatomic) BOOL benDi;
@property (assign, nonatomic) NSInteger controllersTimeoutPeriod;
@property (weak, nonatomic) id<GUIPlayerViewDelegate> delegate;
@property (nonatomic , copy) NSString * videoTitle;
@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UIButton *firstPlayButton;
@property (strong, nonatomic) UIButton *downLoadBtn;
@property (strong, nonatomic) void (^firstPlayBtnClick)();   /*! 播放 */
@property (strong, nonatomic) void (^downLoadBtnClick)();   /*! 下载 */


- (void)prepareAndPlayAutomatically:(BOOL)playAutomatically;
- (void)clean;
- (void)play;
- (void)pause;
- (void)stop;

- (BOOL)isPlaying;

- (void)setBufferTintColor:(UIColor *)tintColor;

- (void)setLiveStreamText:(NSString *)text;

- (void)setAirPlayText:(NSString *)text;

- (void)showControllers;

@end
