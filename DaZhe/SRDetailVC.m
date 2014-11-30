//
//  SRDetailVC.m
//  DaZhe
//
//  Created by GeoBeans on 14-10-21.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRDetailVC.h"

#import "CommonMacro.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SRMakeCommentViewController.h"
#import "SRShowEvaluationTableViewController.h"
#import "SRMapViewVC.h"

@interface SRDetailVC ()

@end

@implementation SRDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (DEVICE_IS_IPHONE4){
        self.scrollView.frame=CGRectMake(0, 0, 320, 376);
        self.view7.center=CGPointMake(self.view7.center.x, self.view7.center.y-88);
    }
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(initializeViewData) name:@"Data1HasBeenPrepared" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(InitializeEvaluationView) name:@"Data2HasBeenPrepared" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataError) name:@"Error" object:nil];
    
    //     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HandleErrorWithRequestFailed) name:@"RequestError" object:nil];
    
    self.scrollView.scrollEnabled=YES;
    self.scrollView.contentSize=CGSizeMake(320, 800);
    self.businessLayerObj=[[SellerInfoOperation alloc]init];
    if (self.sellData!=nil) {
        [self.businessLayerObj receiveData:@[self.sellData]];
    }
    else if (self.sellObjectID!=nil) {
        self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"正在加载请稍后" delegate:self cancelButtonTitle:@"知道" otherButtonTitles:nil];
        [self.alertView show];
        //request data
        [self.businessLayerObj requestToAVOS:@"SellerInfo" ID:self.sellObjectID Key:@"objectId"  PageNumber:0 Count:1];
    }
    
}
-(void)dataError
{
    self.alertView=[[UIAlertView alloc]initWithTitle:nil message:@"失败：没有网络"
                                            delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [self.alertView show];
    self.scrollView.hidden=YES;
}

-(void)initializeViewData
{
    self.scrollView.hidden=NO;
    sellerObj=self.businessLayerObj.sellerInfoData;
    
    self.sellerPriseCOunt.text=sellerObj.sellerPriseCount;
    
    self.sellerAverageCost.text=sellerObj.sellerAverage;
    
    self.SellName.text=sellerObj.sellerName;
    //
    
    self.phoneLabel.text=sellerObj.sellerPhone;
    
    self.loactionAddressLabel.text=sellerObj.sellerAddress;
    self.businessHour.text=sellerObj.sellerBusinessHours;
    
    self.SellImage.image=[UIImage imageNamed:@"wm_bg_line"];

    [sellerObj.sellerImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            self.SellImage.image=[UIImage imageWithData:data];
        }
    }];
    
    
    self.otherBranchInfo.text=sellerObj.sellWarn;
    
    self.nearshopInfo.text=sellerObj.sellerAppointTip;
    
    self.SellStarImage.image=sellerObj.sellerStarImage;

    self.sellerIsWifiLabel.text=sellerObj.sellerIsWifi;
    
    
    [self.businessLayerObj requestToAVOS:@"Evaluation" ID:self.sellObjectID Key:@"evaluationShopObjectID"  PageNumber:0 Count:1];
}


#pragma -mark 处理请求
-(void)InitializeEvaluationView
{
    evaluation=[self.businessLayerObj.result objectForKey:[[self.businessLayerObj.result allKeys] firstObject]];
    self.oneEvaluationMemberNameLabel.text=evaluation.evaluationMemberName;
    self.oneEvaluationContent.text=evaluation.evaluationContent;
    
    AVQuery *query=[AVQuery queryWithClassName:@"Evaluation"];
    [query whereKey:@"evaluationShopObjectID" equalTo:self.sellObjectID];
    query.cachePolicy=kPFCachePolicyNetworkElseCache;
    [query countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        if (error==nil) {
            self.totalEvaluationCount.text=[NSString stringWithFormat:@"(%@)",NSStringFromInt(number)];
        }
        else
        {
            self.totalEvaluationCount.text=@"()";
            [self.businessLayerObj handleError];
        }
    }];
    if (evaluation.evaluationMemberLogoURL!=nil) {
        self.memberImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:evaluation.evaluationMemberLogoURL]]];
    }else
    {
        self.memberImage.image=[UIImage imageNamed:@"mine_selected.png"];
        
    }
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    if (DEVICE_IS_IPHONE4){
    //        self.scrollView.frame=CGRectMake(0, 0, 320, 376);
    //        self.view7.center=CGPointMake(self.view7.center.x, self.view7.center.y-88);
    //    }
    
}

- (void)viewWillLayoutSubviews{
    self.navigationItem.title=@"店铺详情";
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
}




//- (void)ViewGone:(UIView *)senderView{
//    if (senderView.hidden == NO) {
//        senderView.hidden = YES;
//        //获取源控件的View
//        NSInteger targetY = senderView.frame.origin.y;
//        NSInteger targetHeightY = senderView.frame.origin.y+senderView.frame.size.height+10;
//
//        BOOL isHidden = senderView.hidden;
//        if (isHidden) {
//            for (UIView *view in self.scrollView.subviews) {
//                NSInteger tempY = view.frame.origin.y;
//                //如果遇到view的Y坐标等于目标的Y坐标，且不为hidden的话，则暂停，恐会覆盖调
//                if(tempY == targetY && !view.hidden){
//                    break;
//                }
//                if (tempY >= targetHeightY ) {
//                    if ([view isMemberOfClass:[UIImageView class]]) {
//                        continue;
//                    }
//                    //上移到目标位置，达到隐藏的效果
//                    CGRect tmpFrame = CGRectMake(view.frame.origin.x, view.frame.origin.y-senderView.frame.size.height-10, view.frame.size.width, view.frame.size.height);
//                    view.frame = tmpFrame;
//                }
//            }
//        }
//    }
//}

