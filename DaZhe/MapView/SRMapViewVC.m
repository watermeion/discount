//
//  SRMapViewVC.m
//  DaZhe
//
//  Created by RAY on 14/11/26.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRMapViewVC.h"
#import "SRNavigationDetail.h"

@interface SRMapViewVC ()

@end

@implementation SRMapViewVC
@synthesize mapView=_mapView;
@synthesize sellerCoord=_sellerCoord;
@synthesize sellerTitle=_sellerTitle;
@synthesize currentCoord=_currentCoord;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self KeyCheck];
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
    [self.view addSubview:_mapView];
    _mapView.userInteractionEnabled=YES;
    _mapView.delegate = self;
    
    MAPointAnnotation *sellerPoint = [[MAPointAnnotation alloc] init];
    sellerPoint.coordinate = _sellerCoord;
    sellerPoint.title  = _sellerTitle;
    [_mapView addAnnotation:sellerPoint];
    
    _mapView.region = MACoordinateRegionMake(_sellerCoord,MACoordinateSpanMake(0.005, 0.005));
    
    [_mapView setShowsUserLocation:YES];
   
    // fix ios8 location issue
    locationManager =[[CLLocationManager alloc] init];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
#ifdef __IPHONE_8_0
        if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [locationManager performSelector:@selector(requestAlwaysAuthorization)];//用这个方法，plist中需要NSLocationAlwaysUsageDescription
        }
        
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [locationManager performSelector:@selector(requestWhenInUseAuthorization)];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
        }
#endif
    }
    
    //_currentCoord=CLLocationCoordinate2DMake(39.910267, 116.370888);
    _sellerCoord=CLLocationCoordinate2DMake(39.989872, 116.481956);
}

- (void)KeyCheck{
    [MAMapServices sharedServices].apiKey =@"41f0145aa2a77c39924ee9aa0664701f";
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString* reuseIdentifier = @"annotation";
        
        MAPinAnnotationView* newAnnotation = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        
        
        newAnnotation.pinColor = MAPinAnnotationColorRed;
        newAnnotation.animatesDrop = YES;
        newAnnotation.canShowCallout = YES;
        
        return newAnnotation;
    }
    return nil;
}


/**************************定位功能****************************/
-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    _currentCoord=[_mapView userLocation].coordinate;
    gotLocation=YES;

}

-(void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"fail to update location");
}


- (IBAction)bus:(id)sender {
    if (gotLocation) {
        SRNavigationDetail *navDetailVC=[[SRNavigationDetail alloc]init];
        navDetailVC.startCoord=_currentCoord;
        navDetailVC.destinationCoord=_sellerCoord;
        navDetailVC.searchType=AMapSearchType_NaviBus;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"";
        backItem.tintColor=[UIColor whiteColor];
        self.navigationItem.backBarButtonItem = backItem;
        
        [self.navigationController pushViewController:navDetailVC animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"对不起，暂时不能获取您的定位信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.delegate=self;
        [alert show];
    }
}
- (IBAction)drive:(id)sender {
    if (gotLocation) {
        SRNavigationDetail *navDetailVC=[[SRNavigationDetail alloc]init];
        navDetailVC.startCoord=_currentCoord;
        navDetailVC.destinationCoord=_sellerCoord;
        navDetailVC.searchType=AMapSearchType_NaviDrive;
        [self.navigationController pushViewController:navDetailVC animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"对不起，暂时不能获取您的定位信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.delegate=self;
        [alert show];
    }
}
- (IBAction)walk:(id)sender {
    if (gotLocation) {
        SRNavigationDetail *navDetailVC=[[SRNavigationDetail alloc]init];
        navDetailVC.startCoord=_currentCoord;
        navDetailVC.destinationCoord=_sellerCoord;
        navDetailVC.searchType=AMapSearchType_NaviWalking;
        [self.navigationController pushViewController:navDetailVC animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"对不起，暂时不能获取您的定位信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.delegate=self;
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

@end
