//
//  SecondViewController.h
//  pinpintong
//
//  Created by Bruce He on 15-3-14.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailDelegate.h"
#import "MBProgressHUD.h"

@interface DeliveryViewController : UIViewController
<
UIPickerViewDelegate,
UIPickerViewDataSource,
UITableViewDataSource,
UITableViewDelegate>


@property (nonatomic,strong) UITextField *keyword;
@property (nonatomic,strong) UITextField *departureArea;
@property (nonatomic,strong) UITextField *destinationArea;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,assign) id<DetailDelegate> delegate;
@property (nonatomic,retain) NSMutableArray *dataArray;

@end

