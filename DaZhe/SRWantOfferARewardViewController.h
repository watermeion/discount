//
//  SRWantOfferARewardViewController.h
//  DaZhe
//
//  Created by Mac on 11/9/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reward.h"
@interface SRWantOfferARewardViewController : UIViewController<UITextInputDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    Reward *submitRewardObject;
    NSArray *pickViewDataArray;
    NSMutableDictionary *cityAndZoneDict;
    //用于标示选择器的状态。0 1 2 可选
    int pickViewTag;
    UITextField *activeTextField;
    NSString *imageFullPath;
    NSNumber *usrKubeFee;
   
}
@property (strong,nonatomic) UIActionSheet *actionSheet;


//UI控件组合
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *submmitButon;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UITextField *rewardAverageText;
@property (weak, nonatomic) IBOutlet UITextField *rewardMoney;

@property (weak, nonatomic) IBOutlet UITextView *rewardWordText;
@property (weak, nonatomic) IBOutlet UILabel *personKube;


//pickView
@property (strong, nonatomic) IBOutlet UIPickerView *pickViewer;
@property (strong, nonatomic) IBOutlet UIToolbar *pickViewToolBar;



//选择

@property (weak, nonatomic) IBOutlet UITextField *chooseType;

@property (weak, nonatomic) IBOutlet UITextField *chooseCity;
@property (weak, nonatomic) IBOutlet UITextField *chooseZone;



//button Action

- (IBAction)submitBtnAction:(id)sender;

- (IBAction)doneChooseEdit:(id)sender;


//alertView
@property(strong,nonatomic)UIAlertView *alert;
- (IBAction)chooseEditBeginAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *rewardTitle;
@property (weak, nonatomic) IBOutlet UITextField *rewardShopName;
@property (weak, nonatomic) IBOutlet UIImageView *upLoadImageView;
- (IBAction)UpLoadImageAction:(id)sender;

@end
