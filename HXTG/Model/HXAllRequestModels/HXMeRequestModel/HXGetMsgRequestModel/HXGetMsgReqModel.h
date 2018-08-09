//
//  HXGetMsgReqModel.h
//  HXTG
//  融云保存用户聊天记录
//  Created by grx on 2017/4/19.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXBaseRequestModel.h"

@interface HXGetMsgReqModel : HXBaseRequestModel

@property (strong, nonatomic) NSString *legion_id;         /*! 军团Id */
@property (strong, nonatomic) NSString *sender;         /*! 发送者 */
@property (strong, nonatomic) NSString *send_content;   /*! 发送内容 */
@property (strong, nonatomic) NSString *receiver;       /*! 接受者 */
@property (strong, nonatomic) NSString *type;           /*! 消息类型(1,文字2,图文) */
@property (strong, nonatomic) NSString *carder;         /*! 标记老师身份 */

@end
