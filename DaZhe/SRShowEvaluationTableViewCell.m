//
//  SRShowEvaluationTableViewCell.m
//  DaZhe
//
//  Created by Mac on 11/19/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "SRShowEvaluationTableViewCell.h"

@implementation SRShowEvaluationTableViewCell

-(void)initFromData:(ShowEvaluationDataModel *)data
{
    self.usrImageView.image=data.usrLogo;
    self.userEvaluationContentLabel.text=data.usrComment;
    self.usrNameLabel.text=data.usrName;
    self.commentTimeLabel.text=data.time;
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
