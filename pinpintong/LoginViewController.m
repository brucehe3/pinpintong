//
//  LoginViewController.m
//  pinpintong
//
//  Created by Bruce He on 15-4-5.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

UITextField *username;
UITextField *password;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    //[header.layer setBorderColor:[[UIColor blackColor] CGColor]];
    //[header.layer setBorderWidth:5.0f];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"用户登录";
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
    
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnLogin.frame = CGRectMake(10, 300, 300, 40);
    [btnLogin.layer setMasksToBounds:YES];
    [btnLogin.layer setCornerRadius:15.0];
    btnLogin.backgroundColor = [UIColor colorWithRed:119/255.0 green:179/255.0 blue:215/255.0 alpha:1];
    btnLogin.tintColor = [UIColor whiteColor];

    [btnLogin setTitle:@"确认登录" forState:UIControlStateNormal];
    
    //点击回调
    [btnLogin addTarget:self action:@selector(loginTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnLogin];
    
    UILabel *tipsRegister=[[UILabel alloc] initWithFrame:CGRectMake(10, 350, 300, 40)];
    tipsRegister.textAlignment = NSTextAlignmentCenter;
    tipsRegister.font = [UIFont boldSystemFontOfSize:14.0f];
    tipsRegister.textColor = [UIColor whiteColor];
    tipsRegister.text = @"还没有账号？";
    [self.view addSubview:tipsRegister];
    
    UIButton *btnRegister = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnRegister.frame = CGRectMake(10, 380, 300, 40);
    [btnRegister.layer setCornerRadius:15.0];
    btnRegister.backgroundColor = [UIColor colorWithRed:244/255.0 green:192/255.0 blue:68/255.0 alpha:1];
    btnRegister.tintColor = [UIColor whiteColor];
    [btnRegister setTitle:@"免费注册" forState:UIControlStateNormal];
    
    [self.view addSubview:btnRegister];

    
    self.view.backgroundColor = [UIColor colorWithRed:55/255.0 green:126/255.0 blue:180/255.0 alpha:1];
    
}

- (void) loginTouched:(id)sender
{
    NSLog(@"login touched");
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
