//
//  SROfferARewardDetailTableViewCell.m
//  DaZhe
//
//  Created by Mac on 11/8/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "SROfferARewardDetailTableViewCell.h"

@implementation SROfferARewardDetailTableViewCell
-(void)dataInit:(RewardEvaluation *)data
{
    //cell view状态初始化
    self.responeLabelUnchanged.hidden=YES;
    self.toUsrNickName.hidden=YES;
    //拼接cell显示的内容
    //显示图片
    if(data.evaluationMemberLogoURL!=nil ||[data.evaluationMemberLogoURL isEqualToString:@""]){
        NSData *imageData=[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:data.evaluationMemberLogoURL]];
        self.conmenterImage.image=[UIImage imageWithData:imageData];
    }
    else
    {
        self.conmenterImage.image=[UIImage imageNamed:@"appicon_120.png"];
    }
    //设置评论人的名字
    if(data.evaluationMemberAccount){
        self.conmenterNickName.text=data.evaluationMemberAccount;
    }else{
        self.conmenterNickName.text=data.evaluationMemberName;
    }
    //设置时间
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc ]init];
    [dateFormatter setDateFormat:@"MM/dd HH:mm"];
    
    self.conmentTime.text=[dateFormatter stringFromDate:data.updatedAt];
    //设置被评论人
    if(self.isResponeMsg || data.evaluationRewardPointer)
    {//判断是不是回复评论,如果是
        self.responeLabelUnchanged.hidden=NO;
        self.toUsrNickName.text=data.evaluationRewardPointer;
        self.toUsrNickName.hidden=NO;
    }
    self.commentContent.text=data.evaluationContent;
}

- (void)awakeFromNib
{
    // Initialization code
    
}


//根据内容 自适应高度
-(void)setHeightAutomaticalyAccordingToContent
{
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
