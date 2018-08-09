//
//  HXExtraServerController.m
//  HXTG
//
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXExtraServerController.h"
#import "HXOperatePlanController.h"
#import "HXTrainingClassController.h"
#import "HXOpenClassDetailController.h"

@interface HXExtraServerController ()<UIScrollViewDelegate>{
    HXOperatePlanController *planView;
    HXTrainingClassController *trainingView;
    UIScrollView *segentScrollView;
    UIView *segmentLine;
}

@end

@implementation HXExtraServerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.navigationItem.title = @"附加服务";
    /*! 分段选择 */
    UIView *segmentView = [UIView new];
    [self.view addSubview:segmentView];
    segmentView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,64).heightIs(40);
    NSArray *titleArray = @[@"操盘计划",@"培训课程"];
    for (int i=0; i<2; i++) {
        UIButton *segButton = [[UIButton alloc]initWithFrame:CGRectMake(i*Main_Screen_Width/2, 0, Main_Screen_Width/2, 40)];
        segButton.tag = i+10;
        segButton.backgroundColor = UIColorWhite;
        [segButton setTitleColor:UIColorHigRedTheme forState:UIControlStateNormal];
        segButton.titleLabel.font = UIFontSystem14;
        [segmentView addSubview:segButton];
        [segButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [segButton addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
        if (segButton.tag==11) {
            [segButton setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
        }
    }
    segmentLine = [[UIView alloc] initWithFrame:CGRectMake(0, 38, Main_Screen_Width/2, 2)];
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
    /*! 操盘计划 */
    planView = [[HXOperatePlanController alloc]init];
    planView.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-50);
    [segentScrollView addSubview:planView.view];
    WeakSelf(weakSelf);
    planView.operateClick = ^(HXTraderPlanModel *model){
            HXOpenClassDetailController *detailVC = [[HXOpenClassDetailController alloc]init];
            detailVC.postId = model.post_id;
            detailVC.playTitle = model.post_title;
            detailVC.title = @"操盘计划";
            [weakSelf.navigationController pushViewController:detailVC animated:YES];
    };
    if (![self.curenListArray containsObject:@"6"]) {
        segentScrollView.contentOffset = [self ScrollViewWithContentOffSetPage:1];
    }
    if (![self.curenListArray containsObject:@"7"]) {
        segentScrollView.contentOffset = [self ScrollViewWithContentOffSetPage:0];
    }
    
}


-(void)segmentClick:(UIButton *)sender
{
    if (sender.tag == 10) {
        if ([self.curenListArray containsObject:@"6"]) {
        [sender setTitleColor:UIColorHigRedTheme forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            segmentLine.frame = CGRectMake(0, 38, Main_Screen_Width/2, 2);
            segentScrollView.contentOffset = [self ScrollViewWithContentOffSetPage:0];
            UIButton *otherBtn = (UIButton *)[self.view viewWithTag:11];
            [otherBtn setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];

        }];
        }else{
            HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"对不起,你没有该产品权限,可能有以下原因:\n1.您还没有付款；\n2.付费用户已经过了有效期。" centerButtonTitle:@"确定"];
            alter.alertContentLabel.textAlignment = NSTextAlignmentLeft;
            alter.centerBlock=^()
            {
            };
            [alter show];
        }
    }else{
        if ([self.curenListArray containsObject:@"7"]) {
            [sender setTitleColor:UIColorHigRedTheme forState:UIControlStateNormal];
        /*! 培训课程 */
        WeakSelf(weakSelf);
        if (!trainingView) {
            trainingView = [[HXTrainingClassController alloc]init];
            trainingView.view.frame = CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, Main_Screen_Height-50);
            [segentScrollView addSubview:trainingView.view];
            trainingView.trainingClassClick = ^(HXTrainingCourseModel *model){
                HXOpenClassDetailController *detailVC = [[HXOpenClassDetailController alloc]init];
                detailVC.postId = model.post_id;
                detailVC.playTitle = model.post_title;
                detailVC.title = @"培训课程";
                [weakSelf.navigationController pushViewController:detailVC animated:YES];
            };
        }

        [UIView animateWithDuration:0.2 animations:^{
            segmentLine.frame = CGRectMake(Main_Screen_Width/2, 38, Main_Screen_Width/2, 2);
            segentScrollView.contentOffset = [self ScrollViewWithContentOffSetPage:1];
            UIButton *otherBtn = (UIButton *)[self.view viewWithTag:10];
            [otherBtn setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
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
    if (scrollView.contentOffset.x == 0) {
        if ([self.curenListArray containsObject:@"6"]) {
        [UIView animateWithDuration:0.2 animations:^{
            segmentLine.frame = CGRectMake(0, 38, Main_Screen_Width/2, 2);
            UIButton *selectBtn = (UIButton *)[self.view viewWithTag:10];
            [selectBtn setTitleColor:UIColorHigRedTheme forState:UIControlStateNormal];
            UIButton *otherBtn = (UIButton *)[self.view viewWithTag:11];
            [otherBtn setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
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
        
        if ([self.curenListArray containsObject:@"7"]) {
        /*! 培训课程 */
        WeakSelf(weakSelf);
        if (!trainingView) {
            trainingView = [[HXTrainingClassController alloc]init];
            trainingView.view.frame = CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, Main_Screen_Height-50);
            [segentScrollView addSubview:trainingView.view];
            trainingView.trainingClassClick = ^(HXTrainingCourseModel *model){
                HXOpenClassDetailController *detailVC = [[HXOpenClassDetailController alloc]init];
                detailVC.postId = model.post_id;
                detailVC.playTitle = model.post_title;
                detailVC.title = @"培训课程";
                [weakSelf.navigationController pushViewController:detailVC animated:YES];
            };
        }
        [UIView animateWithDuration:0.2 animations:^{
            segmentLine.frame = CGRectMake(Main_Screen_Width/2, 38, Main_Screen_Width/2, 2);
            UIButton *otherBtn = (UIButton *)[self.view viewWithTag:10];
            [otherBtn setTitleColor:UIColorBlackTheme forState:UIControlStateNormal];
            UIButton *selectBtn = (UIButton *)[self.view viewWithTag:11];
            [selectBtn setTitleColor:UIColorHigRedTheme forState:UIControlStateNormal];
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
