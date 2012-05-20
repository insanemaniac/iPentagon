//
//  TasksViewController.m
//  MyGang
//
//  Created by Parag Dulam on 04/02/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import "TasksViewController.h"

@implementation TasksViewController
@synthesize tasksArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



-(void) getUserDataForUserName:(NSString *) userName
{
    StackMobQuery *q = [StackMobQuery query];
    [q field:@"username" mustEqualValue:userName];  //getting user data

    [[StackMob stackmob] get:@"user" 
                   withQuery:q 
                 andCallback:^(BOOL success, id result) {
                     [self getUserTasks];
//                     [self getUserGroupMembers];
                 }];
}




-(void) getUserGroups
{
    StackMobQuery *q = [StackMobQuery query];
    [q field:@"group_id" mustBeOneOf:[[dataManager userData] objectForKey:@"users_group"]];  //getting user data
    
    [[StackMob stackmob] get:@"group" 
                   withQuery:q 
                 andCallback:^(BOOL success, id result) {
                     // got group list for thing user's
                     
                 }];
}


-(void) getUserInstitutesForTaskDictionary:(NSMutableDictionary *) task
{
//    NSLog(@"task %@",task);
    StackMobQuery *q = [StackMobQuery query];
    [q field:@"institute_things_doing" mustEqualValue:[[task objectForKey:@"THING"] objectForKey:@"things_doing_id"]]; 
    [q setSelectionToFields:[NSArray arrayWithObjects:@"intitutename",@"institute_location ", nil]];
    
    [[StackMob stackmob] get:@"institute"
                   withQuery:q 
                 andCallback:^(BOOL success, id result) {
                     //match user_groups to group_id 
                     if (success) {
                         NSArray *userInstitutes = [[dataManager userData] objectForKey:@"users_institute"];
                         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ CONTAINS institutename",userInstitutes];
                         
                         NSMutableArray *institutes = [[NSMutableArray alloc] init];
                         for (NSDictionary *institute in result) {
                             if ([predicate evaluateWithObject:institute]) {
                                 [institutes addObject:institute];
                             }
                         }
                         [task setObject:institutes forKey:@"INSTITUTE(S)"];
                         
                         [tasksTableView reloadData];
                         
                         NSLog(@"result %@",result);
                     }
                 }];
}


-(void) getUserGroupsForTaskDictionary:(NSMutableDictionary *)task
{
//    NSLog(@"task %@",task);
    StackMobQuery *q = [StackMobQuery query];
    [q field:@"group_things_doing" mustEqualValue:[[task objectForKey:@"THING"] objectForKey:@"things_doing_id"]]; 
    [q setSelectionToFields:[NSArray arrayWithObjects:@"group_id",@"group_name", nil]];
    
    [[StackMob stackmob] get:@"group"
                   withQuery:q 
                 andCallback:^(BOOL success, id result) {
                     //match user_groups to group_id 
                     NSArray *userGroups = [[dataManager userData] objectForKey:@"users_group"];
                     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ CONTAINS group_id",userGroups];
                     
                     NSMutableArray *groups = [[NSMutableArray alloc] init];
                     for (NSDictionary *group in result) {
                         if ([predicate evaluateWithObject:group]) {
                             [groups addObject:[NSMutableDictionary dictionaryWithDictionary:group]]; //mutating a Dictionary to add data later
                         }
                     }
                     [task setObject:groups forKey:@"GROUP(S)"];
                     [self getGroupProgressForTaskDictionary:task];
                     [tasksTableView reloadData];
                     
                     NSLog(@"result %@",result);
                 }];
}



