//
//  LoginViewController.m
//  MyGang
//
//  Created by Parag Dulam on 28/01/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import "LoginViewController.h"

@implementation UITextField(CustomColoredPlaceHolder)



- (void) drawPlaceholderInRect:(CGRect)rect {
//    [[UIColor colorWithRed:100.f/255.f 
//                     green:100.f/255.f 
//                      blue:100.f/255.f 
//                     alpha:1.f] setFill];
    [[UIColor grayColor] setFill];
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:16.f]];
}


@end


@implementation LoginViewController

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
//    self.title = @"Login";
    
    [self setTitleString:@"Login"];
    [loginButton.titleLabel setFont:appFont];
    [signUpButton.titleLabel setFont:appFont];
    
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


#pragma mark
#pragma mark IBActions
#pragma mark


-(BOOL) isTheUser:(NSDictionary *) user inDatabase:(NSArray *) userDB
{
    for (NSDictionary *us in userDB) {
        if ([us isEqualToDictionary:user]) {
            return YES;
        }
    }
    return NO;
}

-(IBAction)loginButtonClicked:(UIButton *)sender
{
    NSString *username = codeNameTextField.text;
    NSString *password = passwordTextField.text;
    [self loginWithUserName:username 
                andPassword:password];
}


-(void) loginWithUserName:(NSString *)username andPassword:(NSString *) password
{
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil];
    [[StackMob stackmob] loginWithArguments:args andCallback:^(BOOL success, id result) {
        if (success) {
            // Login Succeeded
            NSLog(@"Succeess");
            
            NSLog(@"result %@",result);
            
            [dataManager setCredentials:args];
            [dataManager setUserData:result];
            
//            DashboardViewController *dashboardViewController = [[DashboardViewController alloc] initWithNibName:@"DashboardViewController" bundle:nil];
//            [self.navigationController pushViewController:dashboardViewController animated:YES];
//            [dashboardViewController release];
            
            TasksTableViewController *tasksTableViewContoller = [[TasksTableViewController alloc] initWithNibName:@"TasksTableViewController" bundle:nil];
            [self.navigationController pushViewController:tasksTableViewContoller animated:YES];
            [tasksTableViewContoller release];
            
        } else {
            // Login Failed
            NSLog(@"Failed");
            CustomAlert *alertView = [[CustomAlert alloc] initWithTitle:@"Error" message:@"Invalid Login" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [CustomAlert setBackgroundColor:[UIColor grayColor] 
                            withStrokeColor:[UIColor blackColor]];
            
            [alertView show];
            [alertView release];
        }
    }];    

}


-(IBAction)signUpButtonClicked:(UIButton *)sender
{
    SignUpViewController * signUpViewController = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    [self.navigationController pushViewController:signUpViewController 
                                         animated:YES];
    [signUpViewController release];
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
    if (textField == codeNameTextField) {
        [passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}







@end


