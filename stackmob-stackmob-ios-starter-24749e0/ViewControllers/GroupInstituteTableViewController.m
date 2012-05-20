//
//  GroupInstituteTableViewController.m
//  StackMobStarterProject
//
//  Created by Parag Dulam on 20/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "GroupInstituteTableViewController.h"

@interface GroupInstituteTableViewController ()

@end

@implementation GroupInstituteTableViewController
@synthesize taskDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WhereTaskDictionary:(NSDictionary *)task
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.taskDictionary = task;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    detailDataDictionary = [[NSMutableDictionary alloc] init];
    [self setTitleString:@"Details"];

    [dataManager getUserGroupsWhereTask:taskDictionary 
             andCallBackViewConrtroller:self];
    [dataManager getUserInstitutesWhereTask:taskDictionary 
                 andCallBackViewConrtroller:self];
}


-(void) didRecieveUserInstitutesForTask:(id)institutes
{
    [detailDataDictionary setObject:institutes forKey:INSTITUTE];
    [detailTableView reloadData];
}

-(void)didRecieveUserGroupsForTask:(id) groups
{
    [detailDataDictionary setObject:groups forKey:GROUP];
    [detailTableView reloadData];
}


-(void) didRecieveGroupDictionary:(id)group
{
    
}


-(void) didRecieveGroups:(id)groups
{
    
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[detailDataDictionary allKeys] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [[detailDataDictionary objectForKey:GROUP] count];
            break;
        case 1:
            return [[detailDataDictionary objectForKey:INSTITUTE] count];
            break;
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    NSString *titleString = @"";
    switch (indexPath.section) {
        case 0:
        {
            NSArray *groups = [detailDataDictionary objectForKey:GROUP];
            NSDictionary *group = [groups objectAtIndex:indexPath.row];
            titleString = [group objectForKey:@"group_name"];
        }
            break;
        case 1:
        {
            NSArray *institutes = [detailDataDictionary objectForKey:INSTITUTE];
            NSDictionary *institute = [institutes objectAtIndex:indexPath.row];
            titleString = [institute objectForKey:@"institutename"];
        }
            break;
        default:
            break;
    }
    cell.textLabel.text = titleString;
    return cell;
}


-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Groups";
            break;
        case 1:
            return @"Institutes";
            break;
        default:
            break;
    }
    return nil;
}




@end
