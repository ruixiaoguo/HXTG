//
//  HXAddImage.m
//  HXTG
//
//  Created by grx on 2017/4/10.
//  Copyright © 2017年 grx. All rights reserved.
//

//
//  SZAddImage.m
//  addImage
//
//  Created by mac on 14-5-21.
//  Copyright (c) 2014年 shunzi. All rights reserved.
//

#define imageH 50 // 图片高度
#define imageW 50 // 图片宽度
#define kMaxColumn 5 // 每行显示数量
#define MaxImageCount 5 // 最多显示图片个数
#define deleImageWH 35 // 删除按钮的宽高
#define kAdeleImage @"delete_pic.png" // 删除按钮图片
#define kAddImage @"tupian.png" // 添加按钮图片



#import "HXAddImage.h"
#import "UIView+WZLBadge.h"
@interface HXAddImage()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    // 标识被编辑的按钮 -1 为添加新的按钮
    NSInteger editTag;
}
@end

@implementation HXAddImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [self createButtonWithImage:kAddImage andSeletor:@selector(addNew:)];
        [self addSubview:btn];
    }
    return self;
}

-(NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

// 添加新的控件
- (void)addNew:(UIButton *)btn
{
    // 标识为添加一个新的图片
    
    if (![self deleClose:btn]) {
        editTag = -1;
        [self callImagePicker];
    }
    
    
}

// 修改旧的控件
- (void)changeOld:(UIButton *)btn
{
    // 标识为修改(tag为修改标识)
//    if (![self deleClose:btn]) {
//        editTag = btn.tag;
//        [self callImagePicker];
//    }
//    [self callImagePicker];

}

// 删除"删除按钮"
- (BOOL)deleClose:(UIButton *)btn
{
    if (btn.subviews.count == 2) {
        [[btn.subviews lastObject] removeFromSuperview];
        [self stop:btn];
        return YES;
    }
    
    return NO;
}

// 调用图片选择器
- (void)callImagePicker
{
    
    [self photoWallAddAction];
//    if (self.callImagePickerClick) {
//        self.callImagePickerClick();
//    }
//    UIImagePickerController *pc = [[UIImagePickerController alloc] init];
//    pc.allowsEditing = YES;
//    pc.delegate = self;
//    [self.window.rootViewController presentViewController:pc animated:YES completion:nil];
}

- (void)photoWallAddAction
{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"请选择" otherButtonTitles:@"从相机选择",@"从图库选择", nil];
    [sheet showInView:self.window.rootViewController.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *pc=[[UIImagePickerController alloc]init];
    pc.delegate=self;
    pc.allowsEditing=YES;
    /*! 选择图片 */
    if (buttonIndex == 1)
    {
        pc.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self.window.rootViewController presentViewController:pc animated:YES completion:nil];
    }else if (buttonIndex == 2){
        
        pc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self.window.rootViewController presentViewController:pc animated:YES completion:nil];
    }
}



// 根据图片名称或者图片创建一个新的显示控件
- (UIButton *)createButtonWithImage:(id)imageNameOrImage andSeletor : (SEL)selector
{
    UIImage *addImage = nil;
    if ([imageNameOrImage isKindOfClass:[NSString class]]) {
        addImage = [UIImage imageNamed:imageNameOrImage];
    }
    else if([imageNameOrImage isKindOfClass:[UIImage class]])
    {
        addImage = imageNameOrImage;
    }
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.layer.cornerRadius = 5.0;
//    [addBtn.layer setMasksToBounds:YES];
    [addBtn setImage:addImage forState:UIControlStateNormal];
    [addBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = self.subviews.count;

    if(addBtn.tag != 0)
    {
        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
        [dele setBackgroundImage:[UIImage imageNamed:kAdeleImage] forState:UIControlStateNormal];
        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        dele.frame = CGRectMake(40, -6, 15, 15);
        [addBtn addSubview:dele];
    }
    
    return addBtn;
    
}


// 长按添加删除按钮
//- (void)longPress : (UIGestureRecognizer *)gester
//{
//    if (gester.state == UIGestureRecognizerStateBegan)
//    {
//        UIButton *btn = (UIButton *)gester.view;
//        
//        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
//        dele.bounds = CGRectMake(0, 0, deleImageWH, deleImageWH);
////        [dele setImage:[UIImage imageNamed:kAdeleImage] forState:UIControlStateNormal];
//        [dele setBackgroundImage:[UIImage imageNamed:kAdeleImage] forState:UIControlStateNormal];
//        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
//        dele.frame = CGRectMake(btn.frame.size.width-15, 0, 15, 15);
//        
//        [btn addSubview:dele];
//        [self start : btn];
//        
//        
//    }
//    
//}

// 长按开始抖动
- (void)start : (UIButton *)btn {
    double angle1 = -5.0 / 180.0 * M_PI;
    double angle2 = 5.0 / 180.0 * M_PI;
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    
    anim.values = @[@(angle1),  @(angle2), @(angle1)];
    anim.duration = 0.25;
    // 动画的重复执行次数
    anim.repeatCount = MAXFLOAT;
    
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [btn.layer addAnimation:anim forKey:@"shake"];
}

// 停止抖动
- (void)stop : (UIButton *)btn{
    [btn.layer removeAnimationForKey:@"shake"];
}

// 删除图片
- (void)deletePic : (UIButton *)btn
{
    [self.images removeObject:[(UIButton *)btn.superview imageForState:UIControlStateNormal]];
    [btn.superview removeFromSuperview];
    if ([[self.subviews lastObject] isHidden]) {
        [[self.subviews lastObject] setHidden:NO];
    }
    
    
}

// 对所有子控件进行布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = self.subviews.count;
    CGFloat btnW = imageW;
    CGFloat btnH = imageH;
//    int maxColumn = kMaxColumn > self.frame.size.width / imageW ? self.frame.size.width / imageW : kMaxColumn;
//    CGFloat marginX = (self.frame.size.width - maxColumn * btnW) / (count + 1);
    CGFloat marginX = (self.frame.size.width - 5 * 50-30) / 4;
    DDLog(@"marginX====%f",marginX);
//    CGFloat marginY = marginX;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
//        CGFloat btnX = (i % maxColumn) * (marginX + btnW) + marginX;
//        CGFloat btnY = (i / maxColumn) * (marginY + btnH) + marginY;
        CGFloat btnX = i * (50+marginX) + 15;
        CGFloat btnY = 10;

        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }
    
}

#pragma mark - UIImagePickerController 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (editTag == -1) {
        // 创建一个新的控件
        UIButton *btn = [self createButtonWithImage:image andSeletor:@selector(changeOld:)];
        [self insertSubview:btn atIndex:self.subviews.count - 1];
        [self.images addObject:image];
        if (self.subviews.count - 1 == MaxImageCount) {
            [[self.subviews lastObject] setHidden:YES];
        }
        if (self.gaintSelectImageArray) {
            self.gaintSelectImageArray(self.images);
        }
    }
    else
    {
        // 根据tag修改需要编辑的控件
//        UIButton *btn = (UIButton *)[self viewWithTag:editTag];
//        int index = [self.images indexOfObject:[btn imageForState:UIControlStateNormal]];
//        [self.images removeObjectAtIndex:index];
//        [btn setImage:image forState:UIControlStateNormal];
//        [self.images insertObject:image atIndex:index];
    }
    // 退出图片选择控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
