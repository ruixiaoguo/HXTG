//
//  YBCommentPhotoView.m
//  YongBar
//
//  Created by lixiao on 16/1/15.
//  Copyright © 2016年 grx. All rights reserved.
//

#import "HXPhotoWall.h"
#import "UIImageView+WebCache.h"

#define KPhotoWallTopHeight 10

@implementation HXPhotoWall

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageViewArray = [[NSMutableArray alloc]init];
        _deleteButtonArray = [[NSMutableArray alloc]init];
        _imageArray = [[NSMutableArray alloc]init];
    
        CGFloat width = 50;
        CGFloat orignalX = 15;
        CGFloat orignalY = 0;
        
        for (NSInteger i = 0; i < 5; i++)
        {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(orignalX,orignalY, width, width);
            imageView.clipsToBounds = YES;
            imageView.tag = i;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.image = [UIImage imageNamed:@"tupian.png"];
            [self addSubview:imageView];
            imageView.userInteractionEnabled = YES;
            imageView.layer.cornerRadius = 5;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
            [imageView addGestureRecognizer:tap];
            imageView.hidden = YES;
            [_imageViewArray addObject:imageView];
            
            UIButton *deleteButton = [[UIButton alloc]init];
            deleteButton.frame = CGRectMake(orignalX + width - 17 , orignalY- 17, 35, 35);
            deleteButton.hidden = YES;
            [deleteButton setImage:[UIImage imageNamed:@"delete_pic.png"] forState:UIControlStateNormal];
            [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:deleteButton];
            [_deleteButtonArray addObject:deleteButton];
            
            orignalX = imageView.right + KPhotoWallTopHeight;
            if (orignalX >= Main_Screen_Width)
            {
                orignalX = KPhotoWallTopHeight;
                orignalY = (width + KPhotoWallTopHeight);
            }
            
        }
        
    }
    
    return self;
}

//- (void)setImageUrlArray:(NSArray *)imageUrlArray
//{
//    _imageUrlArray = imageUrlArray;
//    for (NSInteger i = 0; i < _imageViewArray.count ; i++)
//    {
//        UIImageView *imageView = self.imageViewArray[i];
//        UIButton *button = self.deleteButtonArray[i];
//        imageView.hidden = YES;
//        button.hidden = YES;
//        imageView.userInteractionEnabled = NO;
//    }
//    
//    for (NSInteger i = 0; i < imageUrlArray.count; i++)
//    {
//        NSString *url = imageUrlArray[i];
//        UIImageView *imageView = self.imageArray[i];
//        if ([url hasPrefix:PreImaUrl])
//        {
//            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"grey_kuang__03.png"]];
//        }else
//        {
//            NSString *imagUrl = [NSString stringWithFormat:@"%@%@", PreImaUrl,url];
//            [imageView sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:@"grey_kuang__03.png"]];
//        }
//        
//        imageView.hidden = NO;
//    }
//}

//显示图片
- (void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = imageArray;
    
//    for (NSInteger i = 0; i < self.imageArray.count; i++)
//    {
//        
//        UIImageView *imageView = self.imageViewArray[i];
//        UIButton *button = self.deleteButtonArray[i];
//        button.hidden = YES;
//        imageView.hidden = YES;
//    }
    
    
    for (NSInteger i = 0; i < imageArray.count; i++)
    {
        UIImageView *imageView = self.imageViewArray[i];
        UIButton *button = self.deleteButtonArray[i];
        imageView.hidden = NO;
        button.hidden = NO;
        imageView.image = imageArray[i];
        imageView.userInteractionEnabled = NO;
    }
    
    if (imageArray.count < 5)
    {
        UIImageView *imageView = self.imageViewArray[imageArray.count];
        UIButton *button = self.deleteButtonArray[imageArray.count];
        imageView.hidden = NO;
        button.hidden = YES;
        imageView.userInteractionEnabled = YES;
    }
}

- (void)gaintImageArray:(NSMutableArray *)imageArray IsDelete:(BOOL)isDelete
{
    _imageArray = imageArray;
    
//    if (isDelete==YES) {
//        for (NSInteger i = 0; i < imageArray.count; i++)
//        {
//            UIImageView *imageView = self.imageViewArray[imageArray.count];
//            UIButton *button = self.deleteButtonArray[imageArray.count];
//            imageView.hidden = YES;
//            button.hidden = YES;
//            imageView.userInteractionEnabled = NO;
//        }
//        return;
//    }
    
    for (NSInteger i = 0; i < imageArray.count; i++)
    {
        UIImageView *imageView = self.imageViewArray[i];
        UIButton *button = self.deleteButtonArray[i];
        imageView.hidden = NO;
        button.hidden = NO;
        imageView.image = imageArray[i];
        imageView.userInteractionEnabled = NO;
    }
    
    if (imageArray.count < 5)
    {
        UIImageView *imageView = self.imageViewArray[imageArray.count];
        UIButton *button = self.deleteButtonArray[imageArray.count];
        imageView.hidden = NO;
        button.hidden = YES;
        imageView.userInteractionEnabled = YES;
    }
    if (isDelete==YES) {
        if (imageArray.count < 5)
        {
            UIImageView *imageView = self.imageViewArray[imageArray.count];
            UIButton *button = self.deleteButtonArray[imageArray.count];
            imageView.hidden = YES;
            button.hidden = YES;
            imageView.userInteractionEnabled = YES;
        }
    }

}

- (void)imageViewClick:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    
    if (self.tapImageViewClickBlock)
    {
        self.tapImageViewClickBlock(imageView);
    }
}

- (void)deleteButtonClick:(UIButton *)deleteButton
{
    NSInteger index = [self.deleteButtonArray indexOfObject:deleteButton];
    
    if (self.tapDeleteButtonClickBlock)
    {
        self.tapDeleteButtonClickBlock(index);
    }
}


@end
