//
//  DiscoveryViewController.m
//  pinpintong
//
//  Created by Bruce on 15-4-8.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "DiscoveryViewController.h"

@interface DiscoveryViewController ()



@end

@implementation DiscoveryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) layoutPage{
    
    [[self navigationItem] setTitle:@"发现"];
    [[[self navigationController] navigationBar] setTintColor:[UIColor whiteColor]];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    UIScrollView *sclView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height-46.0f)];
    sclView.backgroundColor = [UIColor colorWithRed:200/255.5f green:200/255.5f blue:200/255.5f alpha:1];
    sclView.scrollEnabled = YES;
    sclView.contentSize = CGSizeMake(size.width, size.height);
    [self.view addSubview:sclView];
    
    UIView *firstRow = [[UIView alloc] initWithFrame:CGRectMake(0, 10, size.width, 50)];
    firstRow.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstRow];
    
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