-(void)getUserProgressWhereTaskDictionary:(NSMutableDictionary *) task ForUserName:(NSString *) username
{
    NSLog(@"task %@",task);
    StackMobQuery *q = [StackMobQuery query];
    [q field:@"things_doing_progress" mustEqualValue:[[task objectForKey:@"THING"] objectForKey:@"things_doing_id"]]; 
    [q field:@"user_progress" mustEqualValue:username];
    
    [[StackMob stackmob] get:@"progress" 
                   withQuery:q 
                 andCallback:^(BOOL success, id result) {
                     NSLog(@"getUserOVERALLProgressForTodayWhereTaskDictionary %@",result);
                     [task setObject:[NSString stringWithFormat:@"%d",[result count]] forKey:@"OVERALL_PROGRESS"];
                 }];
}



-(void)getUserProgressForTodayWhereTaskDictionary:(NSMutableDictionary *) task ForUserName:(NSString *) username ForGroup:(NSMutableDictionary *) group
{
    NSLog(@"task %@",task);
    StackMobQuery *q = [StackMobQuery query];
    [q field:@"things_doing_progress" mustEqualValue:[[task objectForKey:@"THING"] objectForKey:@"things_doing_id"]]; 
    [q field:@"user_progress" mustEqualValue:username];
//    long today = [[NSDate date] timeIntervalSince1970];
//    [q field:@"lastmoddate" mustEqualValue:[NSNumber numberWithLongLong:today]];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [q field:@"date" mustEqualValue:dateString];
    [dateFormatter release];
    
    [[StackMob stackmob] get:@"progress" 
                   withQuery:q 
                 andCallback:^(BOOL success, id result) {
                     NSLog(@"getUserProgressForTodayWhereTaskDictionary %@",result);
                     if ([result count]) {
                         NSDictionary *resultDictionary = [result objectAtIndex:0]; 
                         if (![resultDictionary count]) {
                             [task setObject:@"0" forKey:@"progress_counter"];
                         } else {
                             NSInteger existing_progress_counter = [[group objectForKey:@"progress_counter"] integerValue];
                             
                             NSInteger user_progress_counter = [[resultDictionary objectForKey:@"progress_counter"] integerValue];
                             
                             if (!user_progress_counter) {
                                 [group setObject:[NSString stringWithFormat:@"%d",existing_progress_counter] forKey:@"progress_counter"];
                             } else {
                                 existing_progress_counter++;
                                 [group setObject:[NSString stringWithFormat:@"%d",existing_progress_counter] forKey:@"progress_counter"];
                             }
                         }
                         [tasksTableView reloadData];
                     }
                 }];
}




-(void) getGroupProgressForTaskDictionary:(NSMutableDictionary *) task
{
    NSLog(@"task %@",task);
    StackMobQuery *q = [StackMobQuery query];
    [q field:@"user_things" mustEqualValue:[[task objectForKey:@"THING"] objectForKey:@"things_doing_id"]]; 
    NSArray *groups = [task objectForKey:@"GROUP(S)"];
    NSLog(@"groups %@",groups);
    for (NSMutableDictionary *group in groups) {
        NSString *groupId = [group objectForKey:@"group_id"];
        [q field:@"users_group" mustEqualValue:groupId];
        
        [[StackMob stackmob] get:@"user" 
                       withQuery:q 
                     andCallback:^(BOOL success, id result) {
                         NSLog(@"USERS FOR GROUP %@",result);
                         for (NSDictionary *user in result) {
                             [self getUserProgressForTodayWhereTaskDictionary:task 
                                                                  ForUserName:[user objectForKey:@"username"] ForGroup:group];
                         }
//                         [group setObject:result forKey:@"GROUP_USERS_DOING_THING"];
//                         NSLog(@"tasksArray %@",tasksArray);
                     }];
    }
}

//-(void) getGroupMembersForGroupId:(NSString *) groupId
//{
//    
//}
//
//
//-(void) getUserGroupMembers
//{
//    NSArray *groups = [userProfileData objectForKey:@"users_group"];
//    for (NSString *groupId in groups) 
//    {
//        [self getGroupMembersForGroupId:groupId];
//    }
//}




