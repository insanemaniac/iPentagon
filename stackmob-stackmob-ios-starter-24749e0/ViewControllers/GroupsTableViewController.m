//
//  GroupsTableViewController.m
//  StackMobStarterProject
//
//  Created by Parag Dulam on 13/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "GroupsTableViewController.h"

@interface GroupsTableViewController ()

@end

@implementation GroupsTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleString:@"Groups"];
    groupsArray = [[NSArray alloc] init];
    [self getUserGroups];
    groupsTableView.backgroundColor = [UIColor clearColor];
}


-(void) didRecieveUserGroups:(NSArray *)groups
{
    groupsArray = groups;
    NSLog(@"groupsArray %@",groupsArray);
    [groupsTableView reloadData];
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
#pragma mark UITableViewDataSource and UITableViewDelegate
#pragma mark


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [groupsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    NSDictionary *group = [groupsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [group objectForKey:@"group_name"];
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



@end
