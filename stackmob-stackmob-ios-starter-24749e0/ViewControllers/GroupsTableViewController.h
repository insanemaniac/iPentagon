//
//  GroupsTableViewController.h
//  StackMobStarterProject
//
//  Created by Parag Dulam on 13/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "BaseViewController.h"

@interface GroupsTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *groupsTableView;
    NSArray *groupsArray;
}
@end
