//
//  SellerInfoOperation.h
//  DaZhe
//
//  Created by Mac on 11/15/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "InteractionWithCloud.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SellerInfoDataModel.h"
@interface SellerInfoOperation : InteractionWithCloud

@property(nonatomic,strong)SellerInfoDataModel *sellerInfoData;

-(void)requestToAVOS:(NSString *)classname ID:(NSString *)Id Key:(NSString*)kword PageNumber:(NSUInteger)pagenumber Count:(NSUInteger) countNumber;
-(void)receiveData:(NSArray*) objs;

@end
