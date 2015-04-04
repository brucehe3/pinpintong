//
//  MixTableViewFrame.m
//  pinpintong
//
//  Created by Bruce He on 15-4-4.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MixTableViewFrame.h"

#define NJNameFont [UIFont systemFontOfSize:15]
#define NJTextFont [UIFont systemFontOfSize:16]


@implementation MixTableViewFrame


- (void)setData:(NSDictionary *) data{
    _data = data;
    
    CGFloat padding = 10;
    CGFloat contentX = padding;
    CGFloat contentY = padding;
    CGSize contentSize = [self sizeWithString: [_data objectForKey:@"content"] font:NJTextFont maxSize:CGSizeMake(300, MAXFLOAT)];
    CGFloat contentW = contentSize.width;
    CGFloat contentH = contentSize.height;
    
    self.contentF = CGRectMake(contentX, contentY, contentW, contentH);
    
    CGFloat nameX = padding;
    CGFloat nameY = contentY+contentH+padding;
    CGSize nameSize = [self sizeWithString:[_data objectForKey:@"username"] font:NJNameFont maxSize:CGSizeMake(100, MAXFLOAT)];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    self.cellHeight = CGRectGetMaxY(self.contentF) + nameH + padding * 2;
    
    //self.cellHeight =CGRectGetMaxY(self.contentF) +padding;
    
    
}


/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

@end
