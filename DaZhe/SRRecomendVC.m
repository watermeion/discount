//
//  SRRecomendVC.m
//  DaZhe
//
//  Created by RAY on 14/11/17.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRRecomendVC.h"
#import "CWStarRateView.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SCLAlertView.h"

@interface SRRecomendVC ()<CWStarRateViewDelegate,UITextViewDelegate>
@property (strong, nonatomic) CWStarRateView *starRateView1;
@property (strong, nonatomic) CWStarRateView *starRateView2;
@property (strong, nonatomic) CWStarRateView *starRateView3;
@property (strong, nonatomic) CWStarRateView *starRateView4;
@end

@implementation SRRecomendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setCenter:CGPointMake(80,280)];
    [self.view addSubview:indicatorView];
    [indicatorView stopAnimating];
    
    self.starRateView1 = [[CWStarRateView alloc] initWithFrame:CGRectMake(50, 140, 260, 40) numberOfStars:5];
    self.starRateView1.scorePercent = 0.0;
    self.starRateView1.allowIncompleteStar = NO;
    self.starRateView1.hasAnimation = YES;
    self.starRateView1.delegate=self;
    self.starRateView1.tag=1;
    [self.view addSubview:self.starRateView1];
    
    self.starRateView2 = [[CWStarRateView alloc] initWithFrame:CGRectMake(50, 190, 260, 40) numberOfStars:5];
    self.starRateView2.scorePercent = 0.0;
    self.starRateView2.allowIncompleteStar = NO;
    self.starRateView2.hasAnimation = YES;
    self.starRateView2.delegate=self;
    self.starRateView2.tag=2;
    [self.view addSubview:self.starRateView2];
    
    self.starRateView3 = [[CWStarRateView alloc] initWithFrame:CGRectMake(50, 240, 260, 40) numberOfStars:5];
    self.starRateView3.scorePercent = 0.0;
    self.starRateView3.allowIncompleteStar = NO;
    self.starRateView3.hasAnimation = YES;
    self.starRateView3.delegate=self;
    self.starRateView3.tag=3;
    [self.view addSubview:self.starRateView3];
    
    self.starRateView4 = [[CWStarRateView alloc] initWithFrame:CGRectMake(50, 290, 260, 40) numberOfStars:5];
    self.starRateView4.scorePercent = 0.0;
    self.starRateView4.allowIncompleteStar = NO;
    self.starRateView4.hasAnimation = YES;
    self.starRateView4.delegate=self;
    self.starRateView4.tag=4;
    [self.view addSubview:self.starRateView4];
    
    value1=0.0f;
    value2=0.0f;
    value3=0.0f;
    value4=0.0f;
    
    self.textView.delegate=self;
    self.textView.opaque=YES;
    firstWrite=YES;
    recomendString=@"";
    
    rect1=CGRectMake(10, 360, 300, 80);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillLayoutSubviews{
    [self.navBar setFrame:CGRectMake(0, 0, 320, 64)];
    [self.navBar setTranslucent:NO];
    [self.navBar setBarTintColor:[UIColor colorWithRed:0.97 green:0.31 blue:0.36 alpha:1.0]];
}

- (IBAction)touchOK:(id)sender {
    NSDictionary *parameters=[NSDictionary dictionaryWithObjectsAndKeys:recomendString,@"commentContent",[NSNumber numberWithFloat:value1],@"evaluationStarAll",[NSNumber numberWithFloat:value2],@"evaluationStarTaste",[NSNumber numberWithFloat:value3],@"evaluationStarEnvironment",[NSNumber numberWithFloat:value4],@"evaluationStartServe",[AVUser currentUser].objectId,@"commentUserObjectId",self.selleObjectId,@"commentShopObjectId",self.commentDiscountObjectId,@"commentDiscountObjectId", nil];
    
    [AVCloud callFunctionInBackground:@"add_comment" withParameters:parameters block:^(id object, NSError *error) {
        [indicatorView stopAnimating];
        if (!error) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"确定" target:self selector:@selector(success)];
            [alert showSuccess:self title:@"评论成功" subTitle:@"感谢您的评价" closeButtonTitle:nil duration:0.0f];
            
        }else{
            
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            
            [alert showError:self title:@"评论失败"
                    subTitle:@"对不起，网络通信故障，暂时不能评论"
            closeButtonTitle:@"确定" duration:0.0f];
        }
    }];
}

- (void)success{
    [self dismissViewControllerAnimated:NO completion:^{
        [self.RecomendDelegate successRecomended];
    }];
}

- (IBAction)touchCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
}


- (void)textViewDidEndEditing:(UITextView *)textView{
    recomendString=self.textView.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (firstWrite) {
        self.textView.text=@"";
        firstWrite=NO;
    }
}

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    if (starRateView.tag==1) {
        value1=starRateView.scorePercent*5;
    }
    if (starRateView.tag==2) {
        value2=starRateView.scorePercent*5;
    }
    if (starRateView.tag==3) {
        value3=starRateView.scorePercent*5;
    }
    if (starRateView.tag==4) {
        value4=starRateView.scorePercent*5;
    }
}

- (void)keyboardWillShow:(NSNotification *)notification{
    
    CGRect rect2;
    if (DEVICE_IS_IPHONE4) {
        rect2=CGRectMake(rect1.origin.x, rect1.origin.y-300, rect1.size.width, rect1.size.height);
        }else{
        rect2=CGRectMake(rect1.origin.x, rect1.origin.y-200, rect1.size.width, rect1.size.height);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.textView.frame=rect2;
    }];

}

- (void)keyboardWillhide:(NSNotification *)notification{
        
    [UIView animateWithDuration:0.3 animations:^{
        self.textView.frame=rect1;
    }];

}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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

@end
