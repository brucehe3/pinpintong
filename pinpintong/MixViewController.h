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
    MKHorizMenuDelegate,
    UITableViewDataSource,
    UITableViewDelegate> {

    MKHorizMenu *_horizMenu;
    NSMutableArray *_items;
    NSMutableArray *_itemsKeys;
    UITableView *tableview;
    
    NSMutableArray *dataArray; //创建个数组来放我们的数据
    
    //UILabel *_selectionItemLabel;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,retain) IBOutlet MKHorizMenu *horizMenu;
@property (nonatomic,retain) NSMutableArray *items;
@property (nonatomic,retain) NSMutableArray *itemsKeys;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,retain) NSMutableArray *dataArray;

@property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic, retain) NSMutableArray *dataList;

@end

