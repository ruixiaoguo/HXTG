//
//  HXMP3View.h
//  HXTG
//
//  Created by grx on 2017/5/8.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface HXMP3View : UIView{
    id timeObserve;
}

@property (strong, nonatomic) AVPlayerItem * songItem;

@property (strong, nonatomic) UILabel *MP3Lable;
@property (strong, nonatomic) NSString *MP3Url;
@property (strong, nonatomic) UIButton *downLoadBtn;
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (assign, nonatomic) BOOL isSelect;


@property (strong, nonatomic) void (^playLoadPM3File)();

/*! 移除音乐播放器 */
-(void)clearn;

@end
