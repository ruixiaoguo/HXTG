//
//  HXColumnView.m
//  HXTG
//
//  Created by grx on 2017/2/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXColumnView.h"

@implementation HXColumnView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = UIColorWhite;
    }
    return self;
}

-(void)markeHeadView:(UIView *)surperView isCheck:(NSString *)isCheck
{
#pragma mark - =============创建北京事业部栏目View======================

    if (!bjBgView) {
    bjBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 150)];
    [surperView addSubview:bjBgView];
    /*! 图片 */
    /*! 早盘必读图片控制 */
    NSString *zaoPanFree;
    if ([isCheck isEqualToString:@"yes"]) {
        zaoPanFree = @"zaopanbiduTest";
    }else{
        zaoPanFree = @"zaopanbidu";
    }
    /*! 公开课图片控制 */
    NSString *gongKaiFree;
    if ([isCheck isEqualToString:@"yes"]) {
        gongKaiFree = @"gongkaikeTest";
    }else{
        gongKaiFree = @"gongkaike";
    }
    NSArray *imageArray = @[zaoPanFree,gongKaiFree,@"gupiaochi",@"zhibojiepan",@"touguneican",@"fujiafuwu",@"gaoduanzhuanshu",@"wenlaoshi"];
        
    for (int i=0; i<2; i++) {
        for (int j=0; j<4; j++) {
            UIImageView *columBtn = [[UIImageView alloc]init];
            float btnWidth = 32;
            float btnHight = 32;

            float verSpacing = 69;
            float indexPath = (Main_Screen_Width - 45*2 - btnWidth*3)/3;
            columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 0, btnWidth, btnHight);
            columBtn.centerY = 28+i*verSpacing;
            [bjBgView addSubview:columBtn];
            columBtn.tag = i*10+j+1;
            if (columBtn.tag==1) {
                if ([isCheck isEqualToString:@"yes"]) {
                    columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 13, btnWidth-4, btnHight-4);
                }else{
                    columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 13, btnWidth, btnHight);
                }
            }
            if (columBtn.tag==2) {
                if ([isCheck isEqualToString:@"yes"]) {
                    columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 18, btnWidth, btnHight-12);
                }else{
                    columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth, btnHight-7);
                }
            }
            if (columBtn.tag==3) {
                columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-8, btnHight-8);
            }
            if (columBtn.tag==4) {
                columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-2, btnHight-8);
            }if (columBtn.tag==11) {
                columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-4, btnHight-10);
                columBtn.centerY = 28+i*verSpacing;
            }if (columBtn.tag==12) {
                columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth)+2, 15, btnWidth-10, btnHight-8);
                columBtn.centerY = 28+i*verSpacing;
            }if (columBtn.tag==13) {
                columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-5, btnHight-8);
                columBtn.centerY = 28+i*verSpacing;
            }if (columBtn.tag==14) {
                columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-5, btnHight-10);
                columBtn.centerY = 28+i*verSpacing;
            }
            if (i==0) {
                columBtn.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[columBtn.tag-1]]];
            }else{
                columBtn.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[columBtn.tag-7]]];
            }
        }
    }
    /*! 标题 */
    NSArray *titleArray = @[@"早盘必读",@"公开课",@"股票池",@"视频解盘",@"投顾内参",@"附加服务",@"高端专属",@"问老师"];
    
    for (int i=0; i<2; i++) {
        for (int j=0; j<4; j++) {
            UILabel *columLable = [[UILabel alloc]init];
            float lableHight = 20;
            columLable.frame = CGRectMake(0, 0, 80, lableHight);
            float verSpacing = 65;
            UIImageView * btn = (UIImageView *)[self viewWithTag:i*10+j+1];
            columLable.centerX = btn.centerX;
            columLable.centerY = 30+verSpacing/2.3+i*verSpacing;
            columLable.textAlignment = NSTextAlignmentCenter;
            columLable.font = [UIFont systemFontOfSize:12];
            columLable.textColor = UIColorBlackTheme;
            [bjBgView addSubview:columLable];
            columLable.tag = 100+i*10+j;
            if (i==0) {
                columLable.text = titleArray[columLable.tag-100];
            }else{
                columLable.text = titleArray[columLable.tag-106];
            }
        }
    }
    /*! bgView */
    for (int i=0; i<2; i++) {
        for (int j=0; j<4; j++) {
            UIView *bgView = [[UIView alloc]init];
            float verSpacing = 150/2;
            float indexPath = Main_Screen_Width/4;
            bgView.frame = CGRectMake(j*indexPath, 0, indexPath, verSpacing);
            bgView.centerY = 38+i*verSpacing;
            bgView.tag = i*10+j+1;
            [bjBgView addSubview:bgView];
            /*! 手势 */
            UITapGestureRecognizer* singleRecognizer;
            singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bjColumBtnClickTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [bgView addGestureRecognizer:singleRecognizer];
        }
    }
    }