-(void) getUserTasks
{
    StackMobQuery *q = [StackMobQuery query];
    [q field:@"things_doing_id" mustBeOneOf:[[dataManager userData] objectForKey:@"user_things"]];  //getting user data
    [q setSelectionToFields:[NSArray arrayWithObject:@"things_doing_name"]];
    
    [[StackMob stackmob] get:@"things_doing" 
                   withQuery:q 
                 andCallback:^(BOOL success, id result) {
                     NSLog(@"result %@",result);
                     NSMutableArray *tasks = [[NSMutableArray alloc] init];
                     for (NSDictionary *thing in result) {
                         NSMutableDictionary *task = [[NSMutableDictionary alloc] init];
                         [task setObject:thing forKey:@"THING"];
                         [self getUserProgressWhereTaskDictionary:task 
                                                      ForUserName:[[dataManager userData] objectForKey:@"username"]];
                         [self getUserGroupsForTaskDictionary:task];
                         [self getUserInstitutesForTaskDictionary:task];
//                         [self getGroupProgressForTaskDictionary:task];
//                         [self getUserProgressForTodayWhereTaskDictionary:task 
//                                                              ForUserName:[credentials objectForKey:@"username"]];
                         [tasks addObject:task];
                         [task release];
                     }
                     self.tasksArray = tasks;
                     [tasksTableView reloadData];
                     [tasks release];
                 }];
}


-(BOOL) isIndex:(NSNumber *) index alreadySelectedin:(NSArray *) array
{
    for (int i = 0; i < [array count]; i++) {
        if ([[array objectAtIndex: i] intValue] == [index intValue]) {
            return YES;
        }
    }
    return NO;
}


-(void) animateView
{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:5.f];
    
    int rowNumber = rand()%[tasksArray count]; 
    
    TaskGridCell *cell = (TaskGridCell *)[tasksTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowNumber inSection:0]];
    
    iCarousel *view = [cell carousel];
    NSDictionary *task = [tasksArray objectAtIndex:rowNumber];
    [view scrollToItemAtIndex:rand()%([[task objectForKey:@"GROUP(S)"] count] + [[task objectForKey:@"INSTITUTE(S)"] count]) 
                     animated:YES];
    
//    [UIView commitAnimations];;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tasksTableView.backgroundColor = [UIColor clearColor];
    tasksTableView.layer.cornerRadius = 5.f;
    
    [self setTitleString:@"Tasks"];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                               target:self action:@selector(addButtonClicked:)];
    
//    [self.navigationItem setRightBarButtonItem:addButton];
    [addButton release];
    
//    [self getUserDataForUserName:[[dataManager credentials] objectForKey:@"username"]];
    [self getUserTasks];
    tasksTableView.separatorColor = [UIColor whiteColor];
    
    
    
    
//    UISwipeGestureRecognizer * leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self 
//                                                                                                  action:@selector(cellSwiped:)];
//    [leftSwipeGestureRecognizer setDelegate:self];
//    [leftSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [tasksTableView addGestureRecognizer:leftSwipeGestureRecognizer];
//    [leftSwipeGestureRecognizer release];
//    
//    
//    
//    UISwipeGestureRecognizer * rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self 
//                                                                                                      action:@selector(cellSwiped:)];
//    [rightSwipeGestureRecognizer setDelegate:self];
//    [rightSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
//    [tasksTableView addGestureRecognizer:rightSwipeGestureRecognizer];
//    [rightSwipeGestureRecognizer release];

    
    
    
//    UISwipeGestureRecognizer * rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self 
//                                                                                                      action:@selector(cellSwiped:)];
//    [rightSwipeGestureRecognizer setDelegate:self];
//    [rightSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
//    [tasksTableView addGestureRecognizer:rightSwipeGestureRecognizer];
//    [rightSwipeGestureRecognizer release];
    
