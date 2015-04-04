//
//  MixTableViewFrame.h
//  pinpintong
//
//  Created by Bruce He on 15-4-4.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MixTableViewFrame : NSObject

//内容区域
@property (nonatomic, assign) CGRect contentF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NSDictionary *data;

@end