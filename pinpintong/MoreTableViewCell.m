//
//  MoreTableViewCell.m
//  pinpintong
//
//  Created by Bruce He on 15-4-15.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MoreTableViewCell.h"

@implementation MoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.bounds = CGRectMake(10, 8, 44, 44);
    self.imageView.frame = CGRectMake(10, 8, 44, 44);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = 62;
    self.textLabel.frame = tmpFrame;
    
    
    tmpFrame = self.detailTextLabel.frame;
    tmpFrame.origin.x = 62;
    self.detailTextLabel.frame = tmpFrame;
    self.detailTextLabel.textColor = [UIColor grayColor];
}

@end
