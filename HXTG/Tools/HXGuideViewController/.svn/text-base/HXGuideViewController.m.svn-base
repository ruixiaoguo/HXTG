//
//  HXGuideViewController.m
//  HXTG
//
//  Created by grx on 2017/2/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXGuideViewController.h"

@interface HXGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *backgroundViews;
@property (nonatomic, strong) NSArray *scrollViewPages;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger centerPageIndex;

@end

@implementation HXGuideViewController

- (id)initWithCoverImageNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames
{
    if (self = [super init]) {
        [self initSelfWithCoverNames:coverNames backgroundImageNames:bgNames];
    }
    return self;
}

- (id)initWithCoverImageNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames button:(UIButton *)button
{
    if (self = [super init]) {
        [self initSelfWithCoverNames:coverNames backgroundImageNames:bgNames];
        self.enterButton = button;
    }
    return self;
}

- (void)initSelfWithCoverNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames
{
    self.coverImageNames = coverNames;
    self.backgroundImageNames = bgNames;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackgroundViews];
    
    self.pagingScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.pagingScrollView.delegate = self;
    self.pagingScrollView.pagingEnabled = YES;
    self.pagingScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.pagingScrollView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:[self frameOfPageControl]];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self.view addSubview:self.pageControl];
    self.pageControl.hidden = NO;
    
    if (!self.enterButton) {
        self.enterButton = [UIButton new];
        [self.enterButton setTitle:NSLocalizedString(@"立即体验", nil) forState:UIControlStateNormal];
        [self.enterButton setImage:[UIImage imageNamed:@"guide_enter.png"] forState:UIControlStateNormal];
        //        self.enterButton.layer.borderWidth = 0.5;
        //        self.enterButton.layer.borderColor = [UIColor redColor].CGColor;
        [self.enterButton setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
        
    }
    
    [self.enterButton addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
    self.enterButton.frame = [self frameOfEnterButton];
    self.enterButton.alpha = 0;
    [self.view addSubview:self.enterButton];
    
    [self reloadPages];
    
}

- (void)addBackgroundViews
{
    CGRect frame = self.view.bounds;
    NSMutableArray *tmpArray = [NSMutableArray new];
    [[[[self backgroundImageNames] reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:obj]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.backgroundColor = [UIColor redColor];
        imageView.frame = frame;
        imageView.tag = idx + 1;
        [tmpArray addObject:imageView];
        [self.view addSubview:imageView];
    }];
    
    self.backgroundViews = [[tmpArray reverseObjectEnumerator] allObjects];
}

- (void)reloadPages
{
    self.pageControl.numberOfPages = [[self coverImageNames] count];
    self.pagingScrollView.contentSize = [self contentSizeOfScrollView];
    
    __block CGFloat x = 0;
    [[self scrollViewPages] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        obj.frame = CGRectOffset(obj.frame, x, 0);
        [self.pagingScrollView addSubview:obj];
        
        x += obj.frame.size.width;
    }];
    
    // fix enterButton can not presenting if ScrollView have only one page
    if (self.pageControl.numberOfPages == 1) {
        self.enterButton.alpha = 1;
        self.pageControl.alpha = 0;
    }
    
    // fix ScrollView can not scrolling if it have only one page
    if (self.pagingScrollView.contentSize.width == self.pagingScrollView.frame.size.width) {
        self.pagingScrollView.contentSize = CGSizeMake(self.pagingScrollView.contentSize.width + 1, self.pagingScrollView.contentSize.height);
    }
    
    
    for (NSInteger i = 0; i < 2; i++)
    {
        UIButton *nextButton = [[UIButton alloc]init];
        [nextButton setImage:[UIImage imageNamed:@"guide_next.png"] forState:UIControlStateNormal];
        nextButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [nextButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (Main_Screen_Height <= 480)
        {
            nextButton.frame = CGRectMake(Main_Screen_Width * (i + 1) - 60, Main_Screen_Height - 40, 40, 20);
            
        }else if (Main_Screen_Height <= 568)
        {
            nextButton.frame = CGRectMake(Main_Screen_Width * (i + 1) - 60, Main_Screen_Height - 46, 40, 20);
            
        }else if (Main_Screen_Height <= 667)
        {
            nextButton.frame = CGRectMake(Main_Screen_Width * (i + 1) - 60, Main_Screen_Height - 50, 40, 20);
            
        }else if (Main_Screen_Height <= 736)
        {
            nextButton.frame = CGRectMake(Main_Screen_Width * (i + 1) - 60, Main_Screen_Height - 55, 40, 20);
        }
        
        [self.pagingScrollView addSubview:nextButton];
    }
}


- (void)buttonClick:(UIButton *)button
{
    CGPoint offset = CGPointMake(self.pagingScrollView.contentOffset.x, self.pagingScrollView.contentOffset.y);
    offset.x += Main_Screen_Width;
    [self.pagingScrollView setContentOffset:offset animated:YES];
}

- (CGRect)frameOfPageControl
{
    return CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 30);
}

