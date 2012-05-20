//
//  InstituteTableViewController.h
//  StackMobStarterProject
//
//  Created by Parag Dulam on 13/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "BaseViewController.h"

@interface InstituteTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *instituteTableView;
    NSArray *institutesArray;
}

@end
