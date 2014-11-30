//
//  SRIntroduceVC.h
//  DaZhe
//
//  Created by GeoBeans on 14-9-16.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVNMaskedPageControl.h"

@interface SRIntroduceVC : UIViewController<KVNMaskedPageControlDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) KVNMaskedPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic)NSInteger pages;

@end
