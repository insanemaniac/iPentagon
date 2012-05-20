//
//  LoginViewController.h
//  MyGang
//
//  Created by Parag Dulam on 28/01/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TasksViewController.h"
#import "SignUpViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomAlert.h"
#import "DashboardViewController.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate>
{
    IBOutlet UITextField * codeNameTextField;
    IBOutlet UITextField * passwordTextField;
    
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *signUpButton;

    IBOutlet UILabel *userNameLabel;
    IBOutlet UILabel *passwordLabel;
}

-(IBAction)loginButtonClicked:(UIButton *)sender;
-(IBAction)signUpButtonClicked:(UIButton *)sender;


@end
