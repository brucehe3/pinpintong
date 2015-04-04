//
//  MixTableViewCell.h
//  pinpintong
//
//  Created by Bruce He on 15-4-4.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MixTableViewFrame;

@interface MixTableViewCell : UITableViewCell


@property (nonatomic,strong) MixTableViewFrame *viewFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
