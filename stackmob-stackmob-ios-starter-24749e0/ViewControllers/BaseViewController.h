//
//  BaseViewController.h
//  MyGang
//
//  Created by Parag Dulam on 28/01/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "APPButton.h"
#import "StackMob.h"
#import "DataManager.h"

@interface BaseViewController : UIViewController
{
    UIFont *appFont;    //Font to be used throughout the applications
    UILabel *titleLabel;
    APPButton *backButton;
    NSDictionary *credentials; //since NSUserDefaults is highly sucky I used a NSDictionary and cached it in UserData.plist   
    NSDictionary *userProfileData;
    DataManager *dataManager;

}

- (CTFontRef)newCustomFontWithName:(NSString *)fontName
                            ofType:(NSString *)type
                        attributes:(NSDictionary *)attributes;
-(UIFont *) getFontForFileName:(NSString *)fontFileName 
                        ofType:(NSString *)type 
                    attributes:(NSDictionary *)attributes;
-(UIFont *) getFontForFileName:(NSString *)fontFileName 
                        ofType:(NSString *)type 
                      fontsize:(float)size;

-(NSString *) getDocumentsDirectoryPath;
-(NSString *) getHabitDatabasePath;
-(NSString *) getUsersDatabasePath;
-(void) setTitleString:(NSString *)title;
-(UIFont *) getComicSansFontForSize:(float) size;
-(NSString *)today;
-(NSString *) getEventsDatabasePath;
-(NSDate *) getDateFromDateString:(NSString *) dateString;
- (NSString *)GetUUID;
-(NSDictionary *) credentials;

-(void) getUserDataForUserName:(NSString *) userName;
-(void)profileDataDidSaveToPlist:(id) result;
-(void) getUserGroups;
-(void) didRecieveUserGroups:(NSArray *) groups;
-(void) didRecieveUserInstitutes:(NSArray *) institutes;
-(void) getUserInstitutes;


@end
