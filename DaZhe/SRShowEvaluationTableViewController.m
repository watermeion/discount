//
//  SRShowEvaluationTableViewController.m
//  DaZhe
//
//  Created by Mac on 11/18/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "SRShowEvaluationTableViewController.h"
#import "SRShowEvaluationTableViewCell.h"
@interface SRShowEvaluationTableViewController ()

@end

@implementation SRShowEvaluationTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PageNumber=0;
    self.showEvaluationBusinessLayer=[[ShowEvaluationOperation alloc]init];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataDidLoad) name:@"DataDidLoad" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleError) name:@"Error" object:nil];
    if (self.sellerObjectId!=nil) {
        self.showEvaluationBusinessLayer.sellerObjectId=self.sellerObjectId;
        [self.showEvaluationBusinessLayer requestDataFromAVOS:PageNumber];
        self.tableView.hidden=YES;
        //        self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"加载中" delegate:self cancelButtonTitle:@"" otherButtonTitles:nil];
        //        [self.alertView show];
        
    }
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refreshView:)
                  forControlEvents:UIControlEventValueChanged];
    //    [self.refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"松手更新数据"]];
    
    [self.tableView addSubview:self.refreshControl];
}
- (void)viewWillLayoutSubviews{
    self.navigationItem.title=@"更多评论";
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
}


-(void) refreshView:(UIRefreshControl *)refresh
{
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"更新数据中..."];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"上次更新日期 %@",
                             [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    //    [self initData];
    [self.showEvaluationBusinessLayer requestDataFromAVOS:PageNumber];
}



-(void)dataDidLoad
{
    [self.refreshControl endRefreshing];
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    [self.tableView reloadData];
    self.tableView.hidden=NO;
    PageNumber++;
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
    if (self.showEvaluationBusinessLayer.result!=nil) {
        return [self.showEvaluationBusinessLayer.result count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL nibsRegistered=NO;
    if(!nibsRegistered){
        UINib *nib=[UINib nibWithNibName:@"SRShowEvaluationTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"SRShowEvaluationTableViewCell"];
    }
    
    SRShowEvaluationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SRShowEvaluationTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSArray *KeyArray=[self.showEvaluationBusinessLayer.result allKeys];
    
    [cell initFromData:[self.showEvaluationBusinessLayer.result  objectForKey:[KeyArray objectAtIndex:[indexPath row]]]];
    
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
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 */

-(void)handleError
{
    [self.refreshControl endRefreshing];
    self.tableView.hidden=YES;
    self.alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"出错了" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [self.alertView show];
    
    
}

@end
