//
//  SRFirstVC.m
//  DaZhe
//
//  Created by GeoBeans on 14-9-22.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRFirstVC.h"
#import "SRCell1.h"
#import "QRCodeGenerator.h"
#import "SRCodeVC.h"
#import "SRSearchVC.h"
#import "SRSecondVC.h"
#import "SRDetailVC.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SRLoginVC.h"
#import "MJRefresh.h"
#import "SellerInfo.h"


@interface SRFirstVC ()<UIAlertViewDelegate,finishLogin>

@end

@implementation SRFirstVC
@synthesize tableView=_tableView;
@synthesize headView=_headView;
@synthesize headView2=_headView2;


- (void)viewWillLayoutSubviews{

    self.titleView.frame=CGRectMake(0, 0, 320, 44);
    self.navigationItem.titleView=self.titleView;
    
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
}

- (void)checkIfSwitchUser{
    
    if ([AVUser currentUser]!=nil) {
        if (![[AVUser currentUser].objectId isEqualToString:self.objectID]) {
            
            _tableView.tableHeaderView=_headView;
            [_headView2 setFrame:CGRectMake(0, 100, 320, 230)];
            [_headView addSubview:_headView2];
            
            //将objectID生成二维码
            self.codeImage=[QRCodeGenerator qrImageForString:[AVUser currentUser].objectId imageSize:720];
            self.codeImageView.image=self.codeImage;
            
            if (firstLoad) {
                firstLoad=NO;
            }else{
                [_tableView reloadData];
            }
            self.objectID=[AVUser currentUser].objectId;
        }
    }
    else {
        [_headView2 setFrame:CGRectMake(0, 0, 320, 230)];
        _tableView.tableHeaderView=_headView2;
        self.objectID=@"";
        if (firstLoad) {
            firstLoad=NO;
        }else{
            [_tableView reloadData];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [self checkIfSwitchUser];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    firstLoad=YES;
    
    HUD = [[JGProgressHUD alloc] initWithStyle:1];
    HUD.userInteractionEnabled = YES;
    HUD.delegate = self;
    
    
    recordArray=[[NSMutableArray alloc]init];
    headerRefreshing=NO;
    footerRefreshing=NO;
    
    [self advertisementInit];
    
    [self checkIfSwitchUser];
    
    [self tableViewInit];
}

//*********************二维码********************//
- (IBAction)showCode:(id)sender {
    if ([AVUser currentUser]!=nil) {
        SRCodeVC *codeVC=[[SRCodeVC alloc]init];
        codeVC.codeImage=self.codeImage;
        codeVC.hidesBottomBarWhenPushed=YES;
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"";
        backItem.tintColor=[UIColor whiteColor];
        self.navigationItem.backBarButtonItem = backItem;
        
        [self.navigationController pushViewController:codeVC animated:YES];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"账户未登录" message:@"亲爱的用户，您尚未登录账户，是否现在登录？" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        alert.delegate=self;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
        SRLoginVC *loginVC=[SRLoginVC shareLoginVC];
        loginVC.loginDelegate=self;
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }
}

- (void)finishLogin{
    [self checkIfSwitchUser];
}
//*********************advertisement********************//
-(void)advertisementInit{
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:
                         @"http://ww1.sinaimg.cn/large/53e0c4edjw1dy3qf6n17xj.jpg",
                         @"http://ww1.sinaimg.cn/large/53e0c4edjw1dy3qf6n17xj.jpg",@"http://ww1.sinaimg.cn/large/53e0c4edjw1dy3qf6n17xj.jpg",
                         @"http://ww1.sinaimg.cn/large/53e0c4edjw1dy3qf6n17xj.jpg",@"http://ww1.sinaimg.cn/large/53e0c4edjw1dy3qf6n17xj.jpg",
                         nil];
    
    SRAdvertisingView *adView=[[SRAdvertisingView alloc]initWithFrame:CGRectMake(0, 0, 320, 130) imageArray:arr interval:3.0];
    adView.vDelegate=self;
    [_headView2 addSubview:adView];
}

-(void)buttonClick:(int)vid{
    NSLog(@"%d",vid);
}
//*****************searchViewController****************//

- (IBAction)showSearchVC:(id)sender {
    SRSearchVC *searchVC=[[SRSearchVC alloc]init];
    searchVC.hidesBottomBarWhenPushed=YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    backItem.tintColor=[UIColor whiteColor];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:searchVC animated:YES];
}


