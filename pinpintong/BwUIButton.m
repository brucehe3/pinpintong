//
//  BwUIButton.m
//  pinpintong
//
//  Created by Bruce on 15-4-7.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "BwUIButton.h"

@implementation BwUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id) init
{
    self = [super init];
    
    if (self) {
        
        //可根据自己的需要随意调整
        
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        self.titleLabel.font=[UIFont systemFontOfSize:12.0];
        
        self.imageView.contentMode=UIViewContentModeTop;
        
    }
    
    return self;

}


//根据button的rect设定并返回文本label的rect

- (CGRect)titleRectForContentRect:(CGRect)contentRect

{
    
    CGFloat titleW = contentRect.size.width-30;
    
    CGFloat titleH = contentRect.size.height;
    
    CGFloat titleX = 0;
    
    CGFloat titleY = 0;
    
    
    
    contentRect = (CGRect){{titleX,titleY},{titleW,titleH}};
    
    return contentRect;
    
}



//更具button的rect设定并返回UIImageView的rect

- (CGRect)imageRectForContentRect:(CGRect)contentRect

{
    
    CGFloat imageW = 25;
    
    CGFloat imageH = 25;
    
    CGFloat imageX = contentRect.size.width-26;
    
    CGFloat imageY = 2.5;
    
    
    
    contentRect = (CGRect){{imageX,imageY},{imageW,imageH}};
    
    return contentRect;
    
}

@end
