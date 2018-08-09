//
//  TabBarButton.m
//  HXTG
//
//  Created by grx on 2017/2/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((self.width - 23)/2.0, 7, 25, 22);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(1, 29, self.width, 19);
    
}

@end
