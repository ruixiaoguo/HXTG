//
//  MMChatViewController.h
//  HXTG
//  问老师
//  Created by grx on 2017/2/28.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

@interface HXChatViewController : RCConversationViewController{
    RCTextMessage *msg;
    RCImageMessage *imageMsg;
    NSString *gaintUserName;
    NSString *gaintLegionId;
    NSString *gaintLegionName;
    NSString *techId;
    NSString *teachNum;
    NSString *teachName;
}

@property (strong, nonatomic) RCConversationModel *conversation;
@property (strong, nonatomic) NSString *legionName;
@property (strong, nonatomic) NSString *teacherNum;

@end
