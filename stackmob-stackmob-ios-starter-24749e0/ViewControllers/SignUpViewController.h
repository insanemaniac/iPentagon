//
//  SignUpViewController.h
//  MyGang
//
//  Created by Parag Dulam on 27/02/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import "BaseViewController.h"
#import "DashboardViewController.h"

@interface SignUpViewController : BaseViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *emailTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UITextField *rePasswordTextField;
    IBOutlet UITextField *usernameTextField;

    
    IBOutlet UILabel *emailLabel;
    IBOutlet UILabel *passwordLabel;
    IBOutlet UILabel *rePasswordLabel;
    IBOutlet UILabel *usernameLabel;

    IBOutlet UIScrollView *scrollView;
}


-(IBAction)signUpButtonClicked:(UIButton *)sender;

@end
