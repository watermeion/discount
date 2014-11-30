//
//  SRSecondVC.m
//  DaZhe
//
//  Created by GeoBeans on 14-10-15.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRSecondVC.h"
#import "DropDownListView.h"
#import "SRCell1.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MJRefresh.h"
#import "SRDetailVC.h"
#import "SellerInfo.h"

@interface SRSecondVC ()
{
    enum filterStyle {
        all=0,
        bestDistance,
        bestDiscount,
        bestScore,
        leastCost,
        mostCost
    };
}

@end

@implementation SRSecondVC
@synthesize tableView=_tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *chooseArray1=[[NSMutableArray alloc]initWithObjects:
                                  [[NSDictionary alloc]initWithObjectsAndKeys:@"全部分类",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"今日新单",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"美食",@"type",@"1",@"detailExist",@[@"全部",@"火锅",@"自助餐",@"西餐",@"烧烤/烤串",@"麻辣烫",@"日韩料理",@"蛋糕甜点",@"麻辣香锅",@"川湘菜",@"江浙菜",@"粤菜",@"西北/东北菜",@"京菜/鲁菜",@"云贵菜",@"东南亚菜",@"台湾菜",@"海鲜",@"小吃快餐",@"特色菜",@"汤/粥/炖菜",@"咖啡/酒吧",@"新疆菜",@"聚餐宴请",@"其他美食",@"清真菜"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"电影",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"酒店",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"休闲娱乐",@"type",@"1",@"detailExist",@[@"全部",@"KTV",@"亲子游玩",@"温泉",@"洗浴",@"洗浴/汗蒸",@"足疗按摩",@"景点郊游",@"游泳/水上乐园",@"游乐园",@"运动健身",@"采摘",@"桌游/电玩",@"密室逃脱",@"咖啡酒吧",@"演出赛事",@"DIY手工",@"真人CS",@"4D/5D电影",@"其他娱乐"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"生活服务",@"type",@"1",@"detailExist",@[@"全部",@"婚纱摄影",@"儿童摄影",@"个性写真",@"母婴亲子",@"体检保健",@"汽车服务",@"逛街购物",@"照片冲印",@"培训课程",@"鲜花婚庆",@"服装定制洗护",@"配镜",@"商场购物卡",@"其他生活"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"丽人",@"type",@"1",@"detailExist",@[@"全部",@"美发",@"美甲",@"美容美体",@"瑜伽/舞蹈"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"旅游",@"type",@"1",@"detailExist",@[@"全部",@"景点门票",@"本地/周边游",@"国内游",@"境外游",@"漂流"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"购物",@"type",@"1",@"detailExist",@[@"全部",@"女装",@"男装",@"内衣",@"鞋靴",@"箱包/皮具",@"家具日用",@"家纺",@"食品",@"饰品/手表",@"美妆/个护",@"电器/数码",@"母婴/玩具",@"运动/户外",@"本地购物",@"其他购物"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"抽奖",@"type",@"0",@"detailExist",nil]
                                  , nil];
    
    NSMutableArray *chooseArray2=[[NSMutableArray alloc]initWithObjects:
                                  [[NSDictionary alloc]initWithObjectsAndKeys:@"全城",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"热门商区",@"type",@"1",@"detailExist",@[@"全部",@"滨江道",@"塘沽城区",@"大悦城",@"经济开发区",@"白堤路/风荷园",@"小海地",@"五大道",@"静海县",@"大港油田",@"大港城区",@"汉沽城区",@"河东万达广场",@"天津站后广场",@"乐园道",@"新港"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"滨海新区",@"type",@"1",@"detailExist",@[@"全部",@"塘沽城区",@"经济开发区",@"小海地",@"五大道",@"大港油田",@"大港城区",@"大港学府路",@"汉沽城区",@"新港"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"南开区",@"type",@"1",@"detailExist",@[@"全部",@"大悦城",@"白堤路/风荷园",@"王顶堤/华苑",@"水上/天塔",@"时代奥城",@"长虹公园",@"南开公园",@"海光寺/六里台",@"南开大学",@"天拖地区",@"鞍山西道",@"乐天",@"咸阳路/黄河道",@"天佑路/西南角"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"和平区",@"type",@"1",@"detailExist",@[@"全部",@"滨江道",@"和平路",@"小白楼",@"鞍山道沿线",@"南市",@"五大道",@"西康路沿线",@"荣业大街",@"卫津路沿线"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"红桥区",@"type",@"1",@"detailExist",@[@"全部",@"芥园路/复兴路",@"丁字沽",@"凯莱赛/西沽",@"水木天成",@"天津西站",@"大胡同",@"鹏欣水游城",@"邵公庄",@"本溪路",@"天津之眼"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"河西区",@"type",@"1",@"detailExist",@[@"全部",@"小海地",@"体院北",@"图书大厦",@"梅江",@"永安道",@"尖山",@"佟楼",@"宾西",@"挂甲寺",@"友谊路",@"越秀路",@"南楼",@"下瓦房",@"乐园道",@"新业广场"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"河东区",@"type",@"1",@"detailExist",@[@"全部",@"中山门",@"大直沽",@"大王庄",@"工业大学",@"万新村",@"卫国道",@"二宫",@"大桥道",@"河东万达广场",@"天津站后广场"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"河北区",@"type",@"1",@"detailExist",@[@"全部",@"王串场/民权门",@"中山路",@"意大利风情区",@"天泰路/榆关道",@"狮子林大街",@"金钟河大街"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"津南区",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"东丽区",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"西青区",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"武清区",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"近郊",@"type",@"1",@"detailExist",@[@"全部",@"北辰区",@"蓟县",@"静海县",@"宝坻区"],@"detail",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"宁河县",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"武清区",@"type",@"0",@"detailExist",nil]
                                  , nil];
    NSMutableArray *chooseArray3=[[NSMutableArray alloc]initWithObjects:
                                  [[NSDictionary alloc]initWithObjectsAndKeys:@"智能排序",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"离我最近",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"折扣最高",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"评价最好",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"人均最低",@"type",@"0",@"detailExist",nil]
                                  ,[[NSDictionary alloc]initWithObjectsAndKeys:@"人均最高",@"type",@"0",@"detailExist",nil]
                                  , nil];

    chooseArray=[NSMutableArray arrayWithObjects:chooseArray1,chooseArray2,chooseArray3, nil];
    DropDownListView *dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 40) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [self.view addSubview:dropDownView];
    
    HUD = [[JGProgressHUD alloc] initWithStyle:1];
    HUD.userInteractionEnabled = YES;
    HUD.delegate = self;
    
    recordArray=[[NSMutableArray alloc]init];
    headerRefreshing=NO;
    footerRefreshing=NO;
    
    _rankStyle=all;
    _sellerClass=@"";
    _sellerDistrict=@"";
    _sellerSubClass=@"";
    
    [self tableViewInit];
}

- (void)viewWillLayoutSubviews{
    self.navigationItem.title=@"附近折扣商品";
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
}

//*********************dropdownList********************//
#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index row:(NSInteger)row
{
    
    if (section==0) {
        if (row==-1){
            if ([[chooseArray[section][index] objectForKey:@"type"] isEqualToString:@"全部分类"]) {
                _sellerClass=@"";
            }else
                _sellerClass=[chooseArray[section][index] objectForKey:@"type"];
        }
        else{
            _sellerClass=[chooseArray[section][index] objectForKey:@"type"];
            if (row==0) {
                _sellerSubClass=@"";
            }else
                _sellerSubClass=[[chooseArray[section][index] objectForKey:@"detail"]objectAtIndex:row];
        }
    }
    else if (section==1){
        
    }
    else if (section==2){
        
        _rankStyle=(int)index;
        
    }
    
    headerRefreshing=YES;
    [HUD showInView:self.view];
    [self headerRereshing];

}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}

-(NSInteger)numberOfRowsOfPart1InSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}

-(NSInteger)numberOfRowsOfPart2InSection:(NSInteger)section Row:(NSInteger)row
{
    if ([[chooseArray[section][row] objectForKey:@"detailExist"] isEqualToString:@"1"]) {
        NSArray *arr=[chooseArray[section][row] objectForKey:@"detail"];
        return [arr count];
    }
    else
        return 0;
}

-(NSString *)titleOfPart1InSection:(NSInteger)section index:(NSInteger) index{
    return [chooseArray[section][index] objectForKey:@"type"];
}

-(NSString *)titleOfPart2InSection:(NSInteger)section index:(NSInteger) index row:(NSInteger)row{
    return [[chooseArray[section][index] objectForKey:@"detail"]objectAtIndex:row];
}

-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
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

- (void)footRefreshData{
    AVQuery *query=[AVQuery queryWithClassName:@"SellerInfo"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    query.maxCacheAge = 24*3600;
    query.limit = 10;
    query.skip=skipTimes*10;
    skipTimes++;
    
    if ([_sellerClass length]>0) {
        [query whereKey:@"sellerClass" equalTo:_sellerClass];
    }
    if ([_sellerSubClass length]>0) {
        [query whereKey:@"sellerSubClass" equalTo:_sellerSubClass];
    }
    if ([_sellerDistrict length]>0) {
        [query whereKey:@"sellerCity" equalTo:_sellerDistrict];
    }
    
    if (_rankStyle==bestDistance) {
        [query whereKey:@"sellerGeoPoint" nearGeoPoint:[AVGeoPoint geoPointWithLatitude:39.963396 longitude:116.396795]];
    }else if (_rankStyle==bestDiscount){
        [query orderByDescending:@"sellerDiscountNumber"];
    }else if (_rankStyle==bestScore){
        [query orderByDescending:@"sellerAllScore"];
    }else if (_rankStyle==leastCost){
        [query orderByAscending:@"sellerAverageCost"];
    }else if (_rankStyle==mostCost){
        [query orderByDescending:@"sellerAverageCost"];
    }

    
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
            [HUD dismiss];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息加载失败" message:@"网络有点不给力哦，请稍后再试~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }];
    query=nil;
}

-(void)refreshData{
    
    AVQuery *query=[SellerInfo query];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    query.maxCacheAge = 24*3600;
    query.limit = 10;
    query.skip=skipTimes*10;
    skipTimes=1;
    
    if ([_sellerClass length]>0) {
        [query whereKey:@"sellerClass" equalTo:_sellerClass];
    }
    if ([_sellerSubClass length]>0) {
        [query whereKey:@"sellerSubClass" equalTo:_sellerSubClass];
    }
    if ([_sellerDistrict length]>0) {
        [query whereKey:@"sellerCity" equalTo:_sellerDistrict];
    }
    if (_rankStyle==bestDistance) {
        [query whereKey:@"sellerGeoPoint" nearGeoPoint:[AVGeoPoint geoPointWithLatitude:39.963396 longitude:116.396795]];
    }else if (_rankStyle==bestDiscount){
        [query orderByDescending:@"sellerDiscountNumber"];
    }else if (_rankStyle==bestScore){
        [query orderByDescending:@"sellerAllScore"];
    }else if (_rankStyle==leastCost){
        [query orderByAscending:@"sellerAverageCost"];
    }else if (_rankStyle==mostCost){
        [query orderByDescending:@"sellerAverageCost"];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (headerRefreshing) {
                [recordArray removeAllObjects];
            }
            for (SellerInfo *obj in objects) {
                
                [recordArray addObject:obj];
            }
            
            cellNum=[recordArray count];
            
            [self.tableView reloadData];
            
            if (headerRefreshing) {
                [self.tableView headerEndRefreshing];
                headerRefreshing=NO;
            }
            
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
    skipTimes=0;
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


//- (void)filterSeller:(NSString*)sellerClass SubClass:(NSString*)sellerSubClass District:(NSString*)city Skip:(int)skip RankStyle:(int)rankStyle{
//    
//    AVQuery *query=[AVQuery queryWithClassName:@"SellerInfo"];
//    query.cachePolicy = kPFCachePolicyNetworkElseCache;
//    query.maxCacheAge = 24*3600;
//    query.limit = 10;
//    
//    if (skip!=0) {
//        query.skip=skip*10;
//    }
//    if ([sellerClass length]>0) {
//        [query whereKey:@"sellerClass" equalTo:sellerClass];
//    }
//    if ([sellerSubClass length]>0) {
//        [query whereKey:@"sellerSubClass" equalTo:sellerSubClass];
//    }
//    if ([city length]>0) {
//        [query whereKey:@"sellerCity" equalTo:city];
//    }
//    if (rankStyle==bestDistance) {
//        [query whereKey:@"sellerGeoPoint" nearGeoPoint:[AVGeoPoint geoPointWithLatitude:39.963396 longitude:116.396795]];
//    }else if (rankStyle==bestDiscount){
//        [query orderByDescending:@"sellerDiscountNumber"];
//    }else if (rankStyle==bestScore){
//        [query orderByDescending:@"sellerAllScore"];
//    }else if (rankStyle==leastCost){
//        [query orderByAscending:@"sellerAverageCost"];
//    }else if (rankStyle==mostCost){
//        [query orderByDescending:@"sellerAverageCost"];
//    }
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            
//                [recordArray removeAllObjects];
//
//            for (int i=0; i<[objects count]; i++) {
//                
//                NSString *sellerName=[[objects objectAtIndex:i] objectForKey:@"sellerName"];
//                NSString *sellerKeyWord=[[objects objectAtIndex:i] objectForKey:@"sellerKeyword"];
//                NSNumber *customAverage=[[objects objectAtIndex:i] objectForKey:@"sellerAverageCost"];
//                NSNumber *priseCount=[[objects objectAtIndex:i] objectForKey:@"sellerPriseCount"];
//                AVFile *imageFile=[[objects objectAtIndex:i] objectForKey:@"sellerLogo"];
//                
//                NSString *sellerObjectId=[[objects objectAtIndex:i] objectForKey:@"objectId"];
//                
//                NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
//                if (sellerName) {
//                    [dic setObject:sellerName forKey:@"sellerName"];
//                }
//                if (sellerKeyWord) {
//                    [dic setObject:sellerKeyWord forKey:@"sellerKeyWord"];
//                }
//                if (customAverage) {
//                    [dic setObject:customAverage forKey:@"customAverage"];
//                }
//                if (priseCount) {
//                    [dic setObject:priseCount forKey:@"priseCount"];
//                }
//                
//                if (imageFile) {
//                    [dic setObject:imageFile forKey:@"imageFile"];
//                }
//                
//                if (sellerObjectId) {
//                    [dic setObject:sellerObjectId forKey:@"sellerObjectId"];
//                }
//                
//                [recordArray addObject:dic];
//                
//                dic=nil;
//            }
//            
//            cellNum=[recordArray count];
//            
//            [self.tableView reloadData];
//            
//            [HUD dismiss];
//            
//        } else {
//            
//            [HUD dismiss];
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息加载失败" message:@"网络有点不给力哦，请稍后再试~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//        }
//    }];
//    query=nil;
//}
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
