//
//  ShareManage.m
//  HXTG
//
//  Created by grx on 2017/2/20.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "ShareManage.h"
//#import <sharesdk/ShareSDK.h>
//#import <ShareSDKUI/ShareSDKUI.h>

@implementation ShareManage

static ShareManage *shareManage;

/*! 分享管理单例 */
+ (ShareManage *)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManage = [[ShareManage alloc]init];
    });
    return shareManage;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManage = [super allocWithZone:zone];
    });
    return shareManage;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return shareManage;
}

/**
 *  分享调用方法
 *
 *  @param imageName      分享的图片
 *  @param content        分享内容
 *  @param defaultContent 分享默认内容
 *  @param FriendTitle    分享
 *  @param Circletitle    分享标题
 *  @param baseurl        分享url
 *  @param description    描述
 */
//- (void)shareSDKWithImagePath:(NSString *)imageName
//                      content:(NSString *)content
//               defaultContent:(NSString *)defaultContent
//                  FriendTitle:(NSString *)FriendTitle
//                  Circletitle:(NSString *)Circletitle
//                          url:(NSString *)baseurl
//                  description:(NSString *)description
//            containerWithView:(UIView *)view
//                     sellerId:(NSString *)sellerId
//                   isactivity:(BOOL )isactivity
//{
//    //创建分享参数
//    //    NSArray* imageArray = @[[UIImage imageNamed:@"home_default pic"]];
//    NSArray *imageArray = @[imageName];
//    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
//    
//    
//    
//    if (imageArray) {
//        
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        //        [shareParams SSDKSetupShareParamsByText:content
//        //                                         images:imageArray
//        //                                            url:[NSURL URLWithString:baseurl]
//        //                                          title:title
//        //                                           type:SSDKContentTypeAuto];
//        
//        /*! 微信好友 */
//        [shareParams SSDKSetupWeChatParamsByText:content title:FriendTitle url:[NSURL URLWithString:baseurl] thumbImage:imageName image:imageName musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeWechatSession];
//        /*! 微信朋友圈 */
//        [shareParams SSDKSetupWeChatParamsByText:content title:Circletitle url:[NSURL URLWithString:baseurl] thumbImage:imageName image:imageName musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
//        /*! qq */
//        [shareParams SSDKSetupQQParamsByText:content title:FriendTitle url:[NSURL URLWithString:baseurl] thumbImage:imageName image:imageName type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeQQFriend];
//        /*! qq空间 */
//        [shareParams SSDKSetupQQParamsByText:content title:FriendTitle url:[NSURL URLWithString:baseurl] thumbImage:imageName image:imageName type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeQZone];
//        /*! 新浪微博 */
//        [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@%@",content,baseurl] title:FriendTitle image:imageName url:[NSURL URLWithString:baseurl] latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
//        /*! 自动配置 */
//        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@%@",content,baseurl]
//                                         images:imageName
//                                            url:[NSURL URLWithString:baseurl]
//                                          title:FriendTitle
//                                           type:SSDKContentTypeAuto];
//        /*! 分享（可以弹出我们的分享菜单和编辑界面） */
//        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
//                                 items:nil
//                           shareParams:shareParams
//                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                       NSLog(@"============>>>>%lu",(unsigned long)state);
//                       switch (state) {
//                           case SSDKResponseStateSuccess:
//                           {
//                               
//                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                   message:nil
//                                                                                  delegate:nil
//                                                                         cancelButtonTitle:@"确定"
//                                                                         otherButtonTitles:nil];
//                               [alertView show];
//                               [[NSNotificationCenter defaultCenter]postNotificationName:@"shareSucceed" object:nil];
//                               
//                               break;
//                           }
//                           case SSDKResponseStateFail:
//                           {
//                               NSLog(@"=========分享失败========");
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                               message:[NSString stringWithFormat:@"%@",error]
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"OK"
//                                                                     otherButtonTitles:nil, nil];
//                               NSLog(@"分享失败error========%@",error);
//                               
//                               [alert show];
//                               break;
//                           }
//                           default:
//                               break;
//                       }
//                       
//                   }];
//    }
//}

@end
