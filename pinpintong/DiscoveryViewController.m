//
//  DiscoveryViewController.m
//  pinpintong
//
//  Created by Bruce on 15-4-8.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoveryTableViewCell.h"

@interface DiscoveryViewController ()

@property (nonatomic,retain) NSMutableArray *list;

@end

@implementation DiscoveryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) layoutPage{
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.view.backgroundColor = [UIColor colorWithRed:214/255.0f green:214/255.0f blue:214/255.0f alpha:1];
    
    self.navigationItem.title = @"发现";
    

    NSMutableArray *menus0 = [[NSMutableArray alloc] init];
    NSMutableDictionary *row0 = [[NSMutableDictionary alloc] init];
    [row0 setValue:@"空车渡柜" forKey:@"title"];
    UIImage *icon = [UIImage imageNamed:@"kongchedugui.png"];
    [row0 setValue:icon forKey:@"image"];
    
    [menus0 addObject:row0];
    
    NSMutableArray *menus1 = [[NSMutableArray alloc] init];
    
    row0 = [[NSMutableDictionary alloc] init];
    [row0 setValue:@"信誉榜" forKey:@"title"];
    icon = [UIImage imageNamed:@"xinyubang.png"];
    [row0 setValue:icon forKey:@"image"];
    [menus1 addObject:row0];
    
    row0 = [[NSMutableDictionary alloc] init];
    [row0 setValue:@"堆场电话" forKey:@"title"];
    icon = [UIImage imageNamed:@"duitangdianhua.png"];
    [row0 setValue:icon forKey:@"image"];
    
    [menus1 addObject:row0];
    
    row0 = [[NSMutableDictionary alloc] init];
    [row0 setValue:@"违章查询" forKey:@"title"];
    icon = [UIImage imageNamed:@"weizhangchaxun.png"];
    [row0 setValue:icon forKey:@"image"];
    
    [menus1 addObject:row0];
    
    self.list = [[NSMutableArray alloc] init];
    
    [self.list addObject:menus0];
    [self.list addObject:menus1];
    
    
    
    
    
    


}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return [self.list count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.list objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"cell0";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[DiscoveryTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    NSInteger section = [indexPath indexAtPosition:0];
    NSInteger row = [indexPath indexAtPosition:1];
    
    NSArray *data = [[NSArray alloc] initWithArray:[self.list objectAtIndex:section]];
    
    cell.textLabel.text = [[data objectAtIndex:row] objectForKey:@"title"];
    cell.imageView.image = [[data objectAtIndex:row] objectForKey:@"image"];
    
    
    
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
    //NSUInteger detail_id;
    //detail_id = [[[dataArray objectAtIndex:[indexPath row]] objectForKey:@"id"] integerValue];
    
    /*UserInfoTableViewController *userInfoTableViewController = [[UserInfoTableViewController alloc] init];
     userInfoTableViewController.hidesBottomBarWhenPushed = YES;
     
     [self.navigationController pushViewController:userInfoTableViewController animated:YES];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
