//
//  TasksTableViewController.m
//  StackMobStarterProject
//
//  Created by Parag Dulam on 20/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "TasksTableViewController.h"

@interface TasksTableViewController ()

@end

@implementation TasksTableViewController
@synthesize tasks;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithTaskArray:(NSArray *) array
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)didRecieveTasks:(id) tasksArray
{
    self.tasks = tasksArray;
    [tasksTableView reloadData];
}

-(void) didRecieveTaskDictionary:(NSDictionary *)task
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [dataManager getTasksWhereTasks:[dataManager tasks] 
                         WhereViewController:self];
    self.navigationItem.hidesBackButton = YES;
    [self setTitleString:@"Tasks"];
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
#pragma mark UITableViewDelegate
#pragma mark


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    [cell.textLabel setText:[[tasks objectAtIndex:indexPath.row] objectForKey:@"things_doing_name"]];
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupInstituteTableViewController *groupInstituteTableViewController = [[GroupInstituteTableViewController alloc] initWithNibName:@"GroupInstituteTableViewController" 
                                                                                                                               bundle:nil WhereTaskDictionary:[tasks objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:groupInstituteTableViewController animated:YES];

}

@end
