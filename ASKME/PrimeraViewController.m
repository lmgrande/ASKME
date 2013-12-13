//
//  PrimeraViewController.m
//  ASKME
//
//  Created by LUISMI on 12/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "PrimeraViewController.h"

@interface PrimeraViewController ()
{
    NSInteger w;
    
}

@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)loadVisiblesPages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;
@end

@implementation PrimeraViewController

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize pageImages = _pageImages;
@synthesize pageViews = _pageViews;

#pragma mark - customizando icono tab bar

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UIImage *imagen = [UIImage imageNamed:@"ico-Tab-Bar-Info@x2.png"];
        CGImageRef imagenRef = [imagen CGImage];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Info." image:[UIImage imageWithCGImage:imagenRef scale:2.0f orientation:UIImageOrientationUp] selectedImage:nil];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - metodos de la vista

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.scrollView.delegate =self;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, -2, 0);
    
    //1
    UIImage *img1 = [UIImage imageNamed:@"OPCION-INFO-informacion.png"];
    UIImage *img2 = [UIImage imageNamed:@"OPCION-INFO-Jugador.png"];
    UIImage *img3 = [UIImage imageNamed:@"OPCION-INFO-Jugadores.png"];
    UIImage *img4 = [UIImage imageNamed:@"OPCION-INFO-graficas.png"];
    UIImage *img5 = [UIImage imageNamed:@"OPCION-INFO-configuracion.png"];
    self.pageImages = [NSArray arrayWithObjects:img1,img2,img3,img4,img5,nil];
    NSInteger pageCount = self.pageImages.count;
    
    //2
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = pageCount;
    
    //3
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; i++) {
        [self.pageViews addObject:[NSNull null]];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //4
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
    
    //5
    [self loadVisiblesPages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - metodos para las Páginas

- (void)loadVisiblesPages
{
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));

    // Update the page control
    self.pageControl.currentPage = page;
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    
	// Load pages in our range
    //for (NSInteger i=firstPage; i<=lastPage; i++) {
    for (NSInteger i=0; i<=4; i++) {
        [self loadPage:i];
    }
    
	// Purge anything after the last page
    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
        [self purgePage:i];
    }
}

- (void)loadPage:(NSInteger)page
{
    if (page < 0 || page>= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    //1
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        //2
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        frame = CGRectInset(frame, 0.0f, 0.0f);
        
        //3
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[self.pageImages objectAtIndex:page]];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        [self.scrollView addSubview:newPageView];
        
        //4
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

- (void)purgePage:(NSInteger)page
{
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

#pragma mark - métodos del UISCrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblesPages];
}

#pragma mark - otros metodos

- (void) onTimer {
    
    if (self.pageControl.currentPage<self.pageImages.count-1)
    {
        w = (self.pageControl.currentPage * 320)+320;
    }else
    {
        w = 0;
    }
    
    //This makes the scrollView scroll to the desired position
    [self.scrollView setContentOffset:CGPointMake(w, 0) animated:YES];
    
    self.pageControl.currentPage++;
    
    
}


@end
