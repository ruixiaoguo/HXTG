//
//  HXPDFView.m
//  HXTG
//
//  Created by grx on 2017/4/18.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXPDFView.h"

@implementation HXPDFView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = UIColorWhite;
        [self markeView];
    }
    return self;
}

/*! PDF下载 */
-(void)markeView
{
    UIImageView *pdfImage = [UIImageView new];
    pdfImage.image = [UIImage imageNamed:@"pdf-documentation"];
    [self addSubview:pdfImage];
    pdfImage.sd_layout.leftSpaceToView(self, 26).topSpaceToView(self, 7).widthIs(27).heightIs(30);
    self.PDFLable = [UILabel new];
    self.PDFLable.font = UIFontSystem13;
    self.PDFLable.textColor = UIColorBlackTheme;
    [self addSubview:self.PDFLable];
    self.PDFLable.sd_layout.leftSpaceToView(pdfImage, 10).topSpaceToView(self, 0).rightSpaceToView(self, 57).heightIs(45);
    UIButton *downLoadBtn = [UIButton new];
    [downLoadBtn setImage:[UIImage imageNamed:@"xaizai2"] forState:UIControlStateNormal];
    [self addSubview:downLoadBtn];
    [downLoadBtn addTarget:self action:@selector(downLoadBtnClick) forControlEvents:UIControlEventTouchUpInside];
    downLoadBtn.sd_layout.rightSpaceToView(self, 15).topSpaceToView(self, 10).widthIs(25).heightIs(25);
    /*! 手势 */
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClickTap)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleRecognizer];
}

#pragma mark - 下载PDF
-(void)downLoadBtnClick
{
    if (self.downLoadPdfFile) {
        self.downLoadPdfFile();
    }
}

-(void)bgViewClickTap
{
    if (self.downLoadPdfFile) {
        self.downLoadPdfFile();
    }
}


@end
