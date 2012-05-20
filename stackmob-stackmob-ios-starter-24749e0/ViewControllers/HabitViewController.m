//
//  HabitViewController.m
//  MyGang
//
//  Created by Parag Dulam on 28/01/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import "HabitViewController.h"

@implementation HabitViewController

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    scheduleArray = [[NSArray alloc] initWithObjects:@"Daily",@"Weekly(Select Days)", nil];
    scheduleTableView = [[UITableView alloc] initWithFrame:CGRectMake(selectScheduleButton.frame.origin.x, CGRectGetMaxY(selectScheduleButton.frame), selectScheduleButton.frame.size.width, 0) style:UITableViewStylePlain];
    [self.view addSubview:scheduleTableView];
    [scheduleTableView release];
    scheduleTableView.delegate = self;
    scheduleTableView.dataSource = self;
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM YYYY"];
    dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    [dateLabel setFont:appFont];
    [dateFormatter release];
    [self tableView:scheduleTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    
    [selectScheduleButton.titleLabel setFont:appFont ];
    [sundayButton.titleLabel setFont:appFont];
    [mondayButton.titleLabel setFont:appFont];
    [tuesdayButton.titleLabel setFont:appFont];
    [wednesdayButton.titleLabel setFont:appFont];
    [thursdayButton.titleLabel setFont:appFont];
    [fridayButton.titleLabel setFont:appFont];
    [saturdayButton.titleLabel setFont:appFont];
    [myTasksButton.titleLabel setFont:appFont];
    [saveButton.titleLabel setFont:appFont];
    [addPartnerButton.titleLabel setFont:appFont];
    [habitTextField setFont:appFont];
    
    
    
    APPButton *logOutButton = [[APPButton alloc] init];
    [logOutButton.titleLabel setFont:[self getFontForFileName:@"ComicSans" 
                                                       ofType:@"ttf" 
                                                     fontsize:10.f]];
    [logOutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logOutButton setTitle:@"Log Out" forState:UIControlStateNormal];
    logOutButton.frame = CGRectMake(0, 0, 50.f, 25.f);
    [logOutButton addTarget:self 
                     action:@selector(logoutButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
    logOutButton.layer.cornerRadius = 5.f;
    
    UIBarButtonItem *logOutBarButton = [[UIBarButtonItem alloc] initWithCustomView:logOutButton];
    [logOutButton release];
    self.navigationItem.rightBarButtonItem = logOutBarButton;
    [logOutBarButton release];
    [self setTitleString:@"Add a Habit"];
    
    saveButton.layer.cornerRadius = 5.f;
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton.titleLabel setFont:appFont];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    myTasksButton.layer.cornerRadius = 5.f;
    [myTasksButton setTitle:@"My Tasks" forState:UIControlStateNormal];
    [myTasksButton.titleLabel setFont:appFont];
    [myTasksButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    addPartnerButton.layer.cornerRadius = 5.f;
    [addPartnerButton setTitle:@"Add Partner" forState:UIControlStateNormal];
    [addPartnerButton.titleLabel setFont:appFont];
    [addPartnerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    navBar.tintColor = [UIColor darkGrayColor];
    titleLabel.text = @"Add a Task";
    [navBar.topItem setTitleView:titleLabel];
    numberOfDaysArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    numberOfDaysPicker.delegate = self;
    numberOfDaysPicker.dataSource = self;
    [self pickerView:numberOfDaysPicker 
        didSelectRow:0 
         inComponent:0];
//    [self myTasksButtonClicked:myTasksButton];
    [self sliderValueChanged:daysSlider];
}


-(IBAction)sliderValueChanged:(UISlider *)sender
{
    [numberOfDaysButton setTitle:[NSString stringWithFormat:@"%@ days a week",[numberOfDaysArray objectAtIndex:floor(sender.value - 1)]] 
                        forState:UIControlStateNormal];
}


-(IBAction)pickerValueChanged:(UIPickerView *)sender
{
//    [numberOfDaysButton setTitle:[numberOfDaysArray objectAtIndex:sender] forState:<#(UIControlState)#>]
}

-(IBAction)numberOfDaysButtonClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3f];
    
    CGRect numberOfDaysPickerFrame = numberOfDaysPicker.frame;
    if (sender.selected) {
        numberOfDaysPickerFrame.origin.y = 246.f;
    } else {
        numberOfDaysPickerFrame.origin.y = 460.f;
    }
    numberOfDaysPicker.frame = numberOfDaysPickerFrame;
    
    [UIView commitAnimations];
}




-(IBAction)cancelButtonClicked:(UIBarButtonItem *)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc {
    [scheduleArray release];
    scheduleArray = nil;
    [super dealloc];
}


#pragma mark
#pragma mark TableViewDelegate
#pragma mark


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [scheduleArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:@"Cell"] autorelease];
    }
    [cell.textLabel  setFont:appFont];
    cell.textLabel.text = [scheduleArray objectAtIndex:indexPath.row];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [selectScheduleButton setTitle:[scheduleArray objectAtIndex:indexPath.row] 
                          forState:UIControlStateNormal];
    selectScheduleButton.selected = YES;
    [self selectScheduleClicked:selectScheduleButton];  
    if (!indexPath.row) {
        mondayButton.selected = YES;
        tuesdayButton.selected = YES;
        wednesdayButton.selected = YES;
        thursdayButton.selected = YES;
        fridayButton.selected = YES;
        saturdayButton.selected = YES;
        sundayButton.selected = YES;
        
        mondayButton.userInteractionEnabled = NO;
        tuesdayButton.userInteractionEnabled = NO;
        wednesdayButton.userInteractionEnabled = NO;
        thursdayButton.userInteractionEnabled = NO;
        fridayButton.userInteractionEnabled = NO;
        saturdayButton.userInteractionEnabled = NO;
        sundayButton.userInteractionEnabled = NO;

    } else {
        mondayButton.selected = NO;
        tuesdayButton.selected = NO;
        wednesdayButton.selected = NO;
        thursdayButton.selected = NO;
        fridayButton.selected = NO;
        saturdayButton.selected = NO;
        sundayButton.selected = NO;
        
        mondayButton.userInteractionEnabled = YES;
        tuesdayButton.userInteractionEnabled = YES;
        wednesdayButton.userInteractionEnabled = YES;
        thursdayButton.userInteractionEnabled = YES;
        fridayButton.userInteractionEnabled = YES;
        saturdayButton.userInteractionEnabled = YES;
        sundayButton.userInteractionEnabled = YES;

    }
}



