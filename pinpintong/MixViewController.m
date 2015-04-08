//
//  FirstViewController.m
//  pinpintong
//
//  Created by Bruce He on 15-3-14.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MixViewController.h"
#import "AFNetworkTool.h"
#import "BWCommon.h"
#import "MixTableViewCell.h"
#import "MixTableViewFrame.h"
#import "MixDetailViewController.h"
#import "MJRefresh.h"



@interface MixViewController()

@property (nonatomic, strong) NSArray *statusFrames;
@property (nonatomic, assign) NSUInteger tid;
@property (nonatomic,assign) NSUInteger gpage;

@end

@implementation MixViewController

@synthesize horizMenu = _horizMenu;
@synthesize items = _items;
@synthesize itemsKeys = _itemsKeys;
@synthesize tableview;
@synthesize dataArray;
@synthesize delegate;


- (void)viewDidLoad {
    
    NSString *api_url = [BWCommon getBaseInfo:@"api_url"];

    NSString *url =  [api_url stringByAppendingString:@"getCategoryByType?type=lcl"];

    [AFNetworkTool JSONDataWithUrl:url success:^(id json) {
        
        
        NSString *result = [json objectForKey:@"result"];
        
        if([result  isEqual:@"ok"])
        {
            
            NSArray *data = [[NSArray alloc] init];
            data = [json objectForKey:@"data"];
            
            NSMutableArray *itemsData = [[NSMutableArray alloc] init];
            self.itemsKeys = [[NSMutableArray alloc] init];
            
            NSInteger dataCount = [data count];
            
            for(int i = 0 ; i < dataCount; i ++)
            {
                [itemsData addObject:[[data objectAtIndex:i] objectForKey:@"name"]];
                [[self itemsKeys] addObject:[[data objectAtIndex:i] objectForKey:@"tid"]];
            }
            
            self.items = itemsData;
            [self.horizMenu reloadData];
  
            [self.horizMenu setSelectedIndex:0 animated:YES];
    
            NSLog(@"%@",itemsData);
        }
        
        // 提示:NSURLConnection异步方法回调,是在子线程
        // 得到回调之后,通常更新UI,是在主线程
        //        NSLog(@"%@", [NSThread currentThread]);
    } fail:^{
        NSLog(@"请求失败");
    }];

    
    //指定委派的为自己
    self.horizMenu.itemSelectedDelegate = self;
    
    //初始化view
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, size.width, size.height-150)];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    //self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, size.width, size.height-150)];
    //self.tableview.scrollEnabled = YES;
    //self.tableview.bounces = YES;
    //self.tableview.pagingEnabled = YES;
    //self.tableview.delegate = self;
    //self.tableview.userInteractionEnabled = YES;
    //self.tableview.showsHorizontalScrollIndicator = NO;
    //self.tableview.contentSize =CGSizeMake(size.width, size.height);
    [[self view]addSubview:tableview];
    

    [self.tableview addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    
    [self.tableview addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) headerRefreshing{
    
    self.gpage = 1;
    [self refreshingData:1 callback:^{
        [self.tableview.header endRefreshing];
    }];
    
}

- (void )footerRereshing{

    [self refreshingData:++self.gpage callback:^{
        [self.tableview.footer endRefreshing];
    }];
}

- (void) refreshingData:(NSUInteger)page callback:(void(^)()) callback
{
    NSString *api_url = [BWCommon getBaseInfo:@"api_url"];
    NSString *list_url = [api_url stringByAppendingString:@"GetLclDataByCid"];
    list_url = [list_url stringByAppendingFormat:@"?cid=%d&page=%d&page_size=10",self.tid,page];
    
    NSLog(@"%@",list_url);
    //load data
    [AFNetworkTool JSONDataWithUrl:list_url success:^(id json) {
        
        
        NSString *result = [json objectForKey:@"result"];
        
        if([result  isEqual:@"ok"])
        {
            
            //NSArray *data = [[NSArray alloc] init];
            if(page == 1)
            {
                dataArray = [[json objectForKey:@"data"] mutableCopy];
            }
            else
            {
                [dataArray addObjectsFromArray:[[json objectForKey:@"data"] mutableCopy]];
                
            }

            self.statusFrames = nil;
            
            [tableview reloadData];
            
            if(callback){
                callback();
            }
            
            //NSLog(@"%@",json);
        }
        else
        {
            NSLog(@"%@",[json objectForKey:@"msg"]);
        }
        
    } fail:^{
        NSLog(@"请求失败");
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload
{
    [super viewDidLoad];
    
    //self.selectionItemLabel = nil;
}

-(void) viewDidAppear:(BOOL)animated
{
    
}

//- (void) dealloc
//{
//[super dealloc];
//}

- (UIImage *) selectedItemImageForMenu:(MKHorizMenu *) tabMenu
{
    return [[UIImage imageNamed:@"button-selected"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
}

- (UIColor*) backgroundColorForMenu:(MKHorizMenu *)tabView
{
    return [UIColor whiteColor];
    //return [UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBar"]];
}

- (int) numberOfItemsForMenu:(MKHorizMenu *)tabView
{

    return (int)[self.items count];
}

- (NSString*) horizMenu:(MKHorizMenu *)horizMenu titleForItemAtIndex:(NSUInteger)index
{
 
    return [self.items objectAtIndex:index];
}

- (void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index
{
    self.tid = [[self.itemsKeys objectAtIndex:index] integerValue];
    
    self.gpage = 1;
    [self refreshingData:1 callback:nil];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

/* 这个函数是指定显示多少cells*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self dataArray] count];//这个是指定加载数据的多少即显示多少个cell，如果这个地方弄错了会崩溃的哟
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MixTableViewCell *cell = [MixTableViewCell cellWithTableView:tableview];
    
    cell.viewFrame = self.statusFrames[indexPath.row];
    
    //cell.textLabel.text = [[dataArray objectAtIndex:[indexPath row]] objectForKey:@"content"];
    //cell.textLabel.text = [dataArray objectAtIndex:[indexPathrow]];  //通过 [indexPath row] 遍历数组
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"heightForRowAtIndexPath");
    // 取出对应航的frame模型
    MixTableViewFrame *vf = self.statusFrames[indexPath.row];
    NSLog(@"height = %f", vf.cellHeight);
    return vf.cellHeight;
}

- (NSArray *)statusFrames
{
    if (_statusFrames == nil) {
        
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dataArray.count];
        
        for (NSDictionary *dict in dataArray) {
            // 创建模型
            MixTableViewFrame *vf = [[MixTableViewFrame alloc] init];
            vf.data = dict;
            [models addObject:vf];
        }
        self.statusFrames = [models copy];
    }
    return _statusFrames;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger detail_id;
    detail_id = [[[dataArray objectAtIndex:[indexPath row]] objectForKey:@"id"] integerValue];
    
    MixDetailViewController *detailViewController = [[MixDetailViewController alloc] init];
    
    detailViewController.hidesBottomBarWhenPushed = YES;
    self.delegate = detailViewController;

    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [self.delegate setValue:detail_id];

}
@end