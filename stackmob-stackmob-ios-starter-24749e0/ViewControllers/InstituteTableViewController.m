//
//  InstituteTableViewController.m
//  StackMobStarterProject
//
//  Created by Parag Dulam on 13/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "InstituteTableViewController.h"

@interface InstituteTableViewController ()

@end

@implementation InstituteTableViewController

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
    
    [self setTitleString:@"Institutes"];
    institutesArray = [[NSArray alloc] init];
    [self getUserInstitutes];
    instituteTableView.backgroundColor = [UIColor clearColor];
}



-(void) didRecieveUserInstitutes:(NSArray *)institutes
{
    institutesArray = institutes;
    [instituteTableView reloadData];
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
    return [institutesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    NSDictionary *institute = [institutesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [institute objectForKey:@"intitutename"];
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
