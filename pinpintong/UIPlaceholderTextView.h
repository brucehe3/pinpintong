//
//  UIPlaceholderTextView.h
//  pinpintong
//
//  Created by Bruce He on 15-4-13.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceholderTextView : UITextView

@property(nonatomic, strong) NSString *placeholder;     //占位符

-(void)addObserver;//添加通知
-(void)removeobserver;//移除通知
@end