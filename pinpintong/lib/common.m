//
//  common.m
//  pinpintong
//
//  Created by Bruce on 15-3-15.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "common.h"

@implementation BWCommon 

+ (NSDictionary *) dictionaryWithJsonString:(NSString *) jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end