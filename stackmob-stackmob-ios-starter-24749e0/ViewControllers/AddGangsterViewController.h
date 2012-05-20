//
//  AddGangsterViewController.h
//  MyGang
//
//  Created by Parag Dulam on 04/02/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import "BaseViewController.h"

@interface AddGangsterViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    IBOutlet UITableView *tableView;
    IBOutlet UISearchBar *searchBar;
    NSMutableArray *tableDataArray;
    NSMutableArray *searchResultArray;
}

@end