- (CGRect)frameOfEnterButton
{
    CGSize size = self.enterButton.bounds.size;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
//        size = CGSizeMake(self.view.frame.size.width * 0.6, 40);
    }
    //    return CGRectMake(self.view.frame.size.width / 2 - size.width / 2, self.pageControl.frame.origin.y - size.height - Main_Screen_Height * 0.2, size.width, size.height);
    return CGRectMake(Main_Screen_Width/2-(Main_Screen_Width/6), Main_Screen_Height-100, Main_Screen_Width/3, 40);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < 0)
    {
        [scrollView setContentOffset:CGPointZero];
    }
    NSInteger index = scrollView.contentOffset.x / self.view.frame.size.width;
    CGFloat alpha = 1 - ((scrollView.contentOffset.x - index * self.view.frame.size.width) / self.view.frame.size.width);
    
    if ([self.backgroundViews count] > index) {
        UIView *v = [self.backgroundViews objectAtIndex:index];
        if (v) {
            [v setAlpha:alpha];
        }
    }
    
    self.pageControl.currentPage = scrollView.contentOffset.x / (scrollView.contentSize.width / [self numberOfPagesInPagingScrollView]);
    
    [self pagingScrollViewDidChangePages:scrollView];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        if (![self hasNext:self.pageControl]) {
            [self enter:nil];
        }
    }
}

#pragma mark - UIScrollView & UIPageControl DataSource

- (BOOL)hasNext:(UIPageControl*)pageControl
{
    return pageControl.numberOfPages > pageControl.currentPage + 1;
}

- (BOOL)isLast:(UIPageControl*)pageControl
{
    return pageControl.numberOfPages == pageControl.currentPage + 1;
}

- (NSInteger)numberOfPagesInPagingScrollView
{
    return [[self coverImageNames] count];
}

- (void)pagingScrollViewDidChangePages:(UIScrollView *)pagingScrollView
{
    if ([self isLast:self.pageControl]) {
        [UIView animateWithDuration:0.4 animations:^{
            self.enterButton.alpha = 1;
        }];
        if (self.pageControl.alpha == 1) {
            self.pageControl.alpha = 1;
            //            [UIView animateWithDuration:0.4 animations:^{
            //                self.enterButton.alpha = 1;
            ////                self.pageControl.alpha = 1;
            //            }];
        }
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            self.enterButton.alpha = 0;
        }];
        //        if (self.pageControl.alpha == 0) {
        //            self.enterButton.alpha = 0;
        //            self.pageControl.alpha = 1;
        //            [UIView animateWithDuration:0.4 animations:^{
        //                self.enterButton.alpha = 0;
        //                self.pageControl.alpha = 1;
        //            }];
        //        }
    }
}

- (BOOL)hasEnterButtonInView:(UIView*)page
{
    __block BOOL result = NO;
    [page.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj && obj == self.enterButton) {
            result = YES;
        }
    }];
    return result;
    
}

- (UIImageView*)scrollViewPage:(NSString*)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    CGSize size = {[[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height};
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, size.width, size.height);
    
    
    return imageView;
}

- (NSArray*)scrollViewPages
{
    if ([self numberOfPagesInPagingScrollView] == 0) {
        return nil;
    }
    
    if (_scrollViewPages) {
        return _scrollViewPages;
    }
    
    NSMutableArray *tmpArray = [NSMutableArray new];
    [self.coverImageNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIImageView *v = [self scrollViewPage:obj];
        [tmpArray addObject:v];
        
    }];
    
    _scrollViewPages = tmpArray;
    
    return _scrollViewPages;
}

- (CGSize)contentSizeOfScrollView
{
    UIView *view = [[self scrollViewPages] firstObject];
    return CGSizeMake(view.frame.size.width * self.scrollViewPages.count, view.frame.size.height);
}

#pragma mark - Action

- (void)enter:(id)object
{
    if (self.didSelectedEnter) {
        self.didSelectedEnter();
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
