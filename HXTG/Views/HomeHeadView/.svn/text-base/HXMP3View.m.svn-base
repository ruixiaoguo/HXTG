//
//  HXMP3View.m
//  HXTG
//
//  Created by grx on 2017/5/8.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMP3View.h"

@implementation HXMP3View

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = UIColorWhite;
        [self markeView];
    }
    return self;
}

/*! 创建音乐播放器 */
-(void)creatMp3Player
{
    if (!self.avPlayer) {
        NSString *currenUrl = [NSString stringWithFormat:@"%@",self.MP3Url];
        currenUrl = [currenUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:currenUrl];
        self.songItem = [[AVPlayerItem alloc]initWithURL:url];
        //创建播放器
        self.avPlayer = [[AVPlayer alloc]initWithPlayerItem:self.songItem];
       [self.songItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        WeakSelf(weakSelf);
        timeObserve = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            float current = CMTimeGetSeconds(time);
            float total = CMTimeGetSeconds(weakSelf.songItem.duration);
            if (current) {
                [HXLoadingView hide];
                if (current==total) {
                    DDLog(@"播放完毕");
                    weakSelf.isSelect = NO;
                    [weakSelf.downLoadBtn setSelected:NO];
                }
            }
        }];
    }
}

/*! MP3下载 */
-(void)markeView
{
    self.isSelect = NO;
    UIImageView *pdfImage = [UIImageView new];
    pdfImage.image = [UIImage imageNamed:@"yinpin"];
    [self addSubview:pdfImage];
    pdfImage.sd_layout.leftSpaceToView(self, 26).topSpaceToView(self, 10).widthIs(26).heightIs(23);
    self.MP3Lable = [UILabel new];
    self.MP3Lable.font = UIFontSystem13;
    self.MP3Lable.textColor = UIColorBlackTheme;
    [self addSubview:self.MP3Lable];
    self.MP3Lable.sd_layout.leftSpaceToView(pdfImage, 10).topSpaceToView(self, 0).rightSpaceToView(self, 57).heightIs(45);
    self.downLoadBtn = [UIButton new];
    [self.downLoadBtn setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [self.downLoadBtn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateSelected];
    [self addSubview:self.downLoadBtn];
    [self.downLoadBtn addTarget:self action:@selector(PlayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.downLoadBtn.sd_layout.rightSpaceToView(self, 15).topSpaceToView(self, 10).widthIs(25).heightIs(25);
    /*! 手势 */
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClickTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleRecognizer];

}

-(void)PlayBtnClick:(UIButton *)sender
{
    
    if (self.playLoadPM3File) {
        [self creatMp3Player];
        if (self.isSelect==NO) {
            self.isSelect=YES;
            [self.avPlayer play];
        }else{
            self.isSelect=NO;
            [self.avPlayer pause];
        }
        [self.downLoadBtn setSelected:self.isSelect];
        self.playLoadPM3File();
    }
}

#pragma mark - 播放MP3
-(void)bgViewClickTap:(UITapGestureRecognizer *)recognizer
{

    
    if (self.playLoadPM3File) {
        [self creatMp3Player];
        if (self.isSelect==NO) {
            self.isSelect=YES;
            [self.avPlayer play];
        }else{
            self.isSelect=NO;
            [self.avPlayer pause];
        }
        [self.downLoadBtn setSelected:self.isSelect];
        self.playLoadPM3File();
    }
}

/*! 移除音乐播放器 */
-(void)clearn
{
    [self.avPlayer pause];
    self.avPlayer = nil;
    [self.avPlayer.currentItem cancelPendingSeeks];
    [self.avPlayer.currentItem.asset cancelLoading];
    if (timeObserve) {
        [self.avPlayer removeTimeObserver:timeObserve];
        timeObserve = nil;
    }
    [self.songItem removeObserver:self forKeyPath:@"status"];

    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.avPlayer.status) {
            case AVPlayerItemStatusReadyToPlay:
                [self.avPlayer play];
                [HXLoadingView show];
                break;
            case AVPlayerItemStatusUnknown:
                break;
            case AVPlayerItemStatusFailed:
                [HXProgressHUD showMessage:self.superview
                                 labelText:@"播放失败"
                                      mode:MBProgressHUDModeText];
                break;
        }
    }
}

@end