#pragma mark
#pragma mark IBActions
#pragma mark


-(void)logoutButtonClicked:(UIBarButtonItem *) btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



-(IBAction)dayButtonClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    switch (sender.tag) {
        case 0:
            //monday
            break;
        case 1:
            //tuesday
            break;
        case 2:
            //wednesday
            break;
        case 3:
            //thursday
            break;
        case 4:
            //friday
            break;
        case 5:
            //saturday
            break;
        case 6:
            //sunday
            break;
        default:
            break;
    }    
}


-(IBAction)selectScheduleClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    CGRect scheduleTableViewFrame = scheduleTableView.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.f];
    if (sender.selected) {
        scheduleTableViewFrame.size.height = [scheduleArray count] * 44.f;
    } else {
        scheduleTableViewFrame.size.height = 0;
    }
    scheduleTableView.frame = scheduleTableViewFrame;
    [UIView commitAnimations];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self cancelButtonClicked:nil];
}


-(IBAction)savsButtonClicked:(UIButton *)sender 
{
    if ([descriptionTextField.text length]) {
        [[StackMob stackmob] post:@"things_doing" 
                    withArguments:[NSDictionary dictionaryWithObjectsAndKeys:descriptionTextField.text,@"things_doing_name", nil] 
                      andCallback:^(BOOL success, id result) {
                          if (success) {
                              NSLog(@"result %@",result);
                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sucess" 
                                                                                  message:[result description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                              [alertView show];
                          }
                      }];
    }
    
    
    //check if the database plist file exits
    //if present  {
        //read the entire data first
        //add our additional Habit Dictionary into this data
    //}
        
    //rewrite the data to plist
    
    
//    if (![habitTextField.text length]) {
//        CustomAlert *alertView = [[CustomAlert alloc] initWithTitle:@"Error" message:@"Please Enter some Habit name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
////        alertView.backgroundColor = [UIColor lightGrayColor];
//        [CustomAlert setBackgroundColor:[UIColor grayColor] 
//                        withStrokeColor:[UIColor blackColor]];
//        
//        [alertView show];
//        [alertView release];
//
//        return;
//    }
//    
//    NSString *habitDBPath = [self getHabitDatabasePath];
//    
//    NSDictionary *habitDictionary = [NSDictionary dictionaryWithContentsOfFile:habitDBPath];
//    
//    if ([[habitDictionary objectForKey:@"Habits"] count] < 5) {
//        NSMutableArray *existingHabits = [habitDictionary objectForKey:@"Habits"];
//        NSMutableArray *days = [NSMutableArray arrayWithCapacity:7];
//        if (mondayButton.selected) {
//            [days addObject:@"Monday"];
//        } 
//        if(tuesdayButton.selected) {
//            [days addObject:@"Tuesday"];
//        } 
//        if(wednesdayButton.selected) {
//            [days addObject:@"Wednesday"];
//        } 
//        if(thursdayButton.selected) {
//            [days addObject:@"Thursday"];
//        } 
//        if(fridayButton.selected) {
//            [days addObject:@"Friday"];
//        } 
//        if(saturdayButton.selected) {
//            [days addObject:@"Saturday"];
//        } 
//        if(sundayButton.selected) {
//            [days addObject:@"Sunday"];
//        }
//        NSDictionary *habit = [NSDictionary dictionaryWithObjectsAndKeys:habitTextField.text,@"Habit",dateLabel.text,@"Date",selectScheduleButton.titleLabel.text,@"Schedule Type",days,@"Schedule",[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"],@"Email",@"0",@"CheckIns",@"0",@"TotalCheckIns",[self GetUUID],@"HabitId", nil];
//        if (!existingHabits) {
//            existingHabits = [NSMutableArray array];
//        }
//        [existingHabits addObject:habit];
//        NSDictionary *dict = [NSDictionary dictionaryWithObject:existingHabits forKey:@"Habits"];
//        [dict writeToURL:[NSURL fileURLWithPath:habitDBPath] 
//              atomically:YES];
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Habit added successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//        [alertView show];
//        [alertView release];
//
//        
//    } else {
//        NSLog(@"cant add more habits");
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You cannot add more Habits" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//        [alertView show];
//        [alertView release];
//    }
    
    
    [[StackMob stackmob] post:@"things_doing" 
                withArguments:[NSDictionary dictionaryWithObjectsAndKeys:habitTextField.text,@"things_doing_name",descriptionTextField.text,@"things_doing_description", nil] 
                  andCallback:^(BOOL success, id result) {
                      if (success) {
                          NSLog(@"yaaaaahooooo");
                      } else {
                          NSLog(@"Noooooooooooo");
                      }
                  }];
    
}
 


-(IBAction)addGangsterButtonClicked:(UIButton *)sender
{
    AddGangsterViewController *addGangsterViewController = [[AddGangsterViewController alloc] initWithNibName:@"AddGangsterViewController" bundle:nil];
    [self.navigationController pushViewController:addGangsterViewController animated:YES];
    [addGangsterViewController release];
}
-(IBAction)myTasksButtonClicked:(UIButton *)sender
{
    TasksViewController * tasksViewController = [[TasksViewController alloc] initWithNibName:@"TasksViewController" bundle:nil];
    [self.navigationController pushViewController:tasksViewController animated:YES];
    [tasksViewController release];
}




#pragma mark
#pragma mark UITextFieldDelegate
#pragma mark




//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
//- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



#pragma mark
#pragma mark UIPickerViewDataSource,UIPickerViewDelegate
#pragma mark



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [numberOfDaysArray count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [numberOfDaysArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [numberOfDaysButton setTitle:[numberOfDaysArray objectAtIndex:row] 
                        forState:UIControlStateNormal];
}




@end
