//
//  UserInfoTableViewController.m
//  pinpintong
//
//  Created by Bruce He on 15-4-15.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "BWCommon.h"
#import "AFNetworkTool.h"
#import "MoreEditTableViewController.h"


@interface UserInfoTableViewController ()

@property (nonatomic, retain) NSMutableDictionary *userinfo;
@property (nonatomic, retain) NSMutableDictionary *userinfoLabel;
@property (nonatomic, retain) NSArray *keys;

@end

@implementation UserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.view.backgroundColor = [UIColor colorWithRed:214/255.0f green:214/255.0f blue:214/255.0f alpha:1];
    
    
    
    
    self.navigationItem.title = @"用户信息";
 
    //init label name
    self.userinfoLabel = [[NSMutableDictionary alloc] init];
    
    [self.userinfoLabel setValue:@"用户名" forKey:@"username"];
    [self.userinfoLabel setValue:@"地址" forKey:@"address"];
    [self.userinfoLabel setValue:@"QQ" forKey:@"qq"];
    [self.userinfoLabel setValue:@"公司名称" forKey:@"company"];
    [self.userinfoLabel setValue:@"手机号" forKey:@"mobile"];
    
    
    self.keys = [[NSArray alloc] initWithObjects:@"username",@"mobile",@"qq",@"address",@"company", nil];
    
    [self loadData:[[BWCommon getUserInfo:@"uid"] integerValue]];

}

-(void) renderUserInfo: (NSDictionary *) uinfo {

}

- (void) loadData:(NSUInteger) uid{
    
    NSString *api_url = [BWCommon getBaseInfo:@"api_url"];
    NSString *list_url = [api_url stringByAppendingString:@"getUserInfoByUid"];
    list_url = [list_url stringByAppendingFormat:@"?uid=%lu",uid];
    
    //NSLog(@"%@",list_url);
    //load data
    [AFNetworkTool JSONDataWithUrl:list_url success:^(id json) {
        NSString *result = [json objectForKey:@"result"];
        
        if([result  isEqual:@"ok"])
        {
            self.userinfo = [[NSMutableDictionary alloc] init];
            self.userinfo = [json objectForKey:@"userinfo"];
            
            //NSLog(@"%@",self.userinfo);
            
            [self.tableView reloadData];
            //NSLog(@"%@",[json objectForKey:@"userinfo"]);
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.userinfoLabel count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"cell0";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    //NSInteger section = [indexPath indexAtPosition:0];
    
    NSString *key = [self.keys objectAtIndex:[indexPath indexAtPosition:1]];
    
    //NSLog(@"%@",[self.userinfo objectForKey:key]);
    
    cell.textLabel.text = [self.userinfoLabel objectForKey:key];
    cell.detailTextLabel.text = [self.userinfo objectForKey:key];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithRed:214/255.0f green:214/255.0f blue:214/255.0f alpha:1];
    return myView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *key = [self.keys objectAtIndex:[indexPath indexAtPosition:1]];
    
    
    MoreEditTableViewController *moreEditTableViewController = [[MoreEditTableViewController alloc] init];
    
    //moreEditTableViewController.hidesBottomBarWhenPushed = YES;
    
    
    
    [self presentViewController:moreEditTableViewController animated:YES completion:^(void){
        
    }];
    
    //NSUInteger detail_id;
    //detail_id = [[[dataArray objectAtIndex:[indexPath row]] objectForKey:@"id"] integerValue];
    
    /*UserInfoTableViewController *userInfoTableViewController = [[UserInfoTableViewController alloc] init];
    userInfoTableViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:userInfoTableViewController animated:YES];
    */

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate setValue:key];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
