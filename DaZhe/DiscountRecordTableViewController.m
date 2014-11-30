//
//  DiscountRecordTableViewController.m
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "DiscountRecordTableViewController.h"
#import "DiscountRecordTableViewCell.h"
#import "DiscountRecord.h"
#import "CommonMacro.h"
@interface DiscountRecordTableViewController ()

@end

@implementation DiscountRecordTableViewController
{
    BOOL isNibRegisted;
}

-(DiscountRecordOperation *)businessLayer
{
    if (!_businessLayer) {
        _businessLayer=[[DiscountRecordOperation alloc]init];
    }
    return _businessLayer;
}


-(void)viewWillLayoutSubviews
{
    self.navigationController.navigationItem.title=@"优惠记录";
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isNibRegisted=NO;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.businessLayer.delegate=self;
    
    //刷新数据
   
    [self.businessLayer queryDiscountRecordFromAVOS:0];
    
    //注册错误提示监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleError) name:@"Error" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    if (self.businessLayer.resultsDict==nil) {
        return 0;
    }
    return [self.businessLayer.resultsDict count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!isNibRegisted) {
        UINib *nib=[UINib nibWithNibName:@"DiscountRecordTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"DiscountRecordTableViewCell"];
        isNibRegisted=YES;
    }
    DiscountRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscountRecordTableViewCell" forIndexPath:indexPath];
    // Configure the cell...
    if(self.businessLayer.resultsDict!=nil && [self.businessLayer.resultsDict count]!=0 )
    {
        NSArray *array=[self.businessLayer.resultsDict allKeys];
        DiscountRecord *discountObj=[self.businessLayer.resultsDict objectForKey:[array objectAtIndex:[indexPath row]]];
        cell.eventTitleLabel.text=discountObj.shopName;
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YY/MM/dd HH:mm"];
        cell.eventTimeTag.text=[dateFormatter stringFromDate:discountObj.updatedAt];
        
        cell.eventFavorLabel.text=NSStringFromNumber(discountObj.discountFee);
        
        cell.eventConsumeLabel.text=NSStringFromNumber(discountObj.consumptionFee);
        
        cell.eventTagImage.image=[UIImage imageNamed:@"cu.png"];
        
        cell.eventImage.image=[self.businessLayer requestImage:discountObj.discountMemberLogoURL];
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)updateCellView
{
    [self.tableView reloadData];
}

-(void)usrUnloginAction
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"您好你还未登陆,请先登录" delegate:self cancelButtonTitle:@"等会去" otherButtonTitles:@"马上去",nil];
    [alertView show];
}

-(void)handleError
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"数据加载出错~" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alertView show];
    
}
@end
