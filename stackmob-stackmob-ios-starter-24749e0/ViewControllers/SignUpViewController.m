//
//  SignUpViewController.m
//  MyGang
//
//  Created by Parag Dulam on 27/02/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import "SignUpViewController.h"

@implementation SignUpViewController

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
    emailTextField.font = appFont;
    passwordTextField.font = appFont;
    rePasswordTextField.font = appFont;
    
    emailLabel.font = appFont;
    passwordLabel.font = appFont;
    rePasswordLabel.font = appFont;
    
    [self setTitleString:@"Sign Up"];

    backButton.hidden = NO;
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




-(BOOL) isTheEmailID:(NSString *) emailId presentInDbatabase:(NSArray *) userDB
{
    for (NSDictionary *user in userDB) {
        if ([[user objectForKey:@"Email"] isEqualToString:emailId]) {
            return YES;
        }
    }
    return NO;
}

-(IBAction)signUpButtonClicked:(UIButton *)sender
{
//    if ([passwordTextField.text isEqualToString:rePasswordTextField.text]) {
//        NSDictionary *usersDictionary = [[NSDictionary alloc] initWithContentsOfFile:[self getUsersDatabasePath]];
//        NSMutableArray *users = [NSMutableArray arrayWithArray:[usersDictionary objectForKey:@"Users"]];
//        
//        NSDictionary *user = [NSDictionary dictionaryWithObjectsAndKeys:emailTextField.text,@"Email",passwordTextField.text,@"Password", nil];
//        
//        if (![self isTheEmailID:emailTextField.text 
//             presentInDbatabase:users]) {
//            [users addObject:user];
//            
//            [[NSDictionary dictionaryWithObject:users forKey:@"Users"] writeToURL:[NSURL fileURLWithPath:[self getUsersDatabasePath]] atomically:YES];
//            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"User added Successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//            [alertView show];
//            [alertView release];
//
//        }
//        
//    }
    
    if ([emailTextField.text length] && [passwordTextField.text length] && [rePasswordTextField.text length] && [usernameTextField.text length]) 
    {
        if ([passwordTextField.text isEqualToString:rePasswordTextField.text]) 
        {
            //adding a note for Email Validation remaining.
            
            NSDictionary *arguments = [NSDictionary dictionaryWithObjectsAndKeys:usernameTextField.text,@"username",passwordTextField.text,@"password",emailTextField.text,@"user_email", nil];
            
            [[StackMob stackmob] post:@"user"      
                        withArguments:arguments 
                          andCallback:^(BOOL success, id result) {
                              UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Log In to your Email Account and Confirm your Registration within 48 hours." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                              [successAlertView show];
                          }];

        }
    }
    
}


#pragma mark
#pragma mark UIAlertViewDelegate
#pragma mark


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    [self.navigationController popViewControllerAnimated:YES];
    NSDictionary *arguments = [NSDictionary dictionaryWithObjectsAndKeys:usernameTextField.text,@"username",passwordTextField.text,@"password", nil];
    [[StackMob stackmob] loginWithArguments:arguments 
                                andCallback:^(BOOL success, id result) {
                                    NSError *error = nil;
                                    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/UserData.plist",[self getDocumentsDirectoryPath]] error:&error];
                                    
                                    DashboardViewController *dashBoardViewController = [[DashboardViewController alloc] initWithNibName:@"DashboardViewController" bundle:nil];
                                    [self.navigationController pushViewController:dashBoardViewController animated:YES];
                                    credentials = arguments;
                                    [credentials writeToFile:[NSString stringWithFormat:@"%@/UserData.plist",[self getDocumentsDirectoryPath]] atomically:YES];
                                    
                                }];
}




#pragma mark
#pragma mark UITextFieldDelegate
#pragma mark

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == rePasswordTextField || textField == passwordTextField) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.2f];
        scrollView.contentOffset = CGPointMake(0, 100.f);
        [UIView commitAnimations];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == rePasswordTextField || textField == passwordTextField) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.2f];
        scrollView.contentOffset = CGPointMake(0, 0);
        [UIView commitAnimations];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (emailTextField == textField) {
        [passwordTextField becomeFirstResponder];
    } else if(passwordTextField == textField) {
        [rePasswordTextField becomeFirstResponder];
    } else if(rePasswordTextField == textField) {
        [rePasswordTextField resignFirstResponder];
    }
    return YES;
}


@end
