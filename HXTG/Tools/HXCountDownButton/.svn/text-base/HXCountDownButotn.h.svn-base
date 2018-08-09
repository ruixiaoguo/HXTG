//
//  HXCountDownButotn.h
//  HXTG
//
//  Created by grx on 2017/2/24.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXCountDownButotn;

typedef NSString* (^DidChangeBlock)(HXCountDownButotn *countDownButton,int second);
typedef NSString* (^DidFinishedBlock)(HXCountDownButotn *countDownButton,int second);
typedef void (^TouchedDownBlock)(HXCountDownButotn *countDownButton,NSInteger tag);

@interface HXCountDownButotn : UIButton{
    int _second;
    int _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
}


-(void)addToucheHandler:(TouchedDownBlock)touchHandler;
-(void)didChange:(DidChangeBlock)didChangeBlock;
-(void)didFinished:(DidFinishedBlock)didFinishedBlock;
-(void)startWithSecond:(int)second;
- (void)stop;

@end
