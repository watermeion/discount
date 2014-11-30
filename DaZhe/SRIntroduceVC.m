//
//  SRIntroduceVC.m
//  DaZhe
//
//  Created by GeoBeans on 14-9-16.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRIntroduceVC.h"
#import "SRtabbarVC.h"

@interface SRIntroduceVC ()

@end

@implementation SRIntroduceVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.scrollView.delegate=self;
    self.scrollView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.pages = 3;
    
    KVNMaskedPageControl *pageControl = [[KVNMaskedPageControl alloc] init];
    [pageControl setNumberOfPages:self.pages];
    
    if (DEVICE_IS_IPHONE5) {
        [pageControl setCenter:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMidY(pageControl.bounds) - 10)];
    }else{
        [pageControl setCenter:CGPointMake(CGRectGetMidX(self.view.bounds), 470)];
    }
    [pageControl setDataSource:self];
    [pageControl setHidesForSinglePage:YES];
    
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    [self createPages:self.pages];
    
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)touchStart{
    
    if((![[NSUserDefaults standardUserDefaults] objectForKey:@"launchFirstTime"])||![[[NSUserDefaults standardUserDefaults] objectForKey:@"launchFirstTime"] isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]){
     
        [UIView animateWithDuration:0.7 animations:^{
            _scrollView.alpha=0;
        } completion:^(BOOL finished) {
                                
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]] forKey:@"launchFirstTime"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SRtabbarVC *tabbarVC=[story instantiateViewControllerWithIdentifier:@"tabbarVC"];
            [self presentViewController:tabbarVC animated:NO completion:nil];
            
            }];
        }
}


- (void)createPages:(NSInteger)pages {
    
    for (int i = 0; i < pages; i++) {
        UIImageView *imgView;
        
        UIImage *img;
        if (DEVICE_IS_IPHONE5) {
            imgView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
            img=[UIImage imageNamed:[NSString stringWithFormat:@"intro_%d.png",i+1]];
        }else{
            imgView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, CGRectGetWidth(self.scrollView.bounds), 480)];
            img=[UIImage imageNamed:[NSString stringWithFormat:@"intro_%d.png",i+1]];
        }
        imgView.image=img;
        [self.scrollView addSubview:imgView];
        
        if (i==3) {
            UIButton *btn=[[UIButton alloc]init];
            if (DEVICE_IS_IPHONE5) {
                btn.frame= CGRectMake(100, 430, 120, 40);
            }else{
                btn.frame= CGRectMake(100, 382, 120, 40);
            }
            btn.titleLabel.text=@"btnnto";
            btn.backgroundColor=[UIColor clearColor];
            [btn addTarget:self action:@selector(touchStart) forControlEvents:UIControlEventTouchUpInside];
            [imgView addSubview:btn];
            imgView.userInteractionEnabled=YES;
            
        }
    }
    if (DEVICE_IS_IPHONE5) {
        [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds) * pages, CGRectGetHeight(self.scrollView.bounds))];
    }
    else{[self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds) * pages, 480)];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pageControl maskEventWithOffset:scrollView.contentOffset.x frame:scrollView.frame];
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    if (self.scrollView.contentOffset.x>(self.pages-1)*pageWidth+pageWidth/4) {
        [self touchStart];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
	NSInteger page =  floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self.pageControl setCurrentPage:page];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
	NSInteger page =  floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.pageControl setCurrentPage:page];
}

#pragma mark - IBActions
- (void)changePage:(KVNMaskedPageControl *)sender {
	self.pageControl.currentPage = sender.currentPage;
	
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
}

#pragma mark - KVNMaskedPageControlDataSource
- (UIColor *)pageControl:(KVNMaskedPageControl *)control pageIndicatorTintColorForIndex:(NSInteger)index {
    return [UIColor colorWithWhite:1.0 alpha:0.6];
}

- (UIColor *)pageControl:(KVNMaskedPageControl *)control currentPageIndicatorTintColorForIndex:(NSInteger)index {
    return [UIColor colorWithRed:0.98 green:0.30 blue:0.37 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

