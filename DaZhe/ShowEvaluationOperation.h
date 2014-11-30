//
//  ShowEvaluationOperation.h
//  DaZhe
//
//  Created by Mac on 11/19/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractionWithCloud.h"
#import "Evaluation.h"
@interface ShowEvaluationOperation : InteractionWithCloud

//保存数据
@property (nonatomic,strong)NSMutableDictionary *evaluationDict;
@property(nonatomic,strong)NSString *sellerObjectId;

-(void)requestDataFromAVOS:(NSUInteger)pageNum;

-(void)receiveData:(NSArray *)objects;

@end
