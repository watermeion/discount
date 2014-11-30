//
//  CommentListViewOperation.h
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "InteractionWithCloud.h"

@protocol CommentListViewOperationDelegate <NSObject>
-(void)usrUnloginAction;
-(void)updateCellView;

@end
@interface CommentListViewOperation : InteractionWithCloud


@property(nonatomic,weak)id<CommentListViewOperationDelegate> delegate;

@property(nonatomic,strong)NSMutableDictionary *resultsDict;

-(void)queryCommentsFromAVOS:(NSUInteger) pageNum;

-(void)receiveData:(NSArray *) objects;

-(UIImage *)requestImage:(NSString*) url;






@end
