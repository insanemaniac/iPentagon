//
//  TasksViewController.h
//  MyGang
//
//  Created by Parag Dulam on 04/02/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import "BaseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TaskCell.h"
#import "HabitViewController.h"
#import "TaskGridCell.h"

@interface TasksViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *tasksTableView;
    NSMutableArray *tasksArray;    
    TaskCell *swipedCell;
}


@property(nonatomic,retain) NSMutableArray *tasksArray;


-(BOOL) isIndex:(NSNumber *) index alreadySelectedin:(NSArray *) array;
-(void) createGrids;
-(BOOL) isHabitWithId:(NSString *) habitId WithTimeStamp:(NSString *) dateString alreadyInEventDataBase:(NSArray *) events;
//-(BOOL) istheDay:(NSString *)day fromHabitSchedule:(NSArray *) aray;



@end
