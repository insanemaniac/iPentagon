//
//  DashboardViewController.h
//  StackMobStarterProject
//
//  Created by Parag Dulam on 06/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "BaseViewController.h"
#import "TasksViewController.h"
#import "HabitViewController.h"
#import "GroupsTableViewController.h"
#import "InstituteTableViewController.h"

@interface DashboardViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *dashboardTableView;
    NSArray *dashboardItemsArray;
}
@end
