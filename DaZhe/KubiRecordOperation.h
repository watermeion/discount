//
//  KubiRecordOperation.h
//  DaZhe
//
//  Created by Mac on 11/25/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "InteractionWithCloud.h"
#import "KubeDetail.h"

@protocol KubeFeeOperationDelagate <NSObject>

-(void)updateUsrKubeFeeWhenGetData;
-(void)updateKuBiFeeDetailWhenGetData;
-(void)usrUnloginAction;

@end

@interface KubiRecordOperation : InteractionWithCloud

@property (nonatomic,weak)id<KubeFeeOperationDelagate> delegate;

@property(nonatomic,strong)NSMutableDictionary *resultsDict;

@property(nonatomic,strong)NSString *usrKubiFee;



-(void)queryKubiRecordFromAVOS:(NSUInteger) pageNum;
-(void)queryUsrHasKubeFee;
-(void)receiveKubiRecordData:(NSArray *) objects;
@end
