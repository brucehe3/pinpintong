//
//  MixPublishViewController.m
//  pinpintong
//
//  Created by Bruce He on 15-4-11.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MixPublishViewController.h"
#import "AFNetworkTool.h"
#import "BWCommon.h"

@interface MixPublishViewController ()

@end

@implementation MixPublishViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) layoutPage{
    
    [[self navigationItem] setTitle:@"发布信息"];
    //[[[self navigationController] navigationBar] setTintColor:[UIColor whiteColor]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化view
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    UIScrollView *sclview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    sclview.contentSize = CGSizeMake(size.width, size.height);
    sclview.scrollEnabled = YES;
    
    UITextView *content = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, size.width-20, 100)];
    content.layer.borderWidth = 1.0;
    content.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
    [content.layer setCornerRadius:5.0f];


    
    content.delegate = self;
    
    self.content = content;
    
    [sclview addSubview:content];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    UITextField *category = [[UITextField alloc] initWithFrame:CGRectMake(10, 120, size.width-20, 40)];
    category.borderStyle = UITextBorderStyleRoundedRect;
    [category.layer setCornerRadius:5.0f];
    category.inputView = pickerView;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, size.width, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton,[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],doneButton,nil ]];
    [sclview addSubview:category];
    
    category.inputAccessoryView = toolBar;
    
    self.category = category;
    
    UIButton *btnPublish = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, size.width-20, 40)];
    [btnPublish addTarget:self action:@selector(publishTouched:) forControlEvents:UIControlEventTouchUpInside];
    btnPublish.titleLabel.text = @"点击发布";
    btnPublish.backgroundColor = [UIColor grayColor];
    
    [sclview addSubview:btnPublish];
    
    [self.view addSubview:sclview];
    
    
}
-(void) publishTouched:(id)sender{
    
    [self.category becomeFirstResponder];
    
}
-(void)doneTouched:(id)sender{
    [self.category resignFirstResponder];
}
-(void) cancelTouched:(id)sender{
    [self.category resignFirstResponder];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 5;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"22";
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
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