#pragma mark - =============创建重庆事业部栏目View======================

        if (!cqBgView) {
            /*! 图片 */
            /*! 早盘必读图片控制 */
            NSString *zaoPanFree;
            if ([isCheck isEqualToString:@"yes"]) {
                zaoPanFree = @"zaopanbiduTest";
            }else{
                zaoPanFree = @"zaopanbidu";
            }
            /*! 公开课图片控制 */
            NSString *gongKaiFree;
            if ([isCheck isEqualToString:@"yes"]) {
                gongKaiFree = @"gongkaikeTest";
            }else{
                gongKaiFree = @"gongkaike";
            }
            cqBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 210)];
            [surperView addSubview:cqBgView];
            NSArray *imageArray = @[zaoPanFree,gongKaiFree,@"gupiaochi",@"zhibojiepan",@"touguneican",@"cuozuobg",@"gaoduanzhuanshu",@"wenlaoshi",@"jigoujiepan",@"",@"",@""];
            for (int i=0; i<3; i++) {
                for (int j=0; j<4; j++) {
                    UIImageView *columBtn = [[UIImageView alloc]init];
                    float btnWidth = 32;
                    float btnHight = 32;
                    float verSpacing = 69;
                    float indexPath = (Main_Screen_Width - 45*2 - btnWidth*3)/3;
                    columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 0, btnWidth, btnHight);
                    columBtn.centerY = 28+i*verSpacing;
                    [cqBgView addSubview:columBtn];
                    columBtn.tag = i*10+j+1;
                    if (columBtn.tag==1) {
                        if ([isCheck isEqualToString:@"yes"]) {
                            columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-5, btnHight-5);
                        }else{
                            columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 13, btnWidth, btnHight);
                        }
                    }
                    if (columBtn.tag==2) {
                        if ([isCheck isEqualToString:@"yes"]) {
                            columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 18, btnWidth, btnHight-12);
                        }else{
                            columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth, btnHight-7);
                        }
                    }
                    if (columBtn.tag==3) {
                        columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-8, btnHight-8);
                    }
                    if (columBtn.tag==4) {
                        columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-2, btnHight-8);
                    }if (columBtn.tag==11) {
                        columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-4, btnHight-10);
                        columBtn.centerY = 28+i*verSpacing;
                    }if (columBtn.tag==12) {
                        columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth)+2, 15, btnWidth-6, btnHight-6);
                        columBtn.centerY = 28+i*verSpacing;
                    }if (columBtn.tag==13) {
                        columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-5, btnHight-8);
                        columBtn.centerY = 28+i*verSpacing;
                    }if (columBtn.tag==14) {
                        columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-5, btnHight-10);
                        columBtn.centerY = 28+i*verSpacing;
                    }if (columBtn.tag==21) {
                        columBtn.frame = CGRectMake((45-btnWidth/2)+j*(indexPath+btnWidth), 15, btnWidth-6, btnHight-6);
                        columBtn.centerY = 23+i*verSpacing;
                    }
                    if (i==0) {
                        columBtn.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[columBtn.tag-1]]];
                    }else if (i==1){
                        columBtn.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[columBtn.tag-7]]];
                    }else if (i==2){
                        columBtn.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[columBtn.tag-13]]];
                    }
                }
            }
            /*! 标题 */
            NSArray *titleArray = @[@"早盘必读",@"公开课",@"股票池",@"视频解盘",@"投顾内参",@"操作报告",@"量身定制",@"问老师",@"机构实盘",@"",@"",@""];
            
            for (int i=0; i<3; i++) {
                for (int j=0; j<4; j++) {
                    UILabel *columLable = [[UILabel alloc]init];
                    float lableHight = 20;
                    columLable.frame = CGRectMake(0, 0, 80, lableHight);
                    float verSpacing = 65;
                    UIButton * btn = (UIButton *)[self viewWithTag:i*10+j+1];
                    columLable.centerX = btn.centerX;
                    columLable.centerY = 30+verSpacing/2.3+i*verSpacing;
                    columLable.textAlignment = NSTextAlignmentCenter;
                    columLable.font = [UIFont systemFontOfSize:12];
                    columLable.textColor = UIColorBlackTheme;
                    [cqBgView addSubview:columLable];
                    columLable.tag = 100+i*10+j;
                    if (i==0) {
                        columLable.text = titleArray[columLable.tag-100];
                    }else if(i==1){
                        columLable.text = titleArray[columLable.tag-106];
                    }else if(i==2){
                        columLable.text = titleArray[columLable.tag-112];
                    }
                }
            }
            /*! bgView */
            for (int i=0; i<3; i++) {
                for (int j=0; j<4; j++) {
                    UIView *bgView = [[UIView alloc]init];
                    float verSpacing = 215/3;
                    float indexPath = Main_Screen_Width/4;
                    bgView.frame = CGRectMake(j*indexPath, 0, indexPath, verSpacing);
                    bgView.centerY = 35+i*verSpacing;
                    bgView.tag = i*10+j+1;
                    [cqBgView addSubview:bgView];
                    /*! 手势 */
                    UITapGestureRecognizer* singleRecognizer;
                    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cqColumBtnClickTap:)];
                    singleRecognizer.numberOfTapsRequired = 1;
                    [bgView addGestureRecognizer:singleRecognizer];
                }
            }
        }
    
    NSString *busId = [NSString stringWithFormat:@"%@",USERBUSINESSID];
    if ([busId isEqualToString:@"135"]) {
        bjBgView.hidden = YES;
        cqBgView.hidden = NO;
    }else{
        bjBgView.hidden = NO;
        cqBgView.hidden = YES;
    }
}

-(void)bjColumBtnClickTap:(UITapGestureRecognizer *)recognizer
{
    DDLog(@"bjtag======%ld",recognizer.view.tag);
    if (self.bjColumnClickBlock) {
        self.bjColumnClickBlock(recognizer.view.tag);
    }
}


-(void)cqColumBtnClickTap:(UITapGestureRecognizer *)recognizer
{
    DDLog(@"tag======%ld",recognizer.view.tag);
    if (self.cqColumnClickBlock) {
        self.cqColumnClickBlock(recognizer.view.tag);
    }
}


@end
