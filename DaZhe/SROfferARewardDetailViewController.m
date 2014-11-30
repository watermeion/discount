//
//  SROfferARewardDetailViewController.m
//  DaZhe
//
//  Created by Mac on 11/8/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "SROfferARewardDetailViewController.h"
#import "SROfferARewardDetailTableViewCell.h"
#import "RewardZan.h"
#import "SRLoginVC.h"
#import "Reward.h"
#import "CommonMacro.h"
@interface SROfferARewardDetailViewController ()

@end

@implementation SROfferARewardDetailViewController
//建立加载数据信息到，view上
-(void)loadDataToView:(SROfferARewardDataObject *)data
{
    // 加载数据
    self.rewardTitleName.text=data.rewardTitleName;
    self.rewardMoneyNumber.text=data.rewardMoneyNumber;
    self.storeName.text=data.storeName;
    self.storeDetails.text=data.storeDetails;
    self.storeZone.text=data.storeZone;
    self.storeBelongings.text=data.storeBelongings;
    self.storeImage.image=data.storeImage;
    self.usrNikiName.text=data.usrNikiName;
    self.likersNumber.text=data.likersNumber;
    self.usrProfileImage.image=data.usrProfileImage;
    self.storeAddress.text=data.storeAddress;
    self.challegersNumber.text=data.chanllageNum;
//    self.rewardDetailWordsText.text=data.rewardContent;
    //    self.usrLevelImage.image=data.usrLevelImage
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (DEVICE_IS_IPHONE4){
//        self.scrollView.frame=CGRectMake(0, 0, 320, 376);
        
        self.view7.center=CGPointMake(self.view7.center.x, self.view7.center.y-88);
    }

    self.scrollView.contentSize=CGSizeMake(320, 560);
    self.commentsTableView.hidden=YES;
    //初始化 业务层Object
    self.businessLayerObject=[[SRRewardEvaluationOperation alloc]init];
    //注册监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadViewRewardEvaluationData) name:@"RewardEvaluationDataChanged" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HandleErrorWithRequestFailed) name:@"RequestError" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HandleErrorWithDidNotLogin) name:@"DidNotLoginError" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HandleErrorWithOverdo) name:@"OverDoneError" object:nil];
    
   
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PriseSucceed) name:@"PriseSucceed" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CommentSucceed) name:@"CommentSucceed" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gainRewardSucceed) name:@"GainRewardSucceed" object:nil];
    
    //判断数据是否加载进来，如果没有，不显示
    if (self.dataSoure==nil) {
        NSLog(@"rewardDetail.dataSource is nil");
        
    }
    else
    {
        [self loadDataToView:self.dataSoure];
        
        self.businessLayerObject.dataSoure=self.dataSoure;
        self.businessLayerObject.rewardObjectId=self.RewardObjectId;
        [self viewHidden:NO];
        
//        AVUser *usr=[AVUser currentUser];
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            // long-running task
//            BOOL hasPrisedBefore=[self.businessLayerObject checkObjectExistency:usr.objectId className:@"RewardZan" Keyname:@"zanUserObjectId"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                // update UI
//                if (hasPrisedBefore) {
//                    self.submitRewardZan.enabled=YES;
//                }
//                else
//                {
//                self.submitRewardZan.enabled=NO;
//                  
//                }
//            });  
//        });

        //加载评论
        if (self.RewardObjectId!=nil) {
            self.businessLayerObject.rewardObjectId=self.RewardObjectId;
            [self.businessLayerObject requestOnAVOS:0];
        }
        else{
            
            
        }
        
    }
    
    //判断是不登陆,控制点赞和评论逻辑
    //    AVUser *usr=[AVUser currentUser];
    //    if (usr!=nil) {
    //        if ([self.businessLayerObject checkObjectExistency:usr.objectId className:@"RewardZan"];) {
    //
    //        }
    //    }else
    //    {
    //
    //        self.alert.tag=00000;
    //        self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"您好,您还未登陆，现在就是登陆？" delegate:self cancelButtonTitle:@"等会去" otherButtonTitles:@"马上去",nil];
    //        self.alert.tag=10001;
    //        [self.alert show];
    //
    //    }
    //
    //判断是否点过赞
    if (![self.businessLayerObject checkObjectExistency:self.RewardObjectId className:@"RewardZan" Keyname:@"rewardObjectId"]) {
        //点过赞的动作
        self.submitRewardZan.titleLabel.textColor=[UIColor redColor];
    }
        AVUser *usr=[AVUser currentUser];
        if (usr!=nil) {
            if (![self.businessLayerObject checkObjectExistencyWith2Conditions_value:usr.objectId className:@"GetReward" Keyname1:@"getUserObjectId" keyname2:@"rewardObjectId" value2:self.RewardObjectId])
            {
                 self.gainRewards.titleLabel.textColor=[UIColor redColor];
            }
        }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
    if(self.dataSoure)
       {
           [self viewHidden:NO];
       }
    else{
        [self viewHidden:YES];
        self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"小萌：对不起，加载数据出错了~" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [self.alert show];
        
    }
}

- (void)viewWillLayoutSubviews{
    self.navigationItem.title=@"详情";
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
    
    
}




