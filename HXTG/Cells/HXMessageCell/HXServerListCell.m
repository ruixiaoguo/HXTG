//
//  HXServerListCell.m
//  HXTG
//
//  Created by grx on 2017/3/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXServerListCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@implementation HXServerListCell{
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell];
        [self layoutFrame];
    }
    return self;
}

-(void)createCell
{
    
    /*! 内容 */
//    contentLable = [UILabel new];
//    contentLable.textColor = UIColorBlackTheme;
//    contentLable.font = [UIFont systemFontOfSize:13];
    self.contentWebLable = [UIWebView new];
    self.contentWebLable.delegate = self;
    self.contentWebLable.backgroundColor = [UIColor clearColor];
    self.contentWebLable.opaque = NO;
    self.contentWebLable.scrollView.scrollEnabled = NO;
    /*! 时间 */
    self.timeLable = [UILabel new];
    self.timeLable.textColor = UIColorLineTheme;
    self.timeLable.font = [UIFont systemFontOfSize:12];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    
    self.bgView = [UIView new];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.backgroundColor = ColorWithHexRGB(0xfde1e3);
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = ColorWithHexRGB(0xfde1e3).CGColor;
    
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.contentWebLable];
    [self.contentView addSubview:self.timeLable];
}

-(void)layoutFrame
{
//    noteImage.sd_layout
//    .widthIs(24)
//    .heightIs(24)
//    .topSpaceToView(self.contentView, 18)
//    .leftSpaceToView(self.contentView, 25);
//    
//    titleLable.sd_layout
//    .topEqualToView(noteImage)
//    .leftSpaceToView(noteImage, 10)
//    .widthIs(Main_Screen_Width/2-20)
//    .heightRatioToView(noteImage,1);
//    
//    timeLable.sd_layout
//    .topEqualToView(noteImage)
//    .widthIs(110)
//    .rightSpaceToView(self.contentView, 25)
//    .heightRatioToView(noteImage,1);
    self.timeLable.sd_layout
    .topSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(35);
    
    self.contentWebLable.sd_layout
    .topSpaceToView(self.timeLable, 2)
    .rightSpaceToView(self.contentView, 25)
    .leftSpaceToView(self.contentView, 25)
    .heightIs(0);
    
    
    self.bgView.sd_layout
    .widthIs(Main_Screen_Width-30)
    .topSpaceToView(self.contentView, 35)
    .leftSpaceToView(self.contentView, 15);
}

- (void)setModel:(HXMessageModel *)model
{
    _model = model;
    [self.contentWebLable loadHTMLString:model.news_content baseURL:nil];
//    contentLable.text = model.news_content;
    self.timeLable.text = model.news_puttime;
    CGFloat bottomMargin = 10;
    
    //***********************高度自适应cell设置步骤************************
    
    [self setupAutoHeightWithBottomView:self.contentWebLable bottomMargin:bottomMargin];
}

-(UIImage *)scaleImage:(UIImage *)origin font:(UIFont *)font{
    
    CGFloat imgH=origin.size.height;
    CGFloat imgW=origin.size.width;
    CGFloat width;
    CGFloat height;
    CGFloat fontHeight=font.pointSize;
    if(imgW>imgH){
        
        width=fontHeight;
        height=fontHeight/imgW*imgH;
    }
    else{
        height=fontHeight;
        width=fontHeight/imgH*imgW;
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [origin drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(void)setHight:(CGFloat)hight
{
//    bgView.sd_layout.heightIs(hight-20);
//    contentWebLable.sd_layout.heightIs(hight-30);
}
#pragma mark - ================加载完成======================
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    NSString *injectionJSString = [NSString stringWithFormat:@"var script = document.createElement('meta');"
                                   "script.name = 'viewport';"
                                   "script.content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0,user-scalable=no\";"
                                   "document.getElementsByTagName('head')[0].appendChild(script);"
                                   "document.documentElement.style.webkitTouchCallout = \"none\";"
                                   "document.documentElement.style.webkitUserSelect = \"none\";"
                                   "window.scrollBy(0, 0);"];
    [webView stringByEvaluatingJavaScriptFromString:injectionJSString];
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 300.0;" // UIWebView中显示的图片宽度
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    [HXLoadingView hide];

    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
    self.bgView.sd_layout.heightIs(height+18);
    self.contentWebLable.sd_layout.heightIs(height+10);
//    if (self.gaintHight) {
//        self.gaintHight(height);
//    }
}

@end
