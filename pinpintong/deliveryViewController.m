//
//  SecondViewController.m
//  pinpintong
//
//  Created by Bruce He on 15-3-14.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "DeliveryViewController.h"
#import "BWCommon.h"
#import "AFNetworkTool.h"
#import "MixTableViewCell.h"
#import "MixTableViewFrame.h"
#import "MJRefresh.h"


@interface DeliveryViewController ()
- (UIButton*) createButton:(id)target Selector:(SEL)selector Image:(NSString *)image Title:(NSString *) title;

@property (nonatomic,retain) NSMutableArray *province;
@property (nonatomic,retain) NSMutableArray *provinceKey;
@property (nonatomic,retain) NSMutableArray *city;
@property (nonatomic,retain) NSMutableArray *cityKey;
@property (nonatomic,retain) NSString *selectedProvince;
@property (nonatomic,retain) NSString *selectedCity;

@property (nonatomic, strong) NSArray *statusFrames;

@property (nonatomic, assign) NSUInteger selectedProvinceId;
@property (nonatomic, assign) NSUInteger selectedCityId;

@property (nonatomic, assign) NSUInteger fpid;
@property (nonatomic, assign) NSUInteger fcid;
@property (nonatomic, assign) NSUInteger tpid;
@property (nonatomic, assign) NSUInteger tcid;

@property (nonatomic, assign) NSUInteger cid;

@property (nonatomic, assign) NSUInteger gpage;

@end

@implementation DeliveryViewController

