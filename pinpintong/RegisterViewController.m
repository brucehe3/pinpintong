//
//  RegisterViewController.m
//  pinpintong
//
//  Created by Bruce on 15-4-5.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworkTool.h"
#import "BWCommon.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

UITextField *username;
UITextField *password;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(10,10, 40, 40)];
    [btnBack setTitle:@"取消" forState:UIControlStateNormal];
    btnBack.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [header addSubview:btnBack];
    
    [btnBack addTarget:self action:@selector(backTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"新用户注册";
    title.font = [UIFont systemFontOfSize:16.0f];
    
    [header addSubview:title];
    [self.view addSubview:header];
    
    
    username = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    username.borderStyle = UITextBorderStyleRoundedRect;
    [username.layer setCornerRadius:15.0];
    username.backgroundColor = [UIColor whiteColor];
    username.textAlignment = NSTextAlignmentCenter;
    username.placeholder = @"请输入账号";
    
    username.delegate = self;
    
    [self.view addSubview:username];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(10, 250, 300, 40)];
    password.borderStyle=UITextBorderStyleRoundedRect;
    [password.layer setCornerRadius:15.0];
    password.backgroundColor = [UIColor whiteColor];
    password.textAlignment = NSTextAlignmentCenter;
    password.placeholder = @"请输入密码";
    password.secureTextEntry =true;
    [self.view addSubview:password];
    
    
    UIButton *btnRegister = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnRegister.frame = CGRectMake(10, 330, 300, 40);
    [btnRegister.layer setCornerRadius:15.0];
    btnRegister.backgroundColor = [UIColor colorWithRed:244/255.0 green:192/255.0 blue:68/255.0 alpha:1];
    btnRegister.tintColor = [UIColor whiteColor];
    [btnRegister setTitle:@"免费注册" forState:UIControlStateNormal];
    
    [btnRegister addTarget:self action:@selector(registerTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnRegister];

    
    self.view.backgroundColor = [UIColor colorWithRed:55/255.0 green:126/255.0 blue:180/255.0 alpha:1];
}


-(void) backTouched: (id)sender
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}

-(void) registerTouched: (id)sender
{
    NSString *usernameValue = username.text;
    NSString *passwordValue = password.text;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    if([usernameValue isEqualToString:@""])
    {
        [alert setMessage:@"用户名未输入"];
        [alert show];
        return;
    }
    
    if([passwordValue isEqualToString:@""])
    {
        [alert setMessage:@"密码未输入"];
        [alert show];
        return;
    }


    NSString *api_url = [BWCommon getBaseInfo:@"api_url"];

    NSString *url =  [api_url stringByAppendingString:@"checkReg"];
    
    NSDictionary *postData = @{@"username":usernameValue,@"password":passwordValue};
    
    
    [AFNetworkTool postJSONWithUrl:url parameters:postData success:^(id responseObject) {
        
        NSString *result = [responseObject objectForKey:@"result"];
        
        NSString *msg = [responseObject objectForKey:@"msg"];
        if([result  isEqual:@"ok"])
        {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            
            NSUserDefaults *udata = [NSUserDefaults standardUserDefaults];
            udata = [data copy];
            //[udata setObject:[data objectForKey:@"uid"] forKey:@"uid"];
            
            [self backTouched:nil];
            
            NSLog(@"%@",udata);
        }
        else
        {
            [alert setMessage:msg];
            [alert show];
        }
        NSLog(@"%@",msg);
    } fail:^{
        NSLog(@"请求失败");
    }];

   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [username resignFirstResponder];
    [password resignFirstResponder];
    return YES;
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
