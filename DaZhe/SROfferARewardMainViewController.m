//
//  SROfferARewardMainViewController.m
//  DaZhe
//
//  Created by Mac on 11/8/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "SROfferARewardMainViewController.h"
#import "SROfferARewardTableViewCell.h"
#import "SROfferARewardDetailViewController.h"
#import "SRWantOfferARewardViewController.h"
#import "SRWhatsOfferRewardViewController.h"
@interface SROfferARewardMainViewController ()
{
  BOOL nibsRegistered;
}
@end

@implementation SROfferARewardMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillLayoutSubviews
{
    self.navigationItem.title=@"悬赏";
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *whatsOfferRewardButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"什么是悬赏"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(whatsOfferRewardButtonAction)];
    
    self.navigationItem.leftBarButtonItem=whatsOfferRewardButtonItem;
    
    UIBarButtonItem *wantOfferARewardButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我要悬赏"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(wantOfferARewardButtonAction)];
    self.navigationItem.rightBarButtonItem=wantOfferARewardButtonItem;
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     nibsRegistered=NO;
    //初始化业务逻辑类
    if (self.businessLayerObject==nil) {
        self.businessLayerObject=[[SROfferRewardDataOperation alloc]init];
        [self.businessLayerObject initilize];
    }
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //初始化时，将tableView隐藏
    self.tableView.hidden=YES;
    //注册监听事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataRespond) name:@"ResultsChanged" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataError) name:@"DataError" object:nil];
    
    
    //第一次加载提交请求，只执行一次
    [self.businessLayerObject requestFirstItemFromAVOS];

        self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"正在加载请稍后" delegate:self cancelButtonTitle:@"知道" otherButtonTitles:nil];
        [self.alertView show];
    
    //初始化refrehControl控件
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(refreshView:)
              forControlEvents:UIControlEventValueChanged];
    [_refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"松手更新数据"]];
    [self.tableView addSubview:_refreshControl];
}


//refresh控件操作函数
-(void) refreshView:(UIRefreshControl *)refresh
{
    //设置下拉刷新显示的字符
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"更新数据中..."];
    //设置下来刷新的时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"上次更新日期 %@",
                             [formatter stringFromDate:[NSDate date]]];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    
    // 请求数据
    [self.businessLayerObject requestItemsFromAVOS];
}


-(void)dataError
{
    [_refreshControl endRefreshing];
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    self.tableView.hidden=YES;
    self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"小萌：对不起，加载数据出错了~" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [self.alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
}


- (void)dataRespond{
    
    [_refreshControl endRefreshing];
    if (self.businessLayerObject.dataDict!=nil && [self.businessLayerObject.dataDict count]!=0) {
        self.dataDictForTableView=self.businessLayerObject.dataDict;
        self.dataKeyForTableView=[self.dataDictForTableView allKeys];
        [self.tableView reloadData];
        self.tableView.hidden=NO;
    }
    [self.alertView dismissWithClickedButtonIndex:0 animated:NO];
}

-(void)whatsOfferRewardButtonAction
{
    SRWhatsOfferRewardViewController *WhatsOfferRewardVC=[[SRWhatsOfferRewardViewController alloc]initWithNibName:@"SRWhatsOfferRewardViewController" bundle:nil];
    WhatsOfferRewardVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:WhatsOfferRewardVC animated:YES];
    
}


-(void)wantOfferARewardButtonAction
{
    SRWantOfferARewardViewController *wantOfferReward=[[SRWantOfferARewardViewController alloc]initWithNibName:@"SRWantOfferARewardViewController" bundle:nil];
    wantOfferReward.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:wantOfferReward animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.dataKeyForTableView!=nil) {
        return  [self.dataKeyForTableView count];
    }
    else
    {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(!nibsRegistered){
        UINib *nib=[UINib nibWithNibName:@"SROfferARewardTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"SROfferARewardTableViewCell"];
        nibsRegistered=YES;
    }
    
    SROfferARewardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SROfferARewardTableViewCell" forIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSString *key=[self.dataKeyForTableView objectAtIndex:[indexPath row]];
    [cell cellDataInit:[self.dataDictForTableView objectForKey:key]];
    return cell;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    SROfferARewardDetailViewController *detailVC=[[SROfferARewardDetailViewController alloc]init];

    detailVC.RewardObjectId=[self.dataKeyForTableView objectAtIndex:[indexPath row]];
    detailVC.dataSoure=[self.dataDictForTableView objectForKey:detailVC.RewardObjectId];
    //设置下一个页面显示的内容
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];

    if (1) {
        //重新刷新数据
        [self.businessLayerObject requestFirstItemFromAVOS];
    }
}
@end
