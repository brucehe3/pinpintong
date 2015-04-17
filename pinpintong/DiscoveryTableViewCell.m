//
//  DiscoveryTableViewCell.m
//  pinpintong
//
//  Created by Bruce He on 15-4-17.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "DiscoveryTableViewCell.h"

@implementation DiscoveryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.bounds = CGRectMake(25, 5, 36, 36);
    self.imageView.frame = CGRectMake(25, 5, 36, 36);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = 70;
    self.textLabel.frame = tmpFrame;
    

}

@end
