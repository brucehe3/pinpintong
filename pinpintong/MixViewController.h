//
//  FirstViewController.h
//  pinpintong
//
//  Created by Bruce He on 15-3-14.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"
#import "DetailDelegate.h"


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
        
    __unsafe_unretained id<DetailDelegate> delegate;
}

@property (nonatomic,retain) IBOutlet MKHorizMenu *horizMenu;
@property (nonatomic,retain) NSMutableArray *items;
@property (nonatomic,retain) NSMutableArray *itemsKeys;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,assign) id<DetailDelegate> delegate;


@end

