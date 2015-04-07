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
    UIScrollView *sclview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, size.width, size.height - 115)];
    
    sclview.backgroundColor = [UIColor grayColor];
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 60)];
    mainView.backgroundColor = [UIColor whiteColor];
    [mainView.layer setCornerRadius:15.0f];
    
    
    UILabel *content = [[UILabel alloc] init];
    content.font = NJTextFont;
    
    self.content = content;
    [mainView addSubview:content];
    
    self.mainView = mainView;
    
    
    [sclview addSubview:mainView];
    [self.view addSubview:sclview];

    
    [self loadData:detail_id];

    // Do any additional setup after loading the view.
}

-(void) renderPage:(NSDictionary *) data{
    CGSize contentSize = [BWCommon sizeWithString: [data objectForKey:@"content"] font:NJTextFont maxSize:CGSizeMake(300, MAXFLOAT)];
    self.content.frame = CGRectMake(10, 10, contentSize.width, contentSize.height);
    self.content.numberOfLines = 0;
    
    self.content.text = [data objectForKey:@"content"];
}

- (void) loadData:(NSUInteger) detail_id{
    
    NSString *api_url = [BWCommon getBaseInfo:@"api_url"];
    NSString *list_url = [api_url stringByAppendingString:@"GetLclDetailData"];
    list_url = [list_url stringByAppendingFormat:@"?id=%d",detail_id];
    //load data
    [AFNetworkTool JSONDataWithUrl:list_url success:^(id json) {
        NSString *result = [json objectForKey:@"result"];
        
        if([result  isEqual:@"ok"])
        {
            [self renderPage:[json objectForKey:@"data"]];
            //NSLog(@"%@",[json objectForKey:@"data"]);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
