//
//  SRNavigationDetail.m
//  DaZhe
//
//  Created by RAY on 14/11/27.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRNavigationDetail.h"
#import "SRNavigationCell.h"
#import "CommonUtility.h"
#import "SRShowRouteVC.h"

@interface SRNavigationDetail ()<AMapSearchDelegate>
{
    AMapSearchAPI *search;
    AMapRoute *route;
}
@property (nonatomic, strong) NSArray *paths;
@property (nonatomic, strong) NSArray *transits;


@end

@implementation SRNavigationDetail
@synthesize startCoord=_startCoord;
@synthesize destinationCoord=_destinationCoord;
@synthesize searchType=_searchType;
@synthesize headView=_headView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HUD = [[JGProgressHUD alloc] initWithStyle:1];
    HUD.userInteractionEnabled = YES;
    HUD.delegate = self;
    
    cellNum=0;
    tableHight=1000;
    finishloading=NO;
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.scrollEnabled=YES;
    _tableView.tableHeaderView=_headView;
    
    search = [[AMapSearchAPI alloc] initWithSearchKey: @"41f0145aa2a77c39924ee9aa0664701f" Delegate:self];
    if (_searchType==AMapSearchType_NaviDrive) {
        [self searchNaviDrive];
    }else if (_searchType==AMapSearchType_NaviBus){
        [self searchNaviBus];
    }else if (_searchType==AMapSearchType_NaviWalking){
        [self searchNaviWalk];
    }
}

/**************************驾车导航****************************/
- (void)searchNaviDrive
{
    [HUD showInView:self.view];
    AMapNavigationSearchRequest *naviRequest= [[AMapNavigationSearchRequest alloc] init];
    naviRequest.searchType = AMapSearchType_NaviDrive;
    _searchType=AMapSearchType_NaviDrive;
    naviRequest.requireExtension = YES;
    naviRequest.origin = [AMapGeoPoint locationWithLatitude:_startCoord.latitude longitude:_startCoord.longitude];
    naviRequest.destination = [AMapGeoPoint locationWithLatitude:_destinationCoord.latitude longitude:_destinationCoord.longitude];
    [search AMapNavigationSearch: naviRequest];
}

/* 公交导航搜索. */
- (void)searchNaviBus
{
    [HUD showInView:self.view];
    AMapNavigationSearchRequest *navi = [[AMapNavigationSearchRequest alloc] init];
    navi.searchType       = AMapSearchType_NaviBus;
    _searchType=AMapSearchType_NaviBus;
    navi.requireExtension = YES;
    navi.city             = @"beijing";
    
    navi.origin = [AMapGeoPoint locationWithLatitude:_startCoord.latitude longitude:_startCoord.longitude];
    navi.destination = [AMapGeoPoint locationWithLatitude:_destinationCoord.latitude longitude:_destinationCoord.longitude];
    
    [search AMapNavigationSearch:navi];
}

/* 步行导航搜索. */
- (void)searchNaviWalk
{
    [HUD showInView:self.view];
    AMapNavigationSearchRequest *navi = [[AMapNavigationSearchRequest alloc] init];
    navi.searchType= AMapSearchType_NaviWalking;
    _searchType=AMapSearchType_NaviWalking;
    navi.requireExtension = YES;
    
    navi.origin = [AMapGeoPoint locationWithLatitude:_startCoord.latitude longitude:_startCoord.longitude];
    navi.destination = [AMapGeoPoint locationWithLatitude:_destinationCoord.latitude longitude:_destinationCoord.longitude];
    
    [search AMapNavigationSearch:navi];
}

- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response
{
    [HUD dismiss];
    
    tableHight=70;
    
    /* 公交导航. */
    if (_searchType == AMapSearchType_NaviBus)
    {
        self.transits = response.route.transits;
        cellNum=response.route.transits.count;
        
    }else{
        
        self.paths=response.route.paths;
        cellNum=response.route.paths.count;
        
    }
    
    finishloading=YES;
    [_tableView reloadData];

}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (finishloading) {
        BOOL nibsRegistered = NO;
        
        static NSString *Cellidentifier=@"SRNavigationCell";
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:@"SRNavigationCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:Cellidentifier];
            nibsRegistered = YES;
        }
        
        SRNavigationCell *cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier forIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryNone;
         NSUInteger row=[indexPath row];
        
        if (_searchType == AMapSearchType_NaviBus) {
            AMapTransit* transit=[self.transits objectAtIndex:row];
            cell.naviTime.text=[NSString stringWithFormat:@"%ld分钟",transit.duration/60];
            cell.walkMeters.text=[NSString stringWithFormat:@"%ld米",transit.walkingDistance];
            NSString *s;
            if ([transit.segments count]>=3) {
                AMapSegment *seg1=[transit.segments objectAtIndex:0];
                AMapBusLine *busline1 = seg1.busline;
                AMapSegment *seg2=[transit.segments objectAtIndex:1];
                AMapBusLine *busline2 = seg2.busline;
                AMapSegment *seg3=[transit.segments objectAtIndex:2];
                AMapBusLine *busline3 = seg3.busline;
                s=[NSString stringWithFormat:@"%@—%@—%@",busline1.name,busline2.name,busline3.name];
            }
            else{
                if ([transit.segments count]==2) {
                    AMapSegment *seg1=[transit.segments objectAtIndex:0];
                    AMapBusLine *busline1 = seg1.busline;
                    AMapSegment *seg2=[transit.segments objectAtIndex:1];
                    AMapBusLine *busline2 = seg2.busline;
                    s=[NSString stringWithFormat:@"%@—%@",busline1.name,busline2.name];
                }else if ([transit.segments count]==3){
                    
                    AMapSegment *seg1=[transit.segments objectAtIndex:0];
                    AMapBusLine *busline1 = seg1.busline;

                    s=[NSString stringWithFormat:@"%@",busline1.name];
                }
            }
            cell.naviLine.text=s;
        }else{
            
        AMapPath* path=[self.paths objectAtIndex:row];
        cell.naviTime.text=[NSString stringWithFormat:@"%ld分钟",path.duration/60];
        cell.walkMeters.text=[NSString stringWithFormat:@"%ld米",path.distance];
        NSString *s;
        if ([path.steps count]>=3) {
            AMapStep *step1=[path.steps objectAtIndex:0];
            AMapStep *step2=[path.steps objectAtIndex:1];
            AMapStep *step3=[path.steps objectAtIndex:2];
            s=[NSString stringWithFormat:@"%@—%@—%@",step1.road,step2.road,step3.road];
        }else{
                if ([path.steps count]==2) {
                    AMapStep *step1=[path.steps objectAtIndex:0];
                    AMapStep *step2=[path.steps objectAtIndex:1];
                    s=[NSString stringWithFormat:@"%@—%@",step1.road,step2.road];
                }else if ([path.steps count]==3){
                    AMapStep *step1=[path.steps objectAtIndex:0];
                    s=[NSString stringWithFormat:@"%@",step1.road];
                }
        }
        
        cell.naviLine.text=s;
        }
        return cell;
    }
    else
        return nil;
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
    return tableHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SRShowRouteVC *vc=[[SRShowRouteVC alloc] init];
    vc.startCoord=_startCoord;
    vc.destinationCoord=_destinationCoord;
    
    if (_searchType == AMapSearchType_NaviBus){
        vc.polylines=[CommonUtility polylinesForTransit:[self.transits objectAtIndex:[indexPath row]]];
    }else{
    
        vc.polylines=[CommonUtility polylinesForPath:[self.paths objectAtIndex:[indexPath row]]];
    
    }
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    backItem.tintColor=[UIColor whiteColor];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)deselect
{
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    [view setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0]];
    
    return view;
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
