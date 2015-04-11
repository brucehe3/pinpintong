//
//  MixDetailViewController.m
//  pinpintong
//
//  Created by Bruce on 15-4-4.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MixDetailViewController.h"
#import "BWCommon.h"
#import "AFNetworkTool.h"


#define NJNameFont [UIFont systemFontOfSize:15]
#define NJTextFont [UIFont systemFontOfSize:16]

@interface MixDetailViewController ()

@property (nonatomic, weak) UIView *mainView;
@property (nonatomic, weak) UILabel *content;
@property (nonatomic, weak) UILabel *name;
@property (nonatomic, weak) UILabel *contactPerson;
@property (nonatomic, weak) UILabel *contactPhone;
@property (nonatomic, weak) UILabel *contactCellphone;
@property (nonatomic, weak) UILabel *contactTips;
@property (nonatomic, weak) UILabel *companyName;
@property (nonatomic, weak) UILabel *companyAddress;

@end

@implementation MixDetailViewController

NSUInteger detail_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //初始化view
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    
    //CGFloat padding = 10;
    
    self.navigationItem.title = @"详细信息";
    UIScrollView *sclview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    sclview.backgroundColor = [UIColor colorWithRed:214/255.0f green:214/255.0f blue:214/255.0f alpha:1];
    
    //add buttons
    UIButton *btnSendSms = [self createButton:self Selector:nil Image:@"button_sms_icon.9.png" Title:@"" PressedImage:@"button_sms_icon_pressed.9.png"];
    UIButton *btnCallPhone = [self createButton:self Selector:nil Image:@"button_call_icon.9.png" Title:@"" PressedImage:@"button_call_icon_pressed.9.png"];
    
    [sclview addSubview: btnSendSms];
    [sclview addSubview:btnCallPhone];
    
    
    NSArray *constraints1= [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[btnSendSms(<=127)][btnCallPhone(<=127)]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnSendSms,btnCallPhone)];
    NSArray *constraints2= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[btnSendSms(<=37.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnSendSms)];
    NSArray *constraints3= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[btnCallPhone(<=37.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnCallPhone)];
    
    [sclview addConstraints:constraints1];
    [sclview addConstraints:constraints2];
    [sclview addConstraints:constraints3];
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(10, 60, size.width-20, 100)];
    mainView.backgroundColor = [UIColor whiteColor];
    [mainView.layer setCornerRadius:5.0f];
    
    
    UILabel *content = [[UILabel alloc] init];
    content.font = NJTextFont;
    
    self.content = content;
    [mainView addSubview:content];
    
    self.mainView = mainView;
    
    //contactView
    UIView *contactView = [[UIView alloc] initWithFrame:CGRectMake(10,170, size.width-20,200)];
    contactView.backgroundColor = [UIColor whiteColor];
    [contactView.layer setCornerRadius:5.0f];
    
    //联系人 联系电话 手机号 公司简称 公司地址
    UILabel *contactPerson = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, size.width-40, 20)];
    [contactView addSubview:contactPerson];
    UILabel *contactPhone = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, size.width-40, 20)];
    [contactView addSubview:contactPhone];
    UILabel *contactCellphone = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, size.width-40, 20)];
    [contactView addSubview:contactCellphone];
    UILabel *contactTips = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, size.width-40, 20)];
    [contactView addSubview:contactTips];
    UILabel *companyName = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, size.width-40, 20)];
    [contactView addSubview:companyName];
    UILabel *companyAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, size.width-40, 20)];
    [contactView addSubview:companyAddress];
    self.contactPhone = contactPhone;
    self.contactPerson = contactPerson;
    self.contactTips = contactTips;
    self.companyAddress = companyAddress;
    self.companyName = companyName;
    
    
    [sclview addSubview:mainView];
    [sclview addSubview:contactView];
    [self.view addSubview:sclview];

    
    [self loadData:detail_id];

    // Do any additional setup after loading the view.
}

-(void) renderPage:(NSDictionary *) data{
    CGSize contentSize = [BWCommon sizeWithString: [data objectForKey:@"content"] font:NJTextFont maxSize:CGSizeMake(290, MAXFLOAT)];
    self.content.frame = CGRectMake(10, 10, contentSize.width, contentSize.height);
    self.content.numberOfLines = 0;
    
    self.content.text = [data objectForKey:@"content"];
    
    self.contactPerson.text = [NSString stringWithFormat:@"联系人：%@", [data objectForKey:@"username"] ];
    
}

- (void) loadData:(NSUInteger) detail_id{
    
    NSString *api_url = [BWCommon getBaseInfo:@"api_url"];
    NSString *list_url = [api_url stringByAppendingString:@"GetLclDetailData"];
    list_url = [list_url stringByAppendingFormat:@"?id=%lu",(unsigned long)detail_id];
    //load data
    [AFNetworkTool JSONDataWithUrl:list_url success:^(id json) {
        NSString *result = [json objectForKey:@"result"];
        
        if([result  isEqual:@"ok"])
        {
            [self renderPage:[json objectForKey:@"data"]];
            NSLog(@"%@",[json objectForKey:@"data"]);
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

- (void) setValue:(NSUInteger)detailValue{
    
    detail_id = detailValue;
}


- (UIButton*) createButton:(id)target Selector:(SEL)selector Image:(NSString *)image Title:(NSString *) title PressedImage:(NSString *) pressedImage
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setFrame:frame];
    UIImage *newImage = [UIImage imageNamed: image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    UIImage *dImage = [UIImage imageNamed:pressedImage];
    [button setBackgroundImage:dImage forState:UIControlStateHighlighted];
    
    button.translatesAutoresizingMaskIntoConstraints= NO;
    //[button setTitle:title forState:UIControlStateNormal];
    //button.titleLabel.font=[UIFont systemFontOfSize:12.0];
    //[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    //button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, -20.0, 0.0)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
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
