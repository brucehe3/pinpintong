//
//  FirstViewController.m
//  pinpintong
//
//  Created by Bruce He on 15-3-14.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MixViewController.h"
#import "AFNetworkTool.h"


@implementation MixViewController

@synthesize horizMenu = _horizMenu;
@synthesize items = _items;
@synthesize selectionItemLabel = _selectionItemLabel;


- (void)viewDidLoad {
    
    NSString *url = @"http://trailer.s10.baiwei.org/default/default/api/getCategoryByType?type=lcl";
    [AFNetworkTool JSONDataWithUrl:url success:^(id json) {
        NSLog(@"%@", json);

        // 提示:NSURLConnection异步方法回调,是在子线程
        // 得到回调之后,通常更新UI,是在主线程
        //        NSLog(@"%@", [NSThread currentThread]);
    } fail:^{
        NSLog(@"请求失败");
    }];
    
    self.items = [NSMutableArray arrayWithObjects:@"拼箱",@"外派",@"International",@"Radio",@"Hollywood",@"Sports",@"Others",nil];
    
    
    [self.horizMenu reloadData];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidLoad];
    
    self.selectionItemLabel = nil;
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.horizMenu setSelectedIndex:1 animated:YES];
}

//- (void) dealloc
//{
//[super dealloc];
//}

- (UIImage *) selectedItemImageForMenu:(MKHorizMenu *) tabMenu
{
    return [[UIImage imageNamed:@"ButtonSelected"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
}

- (UIColor*) backgroundColorForMenu:(MKHorizMenu *)tabView
{
    return [UIColor whiteColor];
    //return [UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBar"]];
}

- (int) numberOfItemsForMenu:(MKHorizMenu *)tabView
{
    return [self.items count];
}

- (NSString*) horizMenu:(MKHorizMenu *)horizMenu titleForItemAtIndex:(NSUInteger)index
{
    return [self.items objectAtIndex:index];
}

#pragma mark -
#pragma mark HorizMenu Delegate
- (void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index
{
    //self.selectionItemLabel.text = [self.items objectAtIndex:index];
}

@end