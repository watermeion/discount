//
//  CommentsListViewTableViewController.h
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentListViewOperation.h"
@interface CommentsListViewTableViewController : UITableViewController<CommentListViewOperationDelegate>


@property(nonatomic,strong)CommentListViewOperation *businessLayer;
@end
