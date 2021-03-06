//
//  MoreViewController.m
//  pinpintong
//
//  Created by Bruce on 15-4-6.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MoreViewController.h"
#import "BWCommon.h"
#import "MoreTableViewCell.h"
#import "UserInfoTableViewController.h"

@interface MoreViewController ()


@end

@implementation MoreViewController

- (void)viewDidLoad {
    [[self navigationItem] setTitle:@"更多"];
    
    [super viewDidLoad];
    
    [self initLayout];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

/* 这个函数是指定显示多少cells*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1; //这个是指定加载数据的多少即显示多少个cell，如果这个地方弄错了会崩溃的哟
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"username";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //if (cell == nil) {
        
    cell = [[MoreTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
        //UIImageView * face;
        //face = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        //[face setImage:[UIImage imageNamed:@"default_face2.png"]];
    cell.textLabel.text = [BWCommon getUserInfo:@"username"];

    cell.imageView.image = [UIImage imageNamed:@"default_face2.png"];
    
    cell.detailTextLabel.text = @"商户名称";
    
    
    
    
        
    //}
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSUInteger detail_id;
    //detail_id = [[[dataArray objectAtIndex:[indexPath row]] objectForKey:@"id"] integerValue];
    
    UserInfoTableViewController *userInfoTableViewController = [[UserInfoTableViewController alloc] init];
    userInfoTableViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:userInfoTableViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (void) initLayout{
    
    
    //self.view.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    //初始化view
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;

    UIScrollView *sclView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height-46.0f)];
    sclView.backgroundColor = [UIColor colorWithRed:200/255.5f green:200/255.5f blue:200/255.5f alpha:1];
    sclView.scrollEnabled = YES;
    sclView.contentSize = CGSizeMake(size.width, size.height-110);
    [self.view addSubview:sclView];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, size.width, 60)];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [sclView addSubview:tableview];
    
    
   // UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, size.width, 60)];
   // headView.backgroundColor = [UIColor whiteColor];
   // [sclView addSubview:headView];
    

    

   // [headView  addSubview:face];
    
   // UILabel * username = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 120, 20)];
   // username.text = [BWCommon getUserInfo:@"username"];
   // [headView addSubview:username];
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, size.width, 320)];
    mainView.backgroundColor = [UIColor whiteColor];
    
    [sclView addSubview:mainView];
    
    //image buttons
    UIButton * btnFavorite = [self createButton:self Selector:nil Image:@"shoucang50.png"  Title:@"我的收藏"];
    UIButton * btnPublish = [self createButton:self Selector:nil Image:@"publish.png" Title:@"我的发布"];
    UIButton * btnFeedback = [self createButton:self Selector:nil Image:@"feed_back.png" Title:@"意见反馈"];
    
    [mainView addSubview:btnFavorite];
    [mainView addSubview:btnPublish];
    [mainView addSubview:btnFeedback];
    
    UIButton * btnScan = [self createButton:self Selector:nil Image:@"scan_install.png" Title:@"扫一扫"];
    UIButton * btnService = [self createButton:self Selector:nil Image:@"assitance.png" Title:@"客服热线"];
    UIButton * btnChange = [self createButton:self Selector:nil Image:@"change_acount.png" Title:@"切换账号"];
    [mainView addSubview:btnScan];
    [mainView addSubview:btnService];
    [mainView addSubview:btnChange];
    
    UIButton *btnShare = [self createButton:self Selector:nil Image:@"share.png" Title:@"分享好友"];
    UIButton *btnLesson = [self createButton:self Selector:nil Image:@"faq.png" Title:@"使用教程"];
    UIButton *btnLogout = [self createButton:self Selector:nil Image:@"exit.png" Title:@"退出"];
    [mainView addSubview:btnShare];
    [mainView addSubview:btnLesson];
    [mainView addSubview:btnLogout];
    
    [btnLogout addTarget:self action:@selector(logoutTouched:) forControlEvents:UIControlEventTouchUpInside];
    [btnChange addTarget:self action:@selector(changeTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray *constraints1= [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[btnFavorite(<=60)]-40-[btnPublish(<=60)]-40-[btnFeedback(<=60)]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnFavorite,btnPublish,btnFeedback)];
    NSArray *constraints2= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[btnFavorite(<=60)]-40-[btnScan(<=60)]-40-[btnShare(<=60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnFavorite,btnScan,btnShare)];
    
    NSArray *constraints3= [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[btnScan(<=60)]-40-[btnService(<=60)]-40-[btnChange(<=60)]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnScan,btnService ,btnChange)];
    
    NSArray *constraints4= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[btnPublish(<=60)]-40-[btnService(<=60)]-40-[btnLesson(<=60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnPublish,btnService,btnLesson)];
    
    NSArray *constraints5= [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[btnShare(<=60)]-40-[btnLesson(<=60)]-40-[btnLogout(<=60)]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings( btnShare,btnLesson,btnLogout)];
    
    NSArray *constraints6= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[btnFeedback(<=60)]-40-[btnChange(<=60)]-40-[btnLogout(<=60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnFeedback,btnChange,btnLogout)];

    
    
    [mainView addConstraints:constraints1];
    [mainView addConstraints:constraints2];
    [mainView addConstraints:constraints3];
    [mainView addConstraints:constraints4];
    [mainView addConstraints:constraints5];
    [mainView addConstraints:constraints6];
    
}

- (UIButton*) createButton:(id)target Selector:(SEL)selector Image:(NSString *)image Title:(NSString *) title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setFrame:frame];
    UIImage *newImage = [UIImage imageNamed: image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints= NO;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:12.0];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, -20.0, 0.0)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void) logoutTouched: (id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出此账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

-(void) changeTouched: (id)sender{

    [self presentLoginView];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1){
        [BWCommon logout];
        
        [self presentLoginView];
    }
}

-(void) presentLoginView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    id mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginIdentifier"];
    [self presentViewController:mainViewController animated:YES completion:^{}];

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
