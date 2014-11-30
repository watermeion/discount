//
//  CommentListViewOperation.m
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "CommentListViewOperation.h"
#import "Evaluation.h"

@implementation CommentListViewOperation


-(void)queryCommentsFromAVOS:(NSUInteger) pageNum
{
    if ([self usrLoginCheck]) {
        AVQuery *query=[AVQuery queryWithClassName:[Evaluation parseClassName]];
        query.limit=20;
        query.skip=20*pageNum;
        query.cachePolicy=kPFCachePolicyNetworkElseCache;
        [query orderByDescending:@"updatedAt"];
        [query whereKey:@"evaluationMemberObjectID" equalTo:[AVUser currentUser].objectId];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error==nil) {
                [self receiveData:objects];
            }
            else {
            
                [self handleError];
            }
            
            
        }];
        
    }
    else
    {
    
        [self.delegate usrUnloginAction];
    }
}



-(void)receiveData:(NSArray *) objects
{
    for (Evaluation *obj in objects) {
        [self.resultsDict setObject:obj forKey:obj.objectId];
    }
    [self.delegate  updateCellView];
}


-(UIImage *)requestImage:(NSString*) url
{
    if (url!=nil) {
        NSURL *URL=[[NSURL alloc]initWithString:url];
        NSData *imageData=[NSData dataWithContentsOfURL:url];
        UIImage *image=[UIImage imageWithData:imageData];
        if (imageData!=nil && image!=nil) {
            return image;
        }
    }
    return [UIImage imageNamed:@"appicon_58.png"];
}

@end
