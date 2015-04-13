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

@property (nonatomic,readwrite) NSInteger cid;

@end

@implementation MixPublishViewController

@synthesize items = _items;
@synthesize itemsKeys = _itemsKeys;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutPage];
    [self lclData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.content addObserver];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.content removeobserver];
}

-(void) lclData{
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
            
            NSLog(@"%@",itemsData);
        }

    } fail:^{
        NSLog(@"请求失败");
    }];

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
    
    UIPlaceholderTextView *content = [[UIPlaceholderTextView alloc] initWithFrame:CGRectMake(10, 10, size.width-20, 100)];
    content.layer.borderWidth = 1.0;
    content.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
    [content.layer setCornerRadius:5.0f];

    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    content.attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:attributes];
    
    content.textColor = [UIColor blackColor];
    content.delegate = self;
    
    content.placeholder = @"请输入发布的信息...";
    
    self.content = content;
    
    [sclview addSubview:content];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 80, 40)];
    [sclview addSubview:categoryLabel];
    categoryLabel.text = @"发布到：";
    categoryLabel.textColor = [UIColor blackColor];
    
    UITextField *category = [[UITextField alloc] initWithFrame:CGRectMake(90, 120, size.width-100, 40)];
    category.borderStyle = UITextBorderStyleRoundedRect;
    [category.layer setCornerRadius:5.0f];
    
    category.delegate = self;

    category.inputView = pickerView;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, size.width, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton,[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],doneButton,nil ]];
    [sclview addSubview:category];
    
    category.inputAccessoryView = toolBar;

    
    self.category = category;
    
    UIButton *btnPublish = [[UIButton alloc] initWithFrame:CGRectMake(10, 180, size.width-20, 40)];
    [btnPublish.layer setMasksToBounds:YES];
    [btnPublish.layer setCornerRadius:5.0];
    [btnPublish addTarget:self action:@selector(publishTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnPublish.tintColor = [UIColor whiteColor];
    btnPublish.backgroundColor = [UIColor colorWithRed:119/255.0 green:179/255.0 blue:215/255.0 alpha:1];
    [btnPublish setTitle:@"点击发布" forState:UIControlStateNormal];

    
    [sclview addSubview:btnPublish];
    
    [self.view addSubview:sclview];
    
    
}
-(void) publishTouched:(id)sender{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    
    if([self.content.text isEqualToString:@""])
    {
        [alert setMessage:@"内容未输入"];
        [alert show];
        return;
    }
    
    if( self.cid <= 0)
    {
        [alert setMessage:@"栏目未选择"];
        [alert show];
        return;
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.delegate=self;
    hud.labelText = @"发布中..";
    
    NSString *api_url = [BWCommon getBaseInfo:@"api_url"];
    
    NSString *url =  [api_url stringByAppendingString:@"addLcl"];
    
    NSString *uid = [BWCommon getUserInfo:@"uid"];
    
    NSDictionary *postData = @{@"content":self.content.text,@"cid":[NSNumber numberWithInt:(int)self.cid],@"uid":uid};
    
    [AFNetworkTool postJSONWithUrl:url parameters:postData success:^(id responseObject) {
        
        [hud removeFromSuperview];
        
        NSString *result = [responseObject objectForKey:@"result"];
        
        NSString *msg = [responseObject objectForKey:@"msg"];
        if([result  isEqual:@"ok"])
        {
            [alert setMessage:@"信息发布成功！"];
            [alert show];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [alert setMessage:msg];
            [alert show];
        }
        //NSLog(@"%@",msg);
    } fail:^{
        [hud removeFromSuperview];
        NSLog(@"请求失败");
    }];

    
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
    return [self.items count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.items objectAtIndex:row];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.category.text = [self.items objectAtIndex:row];
    self.cid = [[self.itemsKeys objectAtIndex:row] integerValue];
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
