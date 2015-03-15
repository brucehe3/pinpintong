//
//  FirstViewController.h
//  pinpintong
//
//  Created by Bruce He on 15-3-14.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"


@interface MixViewController :
    UIViewController <
    MKHorizMenuDataSource,
    MKHorizMenuDelegate, UITableViewDataSource> {

    MKHorizMenu *_horizMenu;
    NSMutableArray *_items;
        
    NSMutableArray *_categories;
    NSMutableArray *_dataList;
    
    //UILabel *_selectionItemLabel;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,retain) IBOutlet MKHorizMenu *horizMenu;
@property (nonatomic,retain) NSMutableArray *items;

@property (nonatomic, assign) IBOutlet UILabel *selectionItemLabel;

@property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic, retain) NSMutableArray *dataList;

@end

