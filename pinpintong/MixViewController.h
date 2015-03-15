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
    MKHorizMenuDelegate> {

    MKHorizMenu *_horizMenu;
    NSMutableArray *_items;
    
    //UILabel *_selectionItemLabel;
}

@property (nonatomic,retain) IBOutlet MKHorizMenu *horizMenu;
@property (nonatomic,retain) NSMutableArray *items;

@property (nonatomic, assign) IBOutlet UILabel *selectionItemLabel;

@end

