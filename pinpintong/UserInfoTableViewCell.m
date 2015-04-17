//
//  UserInfoTableViewCell.m
//  pinpintong
//
//  Created by Bruce He on 15-4-17.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    CGRect tmpFrame = self.textLabel.frame;
    //tmpFrame.origin.x = 62;
    //self.textLabel.frame = tmpFrame;
    
    
    tmpFrame = self.detailTextLabel.frame;
    tmpFrame.origin.x = 62;
    self.detailTextLabel.frame = tmpFrame;
    self.detailTextLabel.textColor = [UIColor grayColor];
}


@end
