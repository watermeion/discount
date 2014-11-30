//
//  SRCodeVC.h
//  DaZhe
//
//  Created by GeoBeans on 14-10-12.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRCodeVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (strong, nonatomic) UIImage *codeImage;

@end
