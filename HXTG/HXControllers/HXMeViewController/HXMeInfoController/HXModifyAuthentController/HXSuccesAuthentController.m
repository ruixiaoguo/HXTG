//
//  HXSuccesAuthentController.m
//  HXTG
//
//  Created by grx on 2017/4/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXSuccesAuthentController.h"
#import "UserInfoModel.h"
#import "HXMeInfoController.h"

@interface HXSuccesAuthentController (){
    UserInfoModel *infoModel;
}

@end

@implementation HXSuccesAuthentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    self.backButton.hidden = NO;
    /*! 获取个人资料 */
    NSString *infoPath = [GlobalFile directoryPathWithFileName:USERINFO_KEY];
    infoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:infoPath];
    [self creatSuccesAuthentUI];
}

#pragma mark - 创建UI
-(void)creatSuccesAuthentUI
{
    /*! 图片 */
    UIImageView *succesImage = [UIImageView new];
    succesImage.image = [UIImage imageNamed:@"renzhengchenggong"];
    [self.view addSubview:succesImage];
    succesImage.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view,84).widthIs(60).heightIs(60);
    /*! 认证成功提示 */
    UILabel *tiplable = [UILabel new];
    tiplable.text = @"您已通过实名认证!";
    tiplable.font = UIFontSystem14;
    tiplable.textColor = UIColorBlackTheme;
    tiplable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tiplable];
    tiplable.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(succesImage,0).rightSpaceToView(self.view,0).heightIs(35);
    /*! 用户信息 */
    UIView *bgView = [UIView new];
    bgView.backgroundColor = UIColorWhite;
    [self.view addSubview:bgView];
    bgView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(tiplable,10).heightIs(80);
    NSArray *titleArray = @[@"真实姓名:",@"身份证号:"];
    NSString *nameStr = infoModel.realname;
    NSString *realNameStr = [infoModel.realname stringByReplacingOccurrencesOfString:[infoModel.realname substringWithRange:NSMakeRange(1,nameStr.length-1)]withString:@"**"];

    NSString *idCartStr=[infoModel.unumber stringByReplacingOccurrencesOfString:[infoModel.unumber substringWithRange:NSMakeRange(3,11)]withString:@"***********"];
    NSArray *contentArray = @[realNameStr,idCartStr];

    for (int i=0; i<2; i++) {
        /*! 标题 */
        UILabel *titlelable = [UILabel new];
        titlelable.font = UIFontSystem14;
        titlelable.textColor = UIColorBlackTheme;
        titlelable.text = titleArray[i];
        [bgView addSubview:titlelable];
        titlelable.sd_layout.leftSpaceToView(bgView,15).topSpaceToView(bgView,10+i*30).widthIs(70).heightIs(30);
        /*! 内容 */
        UILabel *contentlable = [UILabel new];
        contentlable.font = UIFontSystem14;
        contentlable.textColor = UIColorBlackTheme;
        contentlable.text = contentArray[i];
        [bgView addSubview:contentlable];
        contentlable.sd_layout.leftSpaceToView(titlelable,0).topSpaceToView(bgView,10+i*30).rightSpaceToView(bgView,15).heightIs(30);
    }
    /*! 描述 */
    UIImageView *tishiImage = [UIImageView new];
    tishiImage.image = [UIImage imageNamed:@"tishi"];
    [self.view addSubview:tishiImage];
    tishiImage.sd_layout.leftSpaceToView(self.view,17).topSpaceToView(bgView,15).widthIs(15).heightIs(15);
    UILabel *discritLable = [UILabel new];
    [self.view addSubview:discritLable];
    discritLable.font = UIFontSystem(12);
    discritLable.textColor = ColorWithHexRGB(0xef3540);
    discritLable.text = @"验证通过,如果修改姓名或身份证号,请您拨打400-098-7966提交人工服务。";
    discritLable.text = [discritLable.text stringByAppendingString:@"\n "];
    discritLable.lineBreakMode = 1;
    discritLable.numberOfLines = 0;
    discritLable.sd_layout.leftSpaceToView(tishiImage,5).topSpaceToView(bgView,9).rightSpaceToView(self.view,15).heightIs(40);

}

-(void)backClick
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HXMeInfoController class]]) {
            HXMeInfoController *infoVC =(HXMeInfoController *)controller;
            [self.navigationController popToViewController:infoVC animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
