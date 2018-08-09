//
//  DownLoadState.m
//  HXTG
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 华讯财经. All rights reserved.
//

#import "DownLoadState.h"
#import "HSDownloadManager.h"

@implementation DownLoadState
/**
 * 按钮状态
 */
+ (UIButton*)buttonStateWithDic:(NSDictionary*)dic{
    // 设置按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 44);
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -50)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -50)];
    // 获取下载进度
    CGFloat f = [[HSDownloadManager sharedInstance] progress:dic];
    if (f >= 1) {
        [button setTitle:@"已下载" forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateNormal];
    }
    // 获取下载列表
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"downList"]];
    // 获取等待列表
    NSMutableArray *waitArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
    NSMutableArray *failed = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"failedList"]];
    NSMutableArray *fishList = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"fishList"]];
    // 判断状态
    NSURLSessionDataTask *task = [[HSDownloadManager sharedInstance] getTask:dic];
    if ([array1 containsObject:dic]) {
        [button setTitle:@"已加入队列" forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateNormal];
    }else{
        if (task.state == NSURLSessionTaskStateRunning) {
            [button setTitle:@"已加入队列" forState:UIControlStateNormal];
            [button setImage:nil forState:UIControlStateNormal];
        }
        else if(task.state == NSURLSessionTaskStateCompleted){
                [button setTitle:@"已下载" forState:UIControlStateNormal];
                [button setImage:nil forState:UIControlStateNormal];
        }
        else{
            [button setTitle:@"已加入队列" forState:UIControlStateNormal];
            [button setImage:nil forState:UIControlStateNormal];
        }
    }
    if ([failed containsObject:dic]) {
        [button setTitle:@"已加入队列" forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateNormal];
    }
    if ([waitArray containsObject:dic]) {
        [button setTitle:@"已加入队列" forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateNormal];
    }
    if ([array1 containsObject:dic]) {
        [button setTitle:@"已加入队列" forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateNormal];
    }
    if (!([array containsObject:dic]||[array1 containsObject:dic]||[failed containsObject:dic]||[waitArray containsObject:dic]||[fishList containsObject:dic])) {
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"xiazai.png"] forState:UIControlStateNormal];
    }
    if ([fishList containsObject:dic]) {
        [button setTitle:@"已下载" forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateNormal];
    }
    return button;
}
/**
 * 文本状态
 */
+ (UILabel*)labelStateWithDictionary:(NSDictionary*)dic{
    // 下载状态
    UILabel *proess = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    proess.font = [UIFont systemFontOfSize:14];
    proess.textAlignment = NSTextAlignmentRight;
    CGFloat f = [[HSDownloadManager sharedInstance] progress:dic];
    if (f == 1) {
        proess.text = [NSString stringWithFormat:@"已下载"];
    }
    NSURLSessionDataTask *task = [[HSDownloadManager sharedInstance] getTask:dic];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
    NSMutableArray*waitArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"waitList"]];
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"cachingList"]];
    NSMutableArray *failed = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"failedList"]];
    if ([array containsObject:dic]) {
        proess.text = [NSString stringWithFormat:@"已暂停"];
    }else{
        if (task.state == NSURLSessionTaskStateRunning) {
            proess.text = [NSString stringWithFormat:@"%.f%%",f*100];
        } else if(task.state == NSURLSessionTaskStateCompleted){
            proess.text = [NSString stringWithFormat:@"已下载"];
        }else{
            proess.text = [NSString stringWithFormat:@"已暂停"];
        }
    }
    if ([failed containsObject:dic]) {
        proess.text = [NSString stringWithFormat:@"下载失败"];
    }
    if ([array1 containsObject:dic]) {
        proess.text = [NSString stringWithFormat:@"已暂停"];
    }
    if ([waitArray containsObject:dic]) {
        proess.text = [NSString stringWithFormat:@"等待中..."];
    }
    if (f == 1) {
        proess.text = [NSString stringWithFormat:@"已下载"];
    }
    return proess;
}
@end
