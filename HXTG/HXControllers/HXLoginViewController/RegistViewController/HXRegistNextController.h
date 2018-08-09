//
//  HXRegistNextController.h
//  HXTG
//
//  Created by grx on 2017/2/28.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXRegistNextController : UIViewController

@property (strong, nonatomic) NSString *userName;  /*! 用户名 */
@property (strong, nonatomic) NSString *userPws;   /*! 密码 */
@property (strong, nonatomic) NSString *invitation;   /*! 邀请码 */

-(instancetype)initWithUserName:(NSString *)userName userPws:(NSString *)passWord Invitation:(NSString *)invitation;

@end
