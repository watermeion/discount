//
//  SRDetailVC.h
//  DaZhe
//
//  Created by GeoBeans on 14-10-21.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SellerInfoDataModel.h"
#import "Evaluation.h"
#import "SellerInfoOperation.h"
#import "ShopZanServices.h"
#import "SellerInfo.h"

@interface SRDetailVC : UIViewController<UIAlertViewDelegate>
{
    SellerInfoDataModel *sellerObj;
    Evaluation *evaluation;
    ShopZanServices *zan;
}
//dataSource
@property(strong,nonatomic)SellerInfo *sellData;
//view
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *view7;

//dataObjectId
@property(strong,nonatomic)NSString *sellObjectID;
//dataOperation
@property(strong,nonatomic)SellerInfoOperation *businessLayerObj;


@property(strong,nonatomic)UIAlertView *alertView;

//界面UI
@property (weak, nonatomic) IBOutlet UILabel *SellName;
@property (weak, nonatomic) IBOutlet UIImageView *SellImage;
@property (weak, nonatomic) IBOutlet UIImageView *SellStarImage;

@property (weak, nonatomic) IBOutlet UILabel *SellDiscountOtherInfo;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
- (IBAction)makePhoneCallAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *loactionAddressLabel;

- (IBAction)locateItOnTheMapAction:(id)sender;


- (IBAction)seeMoreEvaluationsAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *oneEvaluationMemberNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalEvaluationCount;
@property (weak, nonatomic) IBOutlet UILabel *oneEvaluationContent;


@property (weak, nonatomic) IBOutlet UIImageView *memberImage;

@property (weak, nonatomic) IBOutlet UILabel *SellerDetailInfo;


//sellerBusinessHour
- (IBAction)showSellerDetailInfo:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *businessHour;


//sellerWarn
- (IBAction)showOtherBranch:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *otherBranchInfo;



//sellerAppointTip
- (IBAction)showNearShop:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nearshopInfo;


@property (weak, nonatomic) IBOutlet UIButton *sellerIsWifiButton;

@property (weak, nonatomic) IBOutlet UILabel *sellerIsWifiLabel;



- (IBAction)makeCommentAction:(id)sender;

- (IBAction)makeFavoriteAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *sellerPriseCOunt;
@property (weak, nonatomic) IBOutlet UILabel *sellerAverageCost;
- (IBAction)seeMorePicAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitPriseAvtion;
- (IBAction)sellerFansAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *sellerFansLabel;


@end
