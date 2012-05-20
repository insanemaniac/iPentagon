//
//  GroupInstituteTableViewController.h
//  StackMobStarterProject
//
//  Created by Parag Dulam on 20/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "BaseViewController.h"

@interface GroupInstituteTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *detailTableView;
    NSMutableDictionary *detailDataDictionary;
    NSDictionary *taskDictionary;
}

@property(nonatomic,retain) NSDictionary *taskDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WhereTaskDictionary:(NSDictionary *)task;

@end