- (void)ViewGone:(UIView *)senderView{
    if (senderView.hidden == NO) {
        senderView.hidden = YES;
        //获取源控件的View
        NSInteger targetY = senderView.frame.origin.y;
        NSInteger targetHeightY = senderView.frame.origin.y+senderView.frame.size.height+10;
        
        BOOL isHidden = senderView.hidden;
        if (isHidden) {
            for (UIView *view in self.scrollView.subviews) {
                NSInteger tempY = view.frame.origin.y;
                //如果遇到view的Y坐标等于目标的Y坐标，且不为hidden的话，则暂停，恐会覆盖调
                if(tempY == targetY && !view.hidden){
                    break;
                }
                if (tempY >= targetHeightY ) {
                    if ([view isMemberOfClass:[UIImageView class]]) {
                        continue;
                    }
                    //上移到目标位置，达到隐藏的效果
                    CGRect tmpFrame = CGRectMake(view.frame.origin.x, view.frame.origin.y-senderView.frame.size.height-10, view.frame.size.width, view.frame.size.height);
                    view.frame = tmpFrame;
                }
            }
        }
    }
}


-(void)loadViewRewardEvaluationData
{
    self.commentsTableView.hidden=NO;
    
    NSUInteger cellNumber=[self.businessLayerObject.results count];
    if(cellNumber>2){
     self.scrollView.contentSize=CGSizeMake(self.commentsTableView.bounds.size.width, (self.commentsTableView.bounds.size.height+88.0*cellNumber));
    }
    [self.commentsTableView reloadData];
}

- (IBAction)showLocationButton:(id)sender {
    NSLog(@"显示位置信息");
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if(self.businessLayerObject.results!=nil)
    {
        return [self.businessLayerObject.results count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL nibsRegistered=NO;
    if(!nibsRegistered){
        UINib *nib=[UINib nibWithNibName:@"SROfferARewardDetailTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"SROfferARewardDetailTableViewCell"];
      
    }
    
    SROfferARewardDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SROfferARewardDetailTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSArray *KeyArray=[self.businessLayerObject.results allKeys];
    
    [cell
     dataInit:
     [self.businessLayerObject.results objectForKey:
      [KeyArray objectAtIndex:
       [indexPath row]]]]
    ;
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *string1;
    if (self.businessLayerObject !=nil) {
        string1=[NSString  stringWithFormat:  @"共有%ld人评论",(long)self.businessLayerObject.allCount];
    }
    else
    {
        string1=@"人评论";
    }
    return string1;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (IBAction)makeCommentAction:(id)sender {
    self.alert.tag=20000;
    self.alert=[[UIAlertView alloc]initWithTitle:@"输入评论内容" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"OK",nil];
    self.alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    self.alert.tag=10000;
    [self.alert show];
    //    @dynamic evaluationTitle;
    
    //    evaluationObj.evaluationContent
    
}

- (IBAction)gainRewardAction:(id)sender {
    [self.businessLayerObject gainReward];
}


-(void)saveComment
{
    [self.businessLayerObject saveComment:comment];
   
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1)
    {
        
        if (alertView.tag==10000) {
            UITextField *textField=[self.alert textFieldAtIndex:0];
            comment=textField.text;
            [self saveComment];
        }
        if (alertView.tag==10001) {
            SRLoginVC *loginVC=[SRLoginVC shareLoginVC];
            [self presentViewController:loginVC animated:YES completion:^{
                nil;
            }];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    
}


- (IBAction)submitRewardZan:(id)sender {
    [self.businessLayerObject pushPrise];
}


#pragma --mark interfaceErrorHandler
-(void)HandleErrorWithDidNotLogin
{
    self.alert.tag=00000;
    self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"您好,您还未登陆，现在就是登陆？" delegate:self cancelButtonTitle:@"等会去" otherButtonTitles:@"马上去",nil];
    self.alert.tag=10001;
    [self.alert show];



}

-(void)HandleErrorWithOverdo
{
    self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"重复操作" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [self.alert show];
    self.submitRewardZan.titleLabel.textColor=[UIColor redColor];
}

-(void)HandleErrorWithRequestFailed
{
    self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"操作失败" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [self.alert show];
}


-(void)PriseSucceed
{

    self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"点赞成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [self.alert show];
    
    [self loadViewRewardEvaluationData];
    [self loadDataToView:self.businessLayerObject.dataSoure];
    NSLog(@"kuBe+1 :%@",self.businessLayerObject.dataSoure.rewardMoneyNumber);

    //添加点过赞的动作
    self.submitRewardZan.titleLabel.textColor=[UIColor redColor];
}

-(void)CommentSucceed
{
    self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"评论成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [self.alert show];

}

-(void)gainRewardSucceed{
self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"领赏成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [self.alert show];
    [self loadDataToView:self.businessLayerObject.dataSoure];
    self.gainRewards.titleLabel.textColor=[UIColor redColor];
    
}



-(void)viewHidden:(BOOL) bol
{
    self.scrollView.hidden=bol;
    self.view7.hidden=bol;
    self.view1.hidden=bol;
}
@end
