//
//  UserInfoTableViewController.h
//  pinpintong
//
//  Created by Bruce He on 15-4-15.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoDelegate.h"

@interface UserInfoTableViewController : UITableViewController

@property (nonatomic,assign) id<UserInfoDelegate> delegate;
@end
