//
//  HXLingShenController.m
//  HXTG
//
//  Created by grx on 2017/5/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXLingShenController.h"
#import "HXStraReportController.h"
#import "HXLineTalksController.h"
#import "HXOpenClassDetailController.h"

@interface HXLingShenController (){
    HXStraReportController *repaotView;
    HXLineTalksController *lineView;
    UIScrollView *segentScrollView;
    UIView *segmentLine;

}

@end

@implementation HXLingShenController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.navigationItem.title = @"量身定制";
    /*! 分段选择 */
    UIView *segmentView = [UIView new];
    [self.view addSubview:segmentView];
    segmentView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,64).heightIs(40);
    NSArray *titleArray = @[@"专属方案",@"首席策略会"];
    for (int i=0; i<titleArray.count; i++) {
        UIButton *segButton = [[UIButton alloc]initWithFrame:CGRectMake(i*Main_Screen_Width/titleArray.count, 0, Main_Screen_Width/titleArray.count, 40)];
        segButton.tag = i+10;
        segButton.backgroundColor = UIColorWhite;
        [segButton setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
        segButton.titleLabel.font = UIFontSystem14;
        [segmentView addSubview:segButton];
        [segButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [segButton addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
        if (segButton.tag==10) {
            [segButton setTitleColor:UIColorHigRedTheme forState:UIControlStateNormal];
        }
    }
    segmentLine = [[UIView alloc] initWithFrame:CGRectMake(0, 38, Main_Screen_Width/titleArray.count, 2)];
    segmentLine.backgroundColor = UIColorRedTheme;
    [segmentView addSubview:segmentLine];
    /*! segentScrollView */
    segentScrollView = [UIScrollView new];
    segentScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    segentScrollView.pagingEnabled = YES;
    segentScrollView.delegate = self;
    segentScrollView.bounces = NO;
    segentScrollView.alwaysBounceVertical = NO;
    segentScrollView.alwaysBounceHorizontal = YES;
    segentScrollView.showsHorizontalScrollIndicator = NO;
    segentScrollView.showsVerticalScrollIndicator = NO;
    segentScrollView.backgroundColor = [UIColor whiteColor];
    segentScrollView.contentSize = CGSizeMake(Main_Screen_Width * titleArray.count, Main_Screen_Height-50);
    [self.view addSubview:segentScrollView];
    segentScrollView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(segmentView,8).heightIs(Main_Screen_Height-50);
    /*! 策略报告 */
    repaotView = [[HXStraReportController alloc]init];
    repaotView.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-50);
    [segentScrollView addSubview:repaotView.view];
    WeakSelf(weakSelf);
    repaotView.straReportClick = ^(HXStraReportModel *model){
        HXOpenClassDetailController *detailVC = [[HXOpenClassDetailController alloc]init];
        detailVC.postId = model.post_id;
        detailVC.playTitle = model.post_title;
        detailVC.title = @"专属方案";
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    };
    /*! 线下会谈 */
    lineView = [[HXLineTalksController alloc]init];
    lineView.view.frame = CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, Main_Screen_Height-50);
    [segentScrollView addSubview:lineView.view];
    lineView.popToController = ^(){
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    if (![self.curenListArray containsObject:@"18"]) {
        segentScrollView.contentOffset = [self ScrollViewWithContentOffSetPage:1];
    }
    if (![self.curenListArray containsObject:@"19"]) {
        segentScrollView.contentOffset = [self ScrollViewWithContentOffSetPage:0];
    }
}

-(void)segmentClick:(UIButton *)sender
{
    UIButton *firBtn = (UIButton *)[self.view viewWithTag:10];
    UIButton *secBtn = (UIButton *)[self.view viewWithTag:11];
    if (sender.tag == 10) {
        if ([self.curenListArray containsObject:@"18"]) {
        [sender setTitleColor:UIColorHigRedTheme forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            segmentLine.frame = CGRectMake(0, 38, Main_Screen_Width/2, 2);
            segentScrollView.contentOffset = [self ScrollViewWithContentOffSetPage:0];
            [secBtn setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
        }];
        }else{
            HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"对不起,你没有该产品权限,可能有以下原因:\n1.您还没有付款；\n2.付费用户已经过了有效期。" centerButtonTitle:@"确定"];
            alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
            alter.centerBlock=^()
            {
            };
            [alter show];
        }

    }else if (sender.tag == 11){
        if ([self.curenListArray containsObject:@"19"]) {
            [sender setTitleColor:UIColorHigRedTheme forState:UIControlStateNormal];
            [UIView animateWithDuration:0.2 animations:^{
                segmentLine.frame = CGRectMake(Main_Screen_Width/2, 38, Main_Screen_Width/2, 2);
                segentScrollView.contentOffset = [self ScrollViewWithContentOffSetPage:1];
                [firBtn setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
            }];
        }else{
            HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"对不起,你没有该产品权限,可能有以下原因:\n1.您还没有付款；\n2.付费用户已经过了有效期。" centerButtonTitle:@"确定"];
            alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
            alter.centerBlock=^()
            {
            };
            [alter show];
        }
    }
}

#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIButton *firBtn = (UIButton *)[self.view viewWithTag:10];
    UIButton *secBtn = (UIButton *)[self.view viewWithTag:11];
    if (scrollView.contentOffset.x == 0) {
        if ([self.curenListArray containsObject:@"18"]) {
        [UIView animateWithDuration:0.2 animations:^{
            segmentLine.frame = CGRectMake(0, 38, Main_Screen_Width/2, 2);
            [firBtn setTitleColor:UIColorHigRedTheme forState:UIControlStateNormal];
            [secBtn setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
        }];
        }else{
            segentScrollView.contentOffset = [self ScrollViewWithContentOffSetPage:1];
            HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"对不起,你没有该产品权限,可能有以下原因:\n1.您还没有付款；\n2.付费用户已经过了有效期。" centerButtonTitle:@"确定"];
            alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
            alter.centerBlock=^()
            {
            };
            [alter show];
        }
    }else if (scrollView.contentOffset.x == Main_Screen_Width){
        if ([self.curenListArray containsObject:@"19"]) {
            [UIView animateWithDuration:0.2 animations:^{
                segmentLine.frame = CGRectMake(Main_Screen_Width/2, 38, Main_Screen_Width/2, 2);
                [firBtn setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
                [secBtn setTitleColor:UIColorHigRedTheme forState:UIControlStateNormal];
            }];
        }else{
            segentScrollView.contentOffset = [self ScrollViewWithContentOffSetPage:0];
            HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"对不起,你没有该产品权限,可能有以下原因:\n1.您还没有付款；\n2.付费用户已经过了有效期。" centerButtonTitle:@"确定"];
            alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
            alter.centerBlock=^()
            {
            };
            [alter show];
        }
    }
}

/*! 返回scrollView偏移量 */
- (CGPoint)ScrollViewWithContentOffSetPage:(NSInteger)page{
    return CGPointMake(([UIScreen mainScreen].bounds.size.width) * page, 0);
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
