//
//  SRMakeCommentViewController.m
//  DaZhe
//
//  Created by Mac on 11/17/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "SRMakeCommentViewController.h"
#import "Evaluation.h"
@interface SRMakeCommentViewController ()

@end

@implementation SRMakeCommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillLayoutSubviews{
    self.navigationItem.title=@"添加评论";
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitConfirm:(id)sender {
    [self addComment];
}


-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return  [textView resignFirstResponder];
}

-(void)addComment
{
    Evaluation *obj=[[Evaluation alloc]init];
    obj.evaluationMemberObjectID=[[AVUser currentUser]objectId];
    obj.evaluationShopObjectID=self.tempShopObjectId;
    obj.evaluationContent=self.commentInputView.text;
    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"评论成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.alertView show];
        }
        else
        {
            self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"评论失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self.alertView show];
        
        
        
        }
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (DEVICE_IS_IPHONE4){
        self.scrollView.frame=CGRectMake(0, 0, 320, 376);
//        self.view7.center=CGPointMake(self.view7.center.x, self.view7.center.y-88);
    }
    
}

@end