//    StackMobQuery *q = [StackMobQuery query];
//    NSString *userName = [credentials objectForKey:@"username"];  //credentials stored when userdata stored.
//    NSLog(@"userName %@",userName);
//    [q field:@"username" mustEqualValue:userName];  //getting user data
//
////    [q field:@"things_doing_progress" mustEqualValue:userName];
//    
//    
//    [[StackMob stackmob] get:@"user" 
//                   withQuery:q 
//                 andCallback:^(BOOL success, id result) {
//                     NSLog(@"result %@",result);
//                     NSDictionary *resultDict = [(NSArray *)result objectAtIndex:0] ;
////                     [resultDict writeToFile:[NSString stringWithFormat:@"%@/UserProfileData.plist"] 
////                                  atomically:YES];
//                     
//                     userProfileData = [[NSDictionary alloc] initWithDictionary:resultDict];
//                     NSArray *tasks = [resultDict objectForKey:@"user_things"];
//                     NSArray *groups = [resultDict objectForKey:@"user_group"];
//                     NSArray *institutes = [resultDict objectForKey:@"users_institute"];
//                     
//                     StackMobQuery *q = [StackMobQuery query];
//                     
//                     [q field:@"things_doing_id" mustBeOneOf:tasks];
//                     [q setSelectionToFields:[NSArray arrayWithObject:@"things_doing_name"]];
//                     [q field:@"group_id" mustEqualValue:groups];
//                     [q setSelectionToFields:[NSArray arrayWithObject:@"group_name"]];
//                     
//                     [q field:@"institute_id" mustEqualValue:institutes];
//                     [q setSelectionToFields:[NSArray arrayWithObject:@"intitutename"]];
//
//                     
//
//                     
//                     [[StackMob stackmob] get:@"things_doing" 
//                                    withQuery:q 
//                                  andCallback:^(BOOL success, id result) {
//                                      NSLog(@"things %@",result);
//                                      
//                                      self.tasksArray = result;
//                                      [tasksTableView reloadData];
//
//                                      StackMobQuery *q = [StackMobQuery query];
//                                      [q field:@"things_doing_progress" mustBeOneOf:tasks];
//                                      [q field:@"user_progress" mustEqualValue:userName];
//                                      
//                                      [[StackMob stackmob] get:@"progress" 
//                                                     withQuery:q 
//                                                   andCallback:^(BOOL success, id result) {
//                                                       NSLog(@"Progress of User for things : %@",result);
//                                                   }];
//                                      
//                                  }];
//                 }];
//    [NSTimer scheduledTimerWithTimeInterval:10.f 
//                                     target:self
//                                   selector:@selector(animateView) 
//                                   userInfo:nil 
//                                    repeats:YES];
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([gestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]]) {
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        swipedCell = (TaskCell *)[tasksTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:point.y/83.f inSection:0]];
        return YES;
    }
    return NO;
}



-(void)cellSwiped:(UISwipeGestureRecognizer *) gesture
{
    CGRect cellFrame = swipedCell.frame;
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
        {
            if (cellFrame.origin.x == 0) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.3f];
                
                cellFrame.origin.x -= cellFrame.size.width;
                swipedCell.frame = cellFrame;

                [UIView commitAnimations];
            }
        }
            break;
        case UISwipeGestureRecognizerDirectionRight:
        {
            if (cellFrame.origin.x != 0) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.3f];
                
                cellFrame.origin.x = 0;
                swipedCell.frame = cellFrame;
                
                [UIView commitAnimations];
            }
        }
            break;
        default:
            break;
    }
//    [tasksTableView reloadData];
}


-(void) addButtonClicked:(UIBarButtonItem *) btn
{
    HabitViewController *habitViewController = [[HabitViewController alloc] initWithNibName:@"HabitViewController" bundle:nil];
    [self.navigationController presentModalViewController:habitViewController animated:YES];
    [habitViewController release];
}

