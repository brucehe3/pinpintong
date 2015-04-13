//
//  MixPublishViewController.h
//  pinpintong
//
//  Created by Bruce He on 15-4-11.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceholderTextView.h"
#import "MBProgressHUD.h"

@interface MixPublishViewController : UIViewController
<UITextViewDelegate,
UIPickerViewDelegate,
UIPickerViewDataSource,
UITextFieldDelegate,
MBProgressHUDDelegate>
{
    MBProgressHUD * hud;
}

@property (nonatomic,strong) UIPlaceholderTextView *content;
@property (nonatomic,strong) UITextField *category;

@property (nonatomic,retain) NSMutableArray *items;
@property (nonatomic,retain) NSMutableArray *itemsKeys;

@end
