//
//  HabitViewController.h
//  MyGang
//
//  Created by Parag Dulam on 28/01/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TasksViewController.h"
#import "AddGangsterViewController.h"
#import "APPButton.h"
#import "CustomAlert.h"

@interface HabitViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
{
    UITableView *scheduleTableView;
    NSArray * scheduleArray;
    IBOutlet APPButton * selectScheduleButton;
    IBOutlet UILabel * dateLabel;
    
    IBOutlet APPButton * sundayButton;
    IBOutlet APPButton * mondayButton;
    IBOutlet APPButton * tuesdayButton;
    IBOutlet APPButton * wednesdayButton;
    IBOutlet APPButton * thursdayButton;
    IBOutlet APPButton * fridayButton;
    IBOutlet APPButton * saturdayButton;
    
    IBOutlet APPButton * myTasksButton;
    IBOutlet APPButton * saveButton;
    IBOutlet APPButton * addPartnerButton;
    IBOutlet UITextField *habitTextField;
    IBOutlet UITextField *descriptionTextField;
    
    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIPickerView *numberOfDaysPicker;
    IBOutlet UIButton *numberOfDaysButton;
    NSArray *numberOfDaysArray;
    
    
    IBOutlet UISlider *daysSlider;
}

-(IBAction)selectScheduleClicked:(APPButton *)sender;
-(IBAction)dayButtonClicked:(APPButton *)sender;
-(IBAction)savsButtonClicked:(APPButton *)sender;
-(IBAction)addGangsterButtonClicked:(APPButton *)sender;
-(IBAction)myTasksButtonClicked:(APPButton *)sender;
-(IBAction)cancelButtonClicked:(UIBarButtonItem *)sender;
-(IBAction)numberOfDaysButtonClicked:(UIButton *)sender;
-(IBAction)pickerValueChanged:(UIPickerView *)sender;
-(IBAction)sliderValueChanged:(UISlider *)sender;

@end
