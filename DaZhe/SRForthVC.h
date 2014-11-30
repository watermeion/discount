//
//  SRForthVC.h
//  DaZhe
//
//  Created by GeoBeans on 14-10-16.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRLoginVC.h"

@interface SRForthVC : UIViewController<finishLogin,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scollView;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UILabel *buttonLabel;
@property (weak, nonatomic) IBOutlet UIButton *LogoutButton;
- (IBAction)callServiceCenterAction:(id)sender;
- (IBAction)userFeedBackAction:(id)sender;
- (IBAction)seeMyCommentsListAction:(id)sender;
- (IBAction)seeMyKubiRecordAction:(id)sender;
- (IBAction)seeMyDiscountRecordAction:(id)sender;

@end
