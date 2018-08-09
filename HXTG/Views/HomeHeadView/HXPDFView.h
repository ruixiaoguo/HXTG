//
//  HXPDFView.h
//  HXTG
//
//  Created by grx on 2017/4/18.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXPDFView : UIView

@property (strong, nonatomic) UILabel *PDFLable;
@property (strong, nonatomic) NSString *pdfUrl;
@property (strong, nonatomic) void (^downLoadPdfFile)();

@end
