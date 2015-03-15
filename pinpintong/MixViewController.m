//
//  FirstViewController.m
//  pinpintong
//
//  Created by Bruce He on 15-3-14.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MixViewController.h"
#import "AFNetworkTool.h"
#import "common.h"


@implementation MixViewController

@synthesize horizMenu = _horizMenu;
@synthesize items = _items;
@synthesize selectionItemLabel = _selectionItemLabel;
@synthesize categories = _categories;
@synthesize dataList = _dataList;




- (void)viewDidLoad {
    
    
    //self.items = [NSMutableArray arrayWithObjects:@"拼箱",@"外派",@"International",@"Radio",@"Hollywood",@"Sports",@"Others",nil];
    
    
    //[self.horizMenu reloadData];
    
    [super viewDidLoad];
    
    [self getCategoryData];
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
    
}

-(void) getCategoryData
{
 
    if([self categories] == nil)
    {
        NSString *url = @"http://trailer.s10.baiwei.org/default/default/api/getCategoryByType?type=lcl&123";
        [AFNetworkTool JSONDataWithUrl:url success:^(id json) {
            //NSLog(@"%@", json);
            
            NSString *result = [json objectForKey: @"result"];
            if ( [result  isEqual: @"ok"] ){
                
                self.categories = [json objectForKey:@"data"];
                
                NSMutableArray * rows = [[NSMutableArray alloc] init];
                
                for (int i = 0; i< [[self categories] count]; i ++) {
                    NSDictionary * row;
                    row = [[self categories] objectAtIndex:i];
                    
                    [rows addObject: [row objectForKey:@"name"]];
                    
                }
                
                if (rows != nil){
                    self.items = rows;
                    [self.horizMenu reloadData];
                    [self.horizMenu setSelectedIndex:1 animated:YES];
                    
                    
                }
                
            }

            // 提示:NSURLConnection异步方法回调,是在子线程
            // 得到回调之后,通常更新UI,是在主线程
            //        NSLog(@"%@", [NSThread currentThread]);
        } fail:^{
            NSLog(@"请求失败");
        }];
    }
}

- (void) getTableViewDataByCid:(NSInteger)cid  page:(NSInteger)page  page_size:(NSInteger)page_size
{
    NSString *url = [NSString stringWithFormat:@"http://trailer.s10.baiwei.org/default/default/api/getlcldatabycid?cid=%ld&page=%ld&page_size=%ld",cid, page,page_size];

    [AFNetworkTool JSONDataWithUrl:url success:^(id json) {
        
        NSString *result = [json objectForKey: @"result"];
      
        if ( [result  isEqual: @"ok"] ){
            NSArray * data = [[NSArray alloc] init];
            data = [json objectForKey:@"data"];
            //NSLog(@"%@",[json objectForKey:@"data"]);
            self.dataList = [[NSMutableArray alloc] init];
            [self.dataList addObjectsFromArray:data];
            NSLog(@"%@",self.dataList);
            //[[self dataList] initWithArray:[json objectForKey:@"data"]];
            [self.tableView reloadData];
            //self.categories = [json objectForKey:@"data"];
            
        }
        
        // 提示:NSURLConnection异步方法回调,是在子线程
        // 得到回调之后,通常更新UI,是在主线程
        //        NSLog(@"%@", [NSThread currentThread]);
    } fail:^{
        NSLog(@"请求失败");
    }];
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
    NSDictionary * row;
    row = [self.categories objectAtIndex:index];
    NSInteger cid = [[row objectForKey:@"tid"] integerValue];
    
    [self getTableViewDataByCid:cid page:1 page_size:20];
    //NSLog(@"%@",[row objectForKey:@"tid"]);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    UILabel *label = [UILabel alloc];
    label = (UILabel *) [cell viewWithTag:1];
    label.text = @"1111";
    return cell;
}

@end