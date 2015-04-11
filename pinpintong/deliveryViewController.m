//
//  SecondViewController.m
//  pinpintong
//
//  Created by Bruce He on 15-3-14.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "DeliveryViewController.h"

@interface DeliveryViewController ()
- (UIButton*) createButton:(id)target Selector:(SEL)selector Image:(NSString *)image Title:(NSString *) title;
@end

@implementation DeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self layoutPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutPage{
    
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
    
    UIScrollView *sclView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    sclView.backgroundColor = [UIColor colorWithRed:200/255.5f green:200/255.5f blue:200/255.5f alpha:1];
    sclView.scrollEnabled = YES;
    sclView.contentSize = CGSizeMake(size.width, size.height);
    [self.view addSubview:sclView];
    
    //筛选区
    UIView *vFilter = [[UIView alloc] initWithFrame:CGRectMake(0, 64, size.width, 110)];
    [self.view addSubview:vFilter];
    vFilter.backgroundColor=[UIColor whiteColor];
    
    UIView *vFilter2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 70)];
    
    [vFilter addSubview:vFilter2];
    
    UILabel *departure = [[UILabel alloc] init];
    departure.text = @"出发地";
    departure.translatesAutoresizingMaskIntoConstraints= NO;
    departure.font = [UIFont systemFontOfSize:16];
    
    UILabel *destination = [[UILabel alloc] init];
    destination.text = @"目的地";
    destination.translatesAutoresizingMaskIntoConstraints= NO;
    destination.font = [UIFont systemFontOfSize:16];
    
    UIButton *departureProvince = [self createButton:self Selector:nil Image:@"input_bg.png" Title:@"选择省份"];
    UIButton *departureCity = [self createButton:self Selector:nil Image:@"input_bg.png" Title:@"选择城市"];
    UIButton *destinationProvince = [self createButton:self Selector:nil Image:@"input_bg.png" Title:@"选择省份"];
    UIButton *destinationCity = [self createButton:self Selector:nil Image:@"input_bg.png" Title:@"选择城市"];
    
    UITextField *keyword = [[UITextField alloc] initWithFrame:CGRectMake(10, 70, size.width-20, 30)];
    keyword.borderStyle = UITextBorderStyleRoundedRect;
    [keyword.layer setCornerRadius:12.0f];
    keyword.backgroundColor = [UIColor colorWithRed:214/255.0f green:214/255.0f blue:214/255.0f alpha:1];
    
    [vFilter2 addSubview:departure];
    [vFilter2 addSubview:destination];
    [vFilter2 addSubview:departureProvince];
    [vFilter2 addSubview:departureCity];
    [vFilter2 addSubview:destinationProvince];
    [vFilter2 addSubview:destinationCity];
    [vFilter addSubview:keyword];
    
    
    NSArray *constraints1= [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[departure]-[departureProvince(==115)]-[departureCity(==115)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(departure,departureProvince,departureCity)];
    NSArray *constraints2= [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[destination]-[destinationProvince(==115)]-[destinationCity(==115)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(destination,destinationProvince,destinationCity)];
    NSArray *constraints3= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[departure]-[destination]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(departure,destination)];
    NSArray *constraints4= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[departureProvince(==23)]-[destinationProvince(==23)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(departureProvince,destinationProvince)];
    NSArray *constraints5= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[departureCity(==23)]-[destinationCity(==23)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(departureCity
,destinationCity)];
    
    //NSArray *constraints6 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[keyword]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(keyword)];
    //NSArray *constraints7 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[keyword]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(keyword)];
    
    [vFilter2 addConstraints:constraints1];
    [vFilter2 addConstraints:constraints2];
    [vFilter2 addConstraints:constraints3];
    [vFilter2 addConstraints:constraints4];
    [vFilter2 addConstraints:constraints5];
    //[vFilter2 addConstraints:constraints6];
    //[vFilter2 addConstraints:constraints7];

    // tap for dismissing keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];


    
}


// tap dismiss keyboard
-(void)dismissKeyboard {
    [self.view endEditing:YES];
    [self.keyword resignFirstResponder];
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

@end
