//
//  SRMakeCommentViewController.h
//  DaZhe
//
//  Created by Mac on 11/17/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRMakeCommentViewController : UIViewController<UITextViewDelegate>

- (IBAction)submitConfirm:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *commentInputView;
@property (strong,nonatomic)NSString *tempShopObjectId;

@property (strong,nonatomic)UIAlertView *alertView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
