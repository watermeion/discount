//
//  DiscountRecordOperation.m
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "DiscountRecordOperation.h"
#import "DiscountRecord.h"
@implementation DiscountRecordOperation

-(NSMutableDictionary *)resultsDict
{
    if (!_resultsDict) {
        _resultsDict=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return _resultsDict;
    
}


-(void)queryDiscountRecordFromAVOS:(NSUInteger) pageNum
{
    if ([self usrLoginCheck]) {
        AVQuery *query=[AVQuery queryWithClassName:[DiscountRecord parseClassName]];
        query.limit=20;
        query.skip=20*pageNum;
        query.cachePolicy=kPFCachePolicyNetworkElseCache;
        [query orderByDescending:@"updatedAt"];
        [query whereKey:@"discountMemberObjectID" equalTo:[AVUser currentUser].objectId];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error==nil && [objects count]!=0) {
                
                [self receiveData:objects];
                
            }
            else
            {
                [self handleError];
            }
        }];
    }else
    {
       [self.delegate usrUnloginAction];
    }
   

}
//-(void)queryUsrHasKubeFee;
-(void)receiveData:(NSArray *) objects
{
    for (DiscountRecord *obj in objects) {
        [self.resultsDict setObject:obj forKey:obj.objectId];
    }
    [self.delegate  updateCellView];
}


-(UIImage *)requestImage:(NSString*) url
{
    if (url!=nil) {
         NSURL *URL=[[NSURL alloc]initWithString:url];
         NSData *imageData=[NSData dataWithContentsOfURL:URL];
         UIImage *image=[UIImage imageWithData:imageData];
        if (imageData!=nil && image!=nil) {
            return image;
        }
    }
    return [UIImage imageNamed:@"appicon_58.png"];

}


@end
