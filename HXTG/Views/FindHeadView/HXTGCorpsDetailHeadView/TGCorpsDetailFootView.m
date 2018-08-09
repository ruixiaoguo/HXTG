//
//  TGCorpsDetailFootView.m
//  HXTG
//
//  Created by grx on 2017/5/6.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "TGCorpsDetailFootView.h"

@implementation TGCorpsDetailFootView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self markeHeadView];
    }
    return self;
}

/*! 创建MeView */
-(void)markeHeadView
{
    /*! 军团成员 */
    UIView *bgView = [UIView new];
    bgView.backgroundColor = UIColorBgLightTheme;
    [self addSubview:bgView];
    bgView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).heightIs(40);
    /*! 分割线 */
    UIView *lineViwe = [UIView new];
    lineViwe.backgroundColor = UIColorBlueTheme;
    lineViwe.frame = CGRectMake(6, 12, 4, 20);
    [bgView addSubview:lineViwe];
    /*! 文字标题 */
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorBlackTheme;
    label.font = UIFontSystem14;
    label.frame = CGRectMake(16, 2, 100, 40);
    label.text = @"详细介绍";
    [bgView addSubview:label];
    self.tGCorpWebView = [IMYWebView new] ;
    self.tGCorpWebView.delegate = self;
    [self addSubview:self.tGCorpWebView] ;
    self.tGCorpWebView.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).topSpaceToView(bgView,0).heightIs(350);
    self.tGCorpWebView.scrollView.scrollEnabled  = NO;
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
    self.tGCorpWebView.sd_layout.heightIs(height);
    if (self.gaintWebHight) {
        self.gaintWebHight(height+20);
    }
     
}


@end
