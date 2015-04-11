//
//  MixPublishViewController.h
//  pinpintong
//
//  Created by Bruce He on 15-4-11.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MixPublishViewController : UIViewController
<UITextViewDelegate,
UIPickerViewDelegate,
UIPickerViewDataSource
>


@property (nonatomic,strong) UITextView *content;
@property (nonatomic,strong) UITextField *category;
@end
