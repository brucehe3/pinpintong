//
//  LoginViewController.m
//  pinpintong
//
//  Created by Bruce He on 15-4-5.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AFNetworkTool.h"
#import "BWCommon.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


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
    
    self.username = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    self.username.borderStyle = UITextBorderStyleRoundedRect;
    [self.username.layer setCornerRadius:15.0];
    self.username.backgroundColor = [UIColor whiteColor];
    self.username.textAlignment = NSTextAlignmentCenter;
    self.username.placeholder = @"请输入账号";
    
    self.username.delegate = self;
    
    [self.view addSubview:self.username];
    
    self.password = [[UITextField alloc] initWithFrame:CGRectMake(10, 250, 300, 40)];
    self.password.borderStyle=UITextBorderStyleRoundedRect;
    [self.password.layer setCornerRadius:15.0];
    self.password.backgroundColor = [UIColor whiteColor];
    self.password.textAlignment = NSTextAlignmentCenter;
    self.password.placeholder = @"请输入密码";
    self.password.secureTextEntry =true;
    [self.view addSubview:self.password];
    
    
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
    
    [btnRegister addTarget:self action:@selector(registerTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnRegister];

    
    self.view.backgroundColor = [UIColor colorWithRed:55/255.0 green:126/255.0 blue:180/255.0 alpha:1];
    
    
    // tap for dismissing keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    // very important make delegate useful
    tap.delegate = self;
    
    
}

// tap dismiss keyboard
-(void)dismissKeyboard {
    [self.view endEditing:YES];
    [self.password resignFirstResponder];
}


- (void) loginTouched:(id)sender
{
    
    NSString *usernameValue = self.username.text;
    NSString *passwordValue = self.password.text;

    
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

    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.delegate=self;
    hud.labelText = @"登录中..";
    
    NSString *api_url = [BWCommon getBaseInfo:@"api_url"];
    
    NSString *url =  [api_url stringByAppendingString:@"checkLogin"];
    
    NSDictionary *postData = @{@"username":usernameValue,@"password":passwordValue};
    
    [AFNetworkTool postJSONWithUrl:url parameters:postData success:^(id responseObject) {
        
        [hud removeFromSuperview];
        
        NSString *result = [responseObject objectForKey:@"result"];
        
        NSString *msg = [responseObject objectForKey:@"msg"];
        if([result  isEqual:@"ok"])
        {
            NSDictionary *data = [responseObject objectForKey:@"userinfo"];
            
            NSUserDefaults *udata = [NSUserDefaults standardUserDefaults];
            [udata setObject:[data objectForKey:@"uid"] forKey:@"uid"];
            [udata setObject:[data objectForKey:@"username"] forKey:@"username"];
            [udata synchronize];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            
            id mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainIdentifier"];
            
            [self presentViewController:mainViewController animated:YES completion:^{}];
            //NSLog(@"%@",udata);
        }
        else
        {
            [alert setMessage:msg];
            [alert show];
        }
        NSLog(@"%@",msg);
    } fail:^{
        [hud removeFromSuperview];
        NSLog(@"请求失败");
    }];
}

- (void) registerTouched:(id)sender
{
    
    RegisterViewController * registerView = [[RegisterViewController alloc] init];
    
    [self presentViewController:registerView animated:YES completion:^(void){
        
        NSString *username = [BWCommon getUserInfo:@"username"];
        if(username != nil){
            //注册成功
        }
        NSLog(@"register view closed");
    }];
    
    NSLog(@"register touched");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
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
