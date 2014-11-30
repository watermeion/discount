//
//  SRRecomendVC.h
//  DaZhe
//
//  Created by RAY on 14/11/17.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol successRecomended <NSObject>
@required
- (void)successRecomended;
@end

@interface SRRecomendVC : UIViewController
{
    float value1;
    float value2;
    float value3;
    float value4;
    
    BOOL firstWrite;
    NSString *recomendString;
    
    UIActivityIndicatorView  *indicatorView;
    
    CGRect rect1;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSString *selleObjectId;
@property (weak, nonatomic) NSString *commentDiscountObjectId;
@property (nonatomic,weak) id<successRecomended> RecomendDelegate;

@end