@synthesize tableview;
@synthesize delegate;
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self layoutPage];
    
    [self loadRegion];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutPage{
    
    self.province = [[NSMutableArray alloc] init];
    self.provinceKey = [[NSMutableArray alloc] init];
    self.city = [[NSMutableArray alloc] init];
    self.cityKey = [[NSMutableArray alloc] init];
    self.selectedProvince = [[NSString alloc] init];
    self.selectedCity = [[NSString alloc] init];
    
    self.gpage = 1;
    self.cid = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[self navigationItem] setTitle:@"长途配货"];
    [[[self navigationController] navigationBar] setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *barLine = [[UIBarButtonItem alloc] init];
    barLine.title = @"常跑路线";
    [barLine setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.0f],NSFontAttributeName,nil] forState:UIControlStateNormal];
    

    [[self navigationItem] setRightBarButtonItem:barLine];
    
   // self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化view
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    //UIScrollView *sclView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 110, size.width, size.height)];
    //sclView.backgroundColor = [UIColor colorWithRed:200/255.5f green:200/255.5f blue:200/255.5f alpha:1];
    //sclView.scrollEnabled = YES;
    //sclView.contentSize = CGSizeMake(size.width, size.height);
    //[self.view addSubview:sclView];
    
    //筛选区
    UIView *vFilter = [[UIView alloc] initWithFrame:CGRectMake(0, 64, size.width, 110)];
    [self.view addSubview:vFilter];
    vFilter.backgroundColor=[UIColor whiteColor];
    
    UIView *vFilter2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 70)];
    
    [vFilter addSubview:vFilter2];
    
    UILabel *departure = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    departure.text = @"出发地";

    departure.font = [UIFont systemFontOfSize:14];
    
    UILabel *destination = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 80, 30)];
    destination.text = @"目的地";

    destination.font = [UIFont systemFontOfSize:14];

    
    UITextField *departureArea = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 120, 30)];

    departureArea.placeholder = @"选择出发地";
    departureArea.font = [UIFont systemFontOfSize:14];
    UITextField *destinationArea = [[UITextField alloc] initWithFrame:CGRectMake(100, 40, 120, 30)];
    destinationArea.font = [UIFont systemFontOfSize:14];
    destinationArea.placeholder = @"选择目的地";
    
    UITextField *keyword = [[UITextField alloc] initWithFrame:CGRectMake(10, 70, size.width-20, 30)];
    keyword.borderStyle = UITextBorderStyleRoundedRect;
    [keyword.layer setCornerRadius:12.0f];
    keyword.backgroundColor = [UIColor colorWithRed:214/255.0f green:214/255.0f blue:214/255.0f alpha:1];
    
    self.keyword = keyword;
    
    UIButton *btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 38, 75, 20, 20)];
    UIImage *iconQuery = [UIImage imageNamed:@"query.png"];
    //[btnSearch setTitle:@"搜索" forState:UIControlStateNormal];
    [btnSearch setBackgroundImage:iconQuery forState:UIControlStateNormal];
   // btnSearch.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    //[btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnSearch addTarget:self action:@selector(touchedInSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    [vFilter2 addSubview:departure];
    [vFilter2 addSubview:destination];

    [vFilter2 addSubview:departureArea];
    [vFilter2 addSubview:destinationArea];
    [vFilter addSubview:keyword];
    [vFilter addSubview:btnSearch];
    
    
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"货源",@"车源", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(10, 180, size.width-20, 30);
    
    segmentedControl.tintColor = [UIColor colorWithRed:12/255.0 green:129/255.0 blue:245/255.0 alpha:1];
    segmentedControl.selectedSegmentIndex = 0;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor colorWithRed:12/255.0 green:129/255.0 blue:245/255.0 alpha:1],NSForegroundColorAttributeName, nil];
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    [segmentedControl addTarget:self action:@selector(touchedInSegment:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.view addSubview:segmentedControl];
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, size.width, size.height-270)];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    
    [self.tableview addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    
    [self.tableview addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    [self.view addSubview:tableview];

    



    // tap for dismissing keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, size.width, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton,[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],doneButton,nil ]];
    
    departureArea.inputView = pickerView;
    departureArea.inputAccessoryView = toolBar;
    destinationArea.inputView = pickerView;
    destinationArea.inputAccessoryView = toolBar;
    
    self.departureArea = departureArea;
    self.destinationArea = destinationArea;
    
    
    
    [self refreshingData:1 callback:^{
        [self.tableview.header endRefreshing];
    }];

    
}
-(void) touchedInSearch:(id)sender{
    [self refreshingData:1 callback:^{
        [self.tableview.header endRefreshing];
    }];
}
-(void) touchedInSegment:(id)sender{
    //NSLog(@"%@",sender);
    
    NSUInteger selectedIndex = [sender selectedSegmentIndex];
    
    self.cid = selectedIndex + 1;
    
    [self refreshingData:1 callback:^{
        [self.tableview.header endRefreshing];
    }];
    
}

// tap dismiss keyboard
-(void)dismissKeyboard {
    [self.view endEditing:YES];
    [self.keyword resignFirstResponder];
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


- (UIButton*) createButton:(id)target Selector:(SEL)selector Image:(NSString *)image Title:(NSString *) title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setFrame:frame];
    UIImage *newImage = [UIImage imageNamed: image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints= NO;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [button setAdjustsImageWhenHighlighted:NO];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    //button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, -20.0, 0.0)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}


-(void)doneTouched:(id)sender{
    //[self.category resignFirstResponder];
    if([self.departureArea resignFirstResponder] == YES){
    
        self.departureArea.text = [NSString stringWithFormat:@"%@ %@", self.selectedProvince,self.selectedCity ];
        self.fpid = self.selectedProvinceId;
        self.fcid = self.selectedCityId;
        [self.departureArea resignFirstResponder];
    }
    
    if([self.destinationArea resignFirstResponder] == YES){
        self.destinationArea.text = [NSString stringWithFormat:@"%@ %@", self.selectedProvince,self.selectedCity ];
        self.tpid = self.selectedProvinceId;
        self.tcid = self.selectedCityId;
        [self.destinationArea resignFirstResponder];
    }

}
-(void) cancelTouched:(id)sender{
    [self.departureArea resignFirstResponder];
    [self.destinationArea resignFirstResponder];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    //return [self.items count];
    if(component == 0){
        return [self.province count];
    }
    else if(component == 1){
        return [self.city count];
    }
    
    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //return [self.items objectAtIndex:row];

    if(component == 0){
        
        self.selectedProvince = [self.province objectAtIndex:row];
        return [self.province objectAtIndex:row];
    }
    else if (component == 1){
        self.selectedCity = [self.city objectAtIndex:row];
        return [self.city objectAtIndex:row];
    }
    
    return @"";
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(component == 0){
        [self loadCity:[[self.provinceKey objectAtIndex:row] integerValue]];
        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:1];
        
        self.selectedProvince = [self.province objectAtIndex:row];
        self.selectedProvinceId = [[self.provinceKey objectAtIndex:row] integerValue];
    }
    if(component == 1){
        
         [pickerView selectRow:0 inComponent:1 animated:YES];
        self.selectedCity = [self.city objectAtIndex:row];
        self.selectedCityId = [[self.cityKey objectAtIndex:row] integerValue];
    }
    //self.category.text = [self.items objectAtIndex:row];
   // self.cid = [[self.itemsKeys objectAtIndex:row] integerValue];
}

-(void) loadRegion{
    NSArray *regions = [BWCommon getDataInfo:@"regions"];
    //遍历获取数据
    //省份数据 parent_id=1
    
    for (int i=0;i<[regions count];i++){
        NSDictionary *item = [[NSDictionary alloc] initWithDictionary:[regions objectAtIndex:i]];
        
        if ([[item objectForKey:@"parent_id"] integerValue] == 1) {
            [self.province addObject:[item objectForKey:@"region_name"]];
            [self.provinceKey addObject:[item objectForKey:@"region_id"]];
        }
    }
    
    //默认加载第一条
    [self loadCity:[[self.provinceKey objectAtIndex:0] integerValue]];
    //NSLog(@"%@",self.province);

}

-(void) loadCity:(NSInteger) parent_id{
    NSArray *regions = [BWCommon getDataInfo:@"regions"];
    [self.city removeAllObjects];
    [self.cityKey removeAllObjects];
    for (int i=0;i<[regions count];i++){
        NSDictionary *item = [[NSDictionary alloc] initWithDictionary:[regions objectAtIndex:i]];
        if ([[item objectForKey:@"parent_id"] integerValue] == parent_id) {
            [self.city addObject:[item objectForKey:@"region_name"]];
            [self.cityKey addObject:[item objectForKey:@"region_id"]];
        }
    }
    NSLog(@"%@",self.city);
}


- (void) refreshingData:(NSUInteger)page callback:(void(^)()) callback
{
    
    //hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.delegate=self;
    
    NSString *api_url = [BWCommon getBaseInfo:@"api_url"];
    NSString *list_url = [api_url stringByAppendingString:@"GetWayData"];
    NSString *q = [[NSString alloc] init];
    q = self.keyword.text;
    if([q isEqual:nil])
        q = @"";

    list_url = [list_url stringByAppendingFormat:@"?cid=%lu&fpid=%lu&fcid=%lu&tpid=%lu&tcid=%lu&title=%@&page=%lu&page_size=10",self.cid,self.fpid,self.fcid,self.tpid,self.tcid,q,page];
    
    NSLog(@"%@",list_url);
    //load data
    [AFNetworkTool JSONDataWithUrl:list_url success:^(id json) {
        
        NSString *result = [json objectForKey:@"result"];
        
        //[hud removeFromSuperview];
        if([result  isEqual:@"ok"])
        {
        
            if(page == 1)
            {
                dataArray = [[json objectForKey:@"data"] mutableCopy];
            }
            else
            {
                [dataArray addObjectsFromArray:[[json objectForKey:@"data"] mutableCopy]];
                
            }
            
            NSLog(@"%@",dataArray);
            
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
        //[hud removeFromSuperview];
        NSLog(@"请求失败");
    }];
    
    
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
   /*
    MixDetailViewController *detailViewController = [[MixDetailViewController alloc] init];
    
    detailViewController.hidesBottomBarWhenPushed = YES;
    self.delegate = detailViewController;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [self.delegate setValue:detail_id];
    */
    
}

@end