//*********************tableView********************//
- (void)tableViewInit{
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.scrollEnabled=YES;
    skipTimes=0;
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [HUD showInView:self.view];
    [self refreshData];
}

-(void)footRefreshData{
    
    AVQuery *query=[AVQuery queryWithClassName:@"SellerInfo"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    query.maxCacheAge = 24*3600;
    query.limit = 10;
    query.skip=skipTimes*10;
    skipTimes++;

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (SellerInfo *obj in objects) {
                
                [recordArray addObject:obj];

            }
                
            NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
            
            NSInteger n=[recordArray count];
            NSInteger m=[objects count];
            
            for (NSInteger k=n-m; k<[recordArray count];k++) {
                NSIndexPath *newPath = [NSIndexPath indexPathForRow:k inSection:0];
                [insertIndexPaths addObject:newPath];
            }
            cellNum=[recordArray count];
            [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView footerEndRefreshing];
            footerRefreshing=NO;

            [HUD dismiss];
            
        } else {
            [HUD dismiss];

            if (footerRefreshing) {
                [self.tableView footerEndRefreshing];
                footerRefreshing=NO;
            }

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息加载失败" message:@"网络有点不给力哦，请稍后再试~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }];
    query=nil;

}

-(void)refreshData{
    
    AVQuery *query=[AVQuery queryWithClassName:@"SellerInfo"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    query.maxCacheAge = 24*3600;
    query.limit = 10;
    skipTimes=1;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (headerRefreshing) {
                [recordArray removeAllObjects];
            }
            for (SellerInfo *obj in objects) {
                
                [recordArray addObject:obj];
                
            }
            
            if (headerRefreshing) {
                headerRefreshing=NO;
            }
            
            cellNum=[recordArray count];
            
            [self.tableView reloadData];
            
            [self.tableView headerEndRefreshing];
            
            [HUD dismiss];
            
        } else {
            [HUD dismiss];
            
            if (headerRefreshing) {
                [self.tableView headerEndRefreshing];
                headerRefreshing=NO;
            }

            if (firstLoad) {
                [HUD dismiss];
                firstLoad=NO;
            }
            [HUD dismiss];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息加载失败" message:@"网络有点不给力哦，请稍后再试~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }];
    query=nil;
}

- (void)footerRereshing{
    footerRefreshing=YES;
    [self footRefreshData];
}

- (void)headerRereshing{
    headerRefreshing=YES;
    [self refreshData];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        BOOL nibsRegistered = NO;
        
        static NSString *Cellidentifier=@"SRCell1";
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:@"SRCell1" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:Cellidentifier];
            nibsRegistered = YES;
        }
        
        SRCell1 *cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier forIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryNone;
        
        NSUInteger row=[indexPath row];
        SellerInfo *seller=[recordArray objectAtIndex:row];
        
        cell.sellerNameLabel.text=seller.sellerName;
        
        AVFile *file=seller.sellerLogo;
        if (file!=nil) {
            cell.sellerImage.placeholderImage=[UIImage imageNamed:@"wm_bg_line.png"];
            cell.sellerImage.imageURL=[NSURL URLWithString:[file url]];
        }
        
        cell.sellerKeyWordLabel.text=seller.sellerKeyword;
        cell.customAverage.text=[NSString stringWithFormat:@"人均:￥%@元", seller.sellerAverageCost];
        cell.priseCount.text=[NSString stringWithFormat:@"赞:%@次", seller.sellerPriseCount];
        
        return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellNum;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//改变行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    SRDetailVC *detailVC=[[SRDetailVC alloc]init];
    detailVC.hidesBottomBarWhenPushed=YES;
    SellerInfo *_seller=[recordArray objectAtIndex:[indexPath row]];
    detailVC.sellData=_seller;
    detailVC.sellObjectID=_seller.objectId;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    backItem.tintColor=[UIColor whiteColor];
    self.navigationItem.backBarButtonItem = backItem;

    [self.navigationController pushViewController:detailVC animated:YES];
    
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
}

- (void)deselect
{
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

//*********************MainButton********************//
- (IBAction)showFood:(id)sender {
    [self showDetail];
}

- (IBAction)showHotel:(id)sender {
    [self showDetail];
}

- (IBAction)showPlay:(id)sender {
    [self showDetail];
}

- (IBAction)showMore:(id)sender {
    [self showDetail];
}

- (void)showDetail{
    SRSecondVC *secondVC=[[SRSecondVC alloc]init];
    secondVC.hidesBottomBarWhenPushed=YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    backItem.tintColor=[UIColor whiteColor];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:secondVC animated:YES];

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
