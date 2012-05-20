//
//  TasksTableViewController.h
//  StackMobStarterProject
//
//  Created by Parag Dulam on 20/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "BaseViewController.h"
#import "GroupInstituteTableViewController.h"

@interface TasksTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tasksTableView;
    NSArray *tasks;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithTaskArray:(NSArray *) array;

@property(nonatomic,strong) NSArray *tasks;

@end
