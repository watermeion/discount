//
//  DiscountRecordOperation.h
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "InteractionWithCloud.h"


@protocol DiscountRecordOperationDelegate <NSObject>

-(void)usrUnloginAction;
-(void)updateCellView;


@end
@interface DiscountRecordOperation : InteractionWithCloud
@property (nonatomic,weak)id<DiscountRecordOperationDelegate> delegate;
@property(nonatomic,strong)NSMutableDictionary *resultsDict;

-(void)queryDiscountRecordFromAVOS:(NSUInteger) pageNum;
//-(void)queryUsrHasKubeFee;
-(void)receiveData:(NSArray *) objects;

-(UIImage *)requestImage:(NSString*) url;

@end