- (IBAction)showLocationButton:(id)sender {
    if (self.sellData.sellerGeoPoint) {
        SRMapViewVC *mapVC=[[SRMapViewVC alloc]init];
        mapVC.sellerCoord=CLLocationCoordinate2DMake(self.sellData.sellerGeoPoint.latitude, self.sellData.sellerGeoPoint.longitude);
        mapVC.sellerTitle=self.sellData.sellerName;
        
        [self.navigationController pushViewController:mapVC animated:YES];
    }else {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"对不起，该用户暂未提供位置信息" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil,nil];
        [alert show];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



#pragma -mark 打电话
- (IBAction)makePhoneCallAction:(id)sender {
    
    //phoneNumber = "18369......"
    if(sellerObj.sellerPhone!=nil){
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",sellerObj.sellerPhone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
    else
    {
        
        NSLog(@"该店不支持电话，");
        
    }
    
    
}

#pragma -mark 在地图上显示
- (IBAction)locateItOnTheMapAction:(id)sender {
}


#pragma -mark 显示更多评论
- (IBAction)seeMoreEvaluationsAction:(id)sender {
    
    if (self.sellObjectID!=nil) {
        SRShowEvaluationTableViewController *moreEvaluationVC=[[SRShowEvaluationTableViewController alloc]initWithNibName:@"SRShowEvaluationTableViewController" bundle:nil];
        moreEvaluationVC.sellerObjectId=self.sellObjectID;
        
        [self.navigationController pushViewController:moreEvaluationVC animated:YES];
    }
    
    
}

#pragma -mark 显示商铺详细信息
- (IBAction)showSellerDetailInfo:(id)sender {
}
#pragma -mark 显示其他分店
- (IBAction)showOtherBranch:(id)sender {
}
#pragma -mark 显示附近商店
- (IBAction)showNearShop:(id)sender {
}
#pragma -mark 添加评论
- (IBAction)makeCommentAction:(id)sender {
    
    [self pushPriseOnThisShop];
    
}

- (IBAction)makeFavoriteAction:(id)sender {
}
- (IBAction)seeMorePicAction:(id)sender {
}



//商铺点赞
-(void)pushPriseOnThisShop
{
    if (zan==nil) {
        zan=[[ShopZanServices alloc]init];
    }
    
    
    
    AVUser *usr=[AVUser currentUser];
    if (usr==nil) {
        self.alertView.tag=00000;
        self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"您好,您还未登陆，现在就是登陆？" delegate:self cancelButtonTitle:@"等会去" otherButtonTitles:@"马上去",nil];
        self.alertView.tag=10001;
        [self.alertView show];
    }else
    {
        //判断是否点过赞
        if (![zan checkObjectExistencyWith2Conditions_value:usr.objectId className:@"ShopZan" Keyname1:@"zanUserObjectId" keyname2:@"sellerInfoObjectId" value2:self.sellObjectID]) {
            self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"重复点赞" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            [self.alertView show];
        }
        else{
            //在点赞表添加信息
            ShopZan *obj=[ShopZan object];
            obj.zanUserObjectId=usr.objectId;
            obj.sellerInfoObjectId=self.sellObjectID;
            
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(zanSucceedHandler) name:@"Succeed" object:nil];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(zanFailedHandler) name:@"failed" object:nil];
            [zan save:obj];
            
        }
    }
    
}



-(void)zanSucceedHandler
{
    
    self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"点赞成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [self.alertView show];
    //刷新本界面的点赞数
    self.sellerPriseCOunt.text=NSStringFromInt([self.sellerPriseCOunt.text intValue]+1);
    //    [self removeObserver:self forKeyPath:@"Succeed" context:nil];
    //    [self removeObserver:self forKeyPath:@"failed" context:nil];
    self.submitPriseAvtion.titleLabel.textColor=[UIColor redColor];
    
}



-(void)zanFailedHandler
{
    self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"点赞失败" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [self.alertView show];
    
    //    [self removeObserver:self forKeyPath:@"Succeed" context:nil];
    //    [self removeObserver:self forKeyPath:@"failed" context:nil];
}

-(void)makeComment
{
    SRMakeCommentViewController *commentVC=[[SRMakeCommentViewController alloc]init];
    commentVC.tempShopObjectId=self.sellObjectID;
    //设置下一个页面显示的内容
    [self.navigationController pushViewController:commentVC animated:YES];
    commentVC.hidesBottomBarWhenPushed=YES;
    
}


#pragma --mark  异常处理

-(void)HandleErrorWithRequestFailed
{
    self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"操作失败" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [self.alertView show];
}
- (IBAction)sellerFansAction:(id)sender {
}
@end
