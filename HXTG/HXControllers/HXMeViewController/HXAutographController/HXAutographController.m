//
//  HXAutographController.m
//  HXTG
//
//  Created by grx on 2017/3/1.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXAutographController.h"
#import "HXPaintView.h"
#import "UIImage+MSTool.h"
#import "HXHandleImageView.h"

@interface HXAutographController ()<HXHandleImageViewDelegate>

@property(nonatomic,strong) HXPaintView *paintView;

@end

@implementation HXAutographController

/*! 懒加载绘画板 */

-(HXPaintView *)paintView
{
    if (!_paintView) {
        _paintView = [[HXPaintView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 200)];
        _paintView.backgroundColor = [UIColor clearColor];
        self.paintView.lineColor = [UIColor blackColor];
        self.paintView.lineWidth = 2;
    }
    return _paintView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"在线签约";
    /*! 添加绘画板 */
    [self.view addSubview:self.paintView];
    /*! 添加撤销和保存 */
    [self addClearWithSaveBUtton];
}

-(void)addClearWithSaveBUtton
{
    NSArray *titleArray = @[@"清屏",@"保存"];
    for (int i=0; i<2; i++) {
        UIButton *actionBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*Main_Screen_Width/2, 264, Main_Screen_Width/2, 50)];
        [actionBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        actionBtn.tag = i+10;
        [actionBtn addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:actionBtn];
    }
}

-(void)actionBtnClick:(UIButton *)sender
{
    if (sender.tag == 10) {
        /*! 清屏 */
        [self.paintView clearScreen];
    }else{
        /*! 保存 */
        /*! 截屏获取图片 */
        UIImage *newImgae = [UIImage imageWithCaptureView:self.paintView];
        /*! 保存到相册 */
        UIImageWriteToSavedPhotosAlbum(newImgae, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [MBProgressHUD showSuccess:@"保存成功"];
    }else{
        [MBProgressHUD showError:@"保存失败"];
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
