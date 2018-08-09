//
//  HXMessageSetController.m
//  HXTG
//
//  Created by grx on 2017/3/31.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMessageSetController.h"

@interface HXMessageSetController (){
    UISwitch *msgSwitch;
}

@end

@implementation HXMessageSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息设置";
    self.backButton.hidden = NO;
    [self creatMessageUI];
}

#pragma mark - 创建视图
-(void)creatMessageUI
{
    NSArray *titleArray = @[@"消息提醒设置"];
    CGFloat fieldHight = 45;
    for (int i=0; i<titleArray.count; i++) {
        /*! 背景View */
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        bgView.tag = 100+i;
        bgView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,75+i*(fieldHight+5)).heightIs(fieldHight);
        /*! 手势 */
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClickTap:)];
        singleRecognizer.numberOfTapsRequired = 1;
        [bgView addGestureRecognizer:singleRecognizer];
        /*! 标题 */
        UILabel *titleLable = [UILabel new];
        [bgView addSubview:titleLable];
        titleLable.font = UIFontSystem15;
        titleLable.textColor = UIColorBlackTheme;
        titleLable.tag = i+10;
        titleLable.text = titleArray[titleLable.tag-10];
        titleLable.sd_layout.leftSpaceToView(bgView,15).topSpaceToView(bgView,2).widthIs(170).heightIs(bgView.frame.size.height);
        /*! 箭头 */
        UIImageView *tipImage = [UIImageView new];
        tipImage.image = [UIImage imageNamed:@"arrow"];
        [bgView addSubview:tipImage];
        tipImage.sd_layout.rightSpaceToView(bgView,15).centerYEqualToView(bgView).widthIs(8).heightIs(15);

        /*! 消息开关 */
//        msgSwitch = [UISwitch new];
//        msgSwitch.on=YES;
//        /*! 设置开启状态的风格颜色 */
//        [msgSwitch setOnTintColor:UIColorBlueTheme];
//        /*! 设置开关大小 */
//         msgSwitch.transform = CGAffineTransformMakeScale(0.85, 0.85);
//        msgSwitch.tag = i+20;
//        [bgView addSubview:msgSwitch];
//        msgSwitch.sd_layout.rightSpaceToView(bgView,10).topSpaceToView(bgView,14).widthIs(20).heightIs(10);
//        [msgSwitch addTarget:self action:@selector(swChange:) forControlEvents:UIControlEventValueChanged];
//        if (bgView.tag==102) {
//            UILabel *discriLable = [UILabel new];
//            discriLable.font = UIFontSystem11;
//            discriLable.textColor = UIColorLightTheme;
//            discriLable.text = @"开启后只接收已关注股票动态";
//            [bgView addSubview:discriLable];
//            discriLable.sd_layout.leftSpaceToView(titleLable,0).topSpaceToView(bgView,3).widthIs(200).heightIs(fieldHight);
//        }
    }
}

///*! 开关选择 */
//- (void) swChange:(UISwitch*)sw{
//    
//    if (sw.tag==20) {
//        if(sw.on==YES){
//            NSLog(@"开关被打开");
//        }else{
//            NSLog(@"开关被关闭");
//        }
//    }
//}

-(void)bgViewClickTap:(UITapGestureRecognizer *)recognizer
{
    /*! 跳转到设置 */
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}


-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
