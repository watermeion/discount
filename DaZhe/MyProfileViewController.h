//
//  MyProfileViewController.h
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileViewController : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *usrKubeNumberLabel;
- (IBAction)uploadProfileImageAction:(id)sender;
- (IBAction)changeNikiNameAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *usrPhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *usrNikiNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *usrProfileImage;

@end