-(BOOL) isToday:(NSString *) today withScheduleArray:(NSArray *)scheduleArray
{
    for (NSString *day in scheduleArray) {
        if ([[day lowercaseString] isEqualToString:[today lowercaseString]]) {
            return YES;
        }
    }
    return NO;
}






- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void) dealloc 
{
    [tasksArray release];
    tasksArray = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





#pragma mark
#pragma mark UITableViewDataSource && UITableViewDelegate
#pragma mark



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasksArray count];
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    TaskCell *cell = (TaskCell *)[tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
//    if (!cell) {
//        cell = [[[TaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCell"] autorelease];
//    }
//    
//    if (indexPath.row < [tasksArray count]) {
//        NSDictionary *task = [tasksArray objectAtIndex:indexPath.row];
//        [cell setBackgroundImage:[UIImage imageNamed:@"tasks_cell_background.png"]];
//        [cell setTaskName:[[task objectForKey:@"THING"] objectForKey:@"things_doing_name"]];
//        NSArray *groups = [task objectForKey:@"GROUP(S)"];
//        NSMutableString * groupsName = [[NSMutableString alloc] init];
//        NSMutableString * groupProgress = [[NSMutableString alloc] init];
//        for (NSDictionary *group in groups) {
//            [groupsName appendFormat:@"%@,",[group objectForKey:@"group_name"]];
//            [groupProgress appendFormat:@"%@,",[group objectForKey:@"progress_counter"]];
//        }
//        [cell setGroupName:groupsName];
//        [cell setGroupProgress:groupProgress];
//        [groupProgress release];
//        [groupsName release];
//        
//        
//        NSArray *institutes = [task objectForKey:@"INSTITUTE(S)"];
//        NSMutableString * institutesName = [[NSMutableString alloc] init];
//        for (NSDictionary *institute in institutes) {
//            [institutesName appendFormat:@"%@,",[institute objectForKey:@"intitutename"]];
//        }
//        [cell setInstituteName:institutesName];
//        [cell setImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"a.jpg"],[UIImage imageNamed:@"b.jpg"],[UIImage imageNamed:@"c.jpg"],[UIImage imageNamed:@"d.jpg"],[UIImage imageNamed:@"a.jpg"],[UIImage imageNamed:@"a.jpg"], nil]];
//        [institutesName release];
//    }
//    return cell;
//}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskGridCell *cell = (TaskGridCell *)[tableView dequeueReusableCellWithIdentifier:@"TaskGridCell"];
    if (!cell) {
        cell = [[TaskGridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskGridCell"];
    }
    [cell setTask:[tasksArray objectAtIndex:indexPath.row]];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSString *taskId = [[tasksArray objectAtIndex:indexPath.row] objectForKey:@"things_doing_id"];
//    NSArray *groups = [userProfileData objectForKey:@"users_group"];
//    
//    StackMobQuery *q = [StackMobQuery query];
//    [q field:@"users_group" mustBeOneOf:groups];
//    
//    [[StackMob stackmob] get:@"user" 
//                   withQuery:q 
//                 andCallback:^(BOOL success, id result) {
//                     NSLog(@"result %@",result);
//                     
//                     NSMutableArray *usernames = [[NSMutableArray alloc] init];
//                     for (NSDictionary *userDict in result) {
//                         NSString *username = [userDict objectForKey:@"username"];
//                         [usernames addObject:username];
//                     }
//                     
//                     StackMobQuery *q = [StackMobQuery query];
////                     [q field:@"things_doing_progress" mustEqualValue:taskId];
//                     [q field:@"user_progress" mustBeOneOf:usernames];
//                     [q field:@"lastmoddate" mustEqualValue:[NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970]]];
//                     
//                     [[StackMob stackmob] get:@"progress" 
//                                    withQuery:q 
//                                  andCallback:^(BOOL success, id result) {
//                                      NSLog(@"Progress Arrray %@",result);        
//                                  }];
//                     
//                 }];
//
    
}



@end
