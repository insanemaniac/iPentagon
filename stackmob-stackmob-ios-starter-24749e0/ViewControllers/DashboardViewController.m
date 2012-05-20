//
//  DashboardViewController.m
//  StackMobStarterProject
//
//  Created by Parag Dulam on 06/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "DashboardViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//-(void) animateView
//{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:5.f];
//    
//    
//    
//    [UIView commitAnimations];;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleString:@"Dashboard"];
    dashboardItemsArray = [[NSArray alloc] initWithObjects:[NSMutableDictionary dictionaryWithObject:@"0" forKey:@"Tasks"],[NSMutableDictionary dictionaryWithObject:@"0" forKey:@"Groups"],[NSMutableDictionary dictionaryWithObject:@"0" forKey:@"Institutes"], nil];
    dashboardTableView.backgroundColor = [UIColor clearColor];
    self.navigationItem.hidesBackButton = YES;
    [self processDataForDisplayingTableView];
}




-(void) processDataForDisplayingTableView
{
    NSMutableDictionary *taskCounter = [dashboardItemsArray objectAtIndex:0];
    [taskCounter setObject:[NSString stringWithFormat:@"%d",[[[dataManager userData] objectForKey:@"user_things"] count]] forKey:@"Tasks"];
    
    
    NSMutableDictionary *groupCounter = [dashboardItemsArray objectAtIndex:1];
    [groupCounter setObject:[NSString stringWithFormat:@"%d",[[[dataManager userData] objectForKey:@"users_group"] count]] forKey:@"Groups"];
    
    
    NSMutableDictionary *instituteCounter = [dashboardItemsArray objectAtIndex:2];
    [instituteCounter setObject:[NSString stringWithFormat:@"%d",[[[dataManager userData] objectForKey:@"users_institute"] count]] forKey:@"Institutes"];
    
    [dashboardTableView reloadData];

}


-(void) profileDataDidSaveToPlist:(id)result
{
    [super profileDataDidSaveToPlist:result];
    NSLog(@"userProfileData %@",userProfileData);
    
    NSMutableDictionary *taskCounter = [dashboardItemsArray objectAtIndex:0];
    [taskCounter setObject:[NSString stringWithFormat:@"%d",[[userProfileData objectForKey:@"user_things"] count]] forKey:@"Tasks"];
    
    
    NSMutableDictionary *groupCounter = [dashboardItemsArray objectAtIndex:1];
    [groupCounter setObject:[NSString stringWithFormat:@"%d",[[userProfileData objectForKey:@"users_group"] count]] forKey:@"Groups"];

    
    NSMutableDictionary *instituteCounter = [dashboardItemsArray objectAtIndex:2];
    [instituteCounter setObject:[NSString stringWithFormat:@"%d",[[userProfileData objectForKey:@"users_institute"] count]] forKey:@"Institutes"];

    [dashboardTableView reloadData];
}

-(UIView *) getAccessoryViewWithTag:(int) tag
{
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60
                                                                     , 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [accessoryView addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    [label setText:[[[dashboardItemsArray objectAtIndex:tag] allValues] objectAtIndex:0]];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addButton addTarget:self 
                  action:@selector(addButtonClicked:) 
        forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:addButton];
    addButton.frame = CGRectMake(CGRectGetMaxX(label.frame),
                                 label.frame.origin.y,
                                 addButton.frame.size.width,
                                 addButton.frame.size.height);
    addButton.tag = tag;
    accessoryView.tag = tag;
    return accessoryView;
}


-(void) addButtonClicked:(UIButton *) sender
{
    switch (sender.tag) {
        case 0:
        {
            HabitViewController *habitViewController = [[HabitViewController alloc] initWithNibName:@"HabitViewController" bundle:nil];
//            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:habitViewController];
            [self presentModalViewController:habitViewController animated:YES];
        }

            break;
            
        default:
            break;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark
#pragma mark UITableViewDataSource && UITableViewDelegate 
#pragma mark


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dashboardItemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = [[[dashboardItemsArray objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    [cell setAccessoryView:[self getAccessoryViewWithTag:indexPath.row]];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83.f;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            TasksViewController *tasksViewController = [[TasksViewController alloc] initWithNibName:@"TasksViewController" bundle:nil];
            [self.navigationController pushViewController:tasksViewController 
                                                 animated:YES];
        }
            break;
            
        case 1:
        {
            GroupsTableViewController *groupsViewController = [[GroupsTableViewController alloc] initWithNibName:@"GroupsTableViewController" bundle:nil];
            [self.navigationController pushViewController:groupsViewController 
                                                 animated:YES];
        }
            break;
            
        case 2:
        {
            InstituteTableViewController *instituteViewController = [[InstituteTableViewController alloc] initWithNibName:@"InstituteTableViewController" bundle:nil];
            [self.navigationController pushViewController:instituteViewController 
                                                 animated:YES];
        }
            break;
 

            
        default:
            break;
    }
}



@end
