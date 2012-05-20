//
//  BaseViewController.m
//  MyGang
//
//  Created by Parag Dulam on 28/01/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

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


-(void)dealloc {
    [credentials release];
    [appFont release];
    [super dealloc];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(NSDictionary *) credentials
{
    return [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/UserCredentials.plist",[self getDocumentsDirectoryPath]]];
}


-(void)didRecieveUserInstitutesForTask:(id) institutes
{
    
}

-(void)didRecieveUserGroupsForTask:(id) groups
{
    
}


-(void)didRecieveTasks:(id) tasks
{
    
}

-(void)didRecieveGroups:(id) groups
{
    
}

-(void)didRecieveGroupDictionary:(id) group
{
    
}

-(void) didRecieveTaskDictionary:(NSDictionary *)task
{
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //code here
    
    
//    self.view.backgroundColor = [UIColor colorWithRed:254.f/255.f
//                                                green:254.f/255.f 
//                                                 blue:214.f/255.f 
//                                                alpha:1.f];
    
    self.view.backgroundColor = [UIColor blackColor];

    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"base@2x.png"]];
    backgroundImageView.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];
    [backgroundImageView release];
    
    
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:223.f/255.f
//                                                                        green:227.f/255.f 
//                                                                         blue:133.f/255.f 
//                                                                        alpha:1.f];
    
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = self.view.bounds;
//    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0 green:152.f/255.f blue:182.f/255.f alpha:1.f] CGColor],(id)[[UIColor colorWithRed:0 green:115.f/255.f blue:132.f/255.f alpha:1.f] CGColor], nil];
//    [self.view.layer insertSublayer:gradientLayer atIndex:0];

    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];

    
//    UIFont *font = [self getFontForFileName:@"kilogram_kg" 
//                                     ofType:@"ttf" 
//                                 attributes:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:14.f] forKey:(NSString *)kCTFontSizeAttribute]];
    UIFont *font = [UIFont fontWithName:@"Kilogram" size:16.f];
    appFont = [font retain];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    titleLabel.font = [UIFont boldSystemFontOfSize:24.f];
    [titleLabel setText:@"Login"];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [self.navigationItem setTitleView:titleLabel];
    [titleLabel release];
    
//    self.navigationItem.hidesBackButton = YES;

    
//    backButton = [[APPButton alloc] init];
//    backButton.frame = CGRectMake(0, 0, 40, 25);
//    [backButton.titleLabel setFont:[self getComicSansFontForSize:11.f]];
//    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    backButton.layer.cornerRadius = 5.f;
//    [backButton addTarget:self 
//                   action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [backButton setTitle:@"Back" forState:UIControlStateNormal];
//    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    [backButton release];
//    [self.navigationItem setLeftBarButtonItem:backBarButton];
//    [backBarButton release];
//    
//    backButton.hidden = YES;

    dataManager = [DataManager sharedSingleton];
    
    credentials = [[NSDictionary alloc] initWithDictionary:[self credentials]];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/UserData.plist",[self getDocumentsDirectoryPath]];
    userProfileData = [[NSDictionary alloc] initWithContentsOfFile:filePath];
}


-(void) setTitleString:(NSString *)title
{
    titleLabel.text = title;
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






- (CTFontRef)newCustomFontWithName:(NSString *)fontName
                            ofType:(NSString *)type
                        attributes:(NSDictionary *)attributes
{
    NSString *fontPath = [[NSBundle mainBundle] pathForResource:fontName ofType:type];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:fontPath];
    CGDataProviderRef fontProvider = CGDataProviderCreateWithCFData((CFDataRef)data);
    [data release];
    
    CGFontRef cgFont = CGFontCreateWithDataProvider(fontProvider);
    CGDataProviderRelease(fontProvider);
    
    CTFontDescriptorRef fontDescriptor = CTFontDescriptorCreateWithAttributes((CFDictionaryRef)attributes);
    CTFontRef font = CTFontCreateWithGraphicsFont(cgFont, 0, NULL, fontDescriptor);
    CFRelease(fontDescriptor);
    CGFontRelease(cgFont);
    return font;
}


-(UIFont *) getFontForFileName:(NSString *)fontFileName 
                        ofType:(NSString *)type 
                    attributes:(NSDictionary *)attributes
{
    CTFontRef canHazComicSans = [self newCustomFontWithName:fontFileName 
                                                     ofType:type 
                                                 attributes:attributes];
    NSString *fontName = [(NSString *)CTFontCopyName(canHazComicSans, kCTFontPostScriptNameKey) autorelease];
    CGFloat fontSize = CTFontGetSize(canHazComicSans);
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
//    UIFont *font = [UIFont systemFntOfSize:fontSize];

    return font;
}


-(UIFont *) getFontForFileName:(NSString *)fontFileName 
                        ofType:(NSString *)type 
                      fontsize:(float)size
{
    CTFontRef canHazComicSans = [self newCustomFontWithName:fontFileName 
                                                     ofType:type 
                                                 attributes:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:size] forKey:(NSString *)kCTFontSizeAttribute]];
    NSString *fontName = [(NSString *)CTFontCopyName(canHazComicSans, kCTFontPostScriptNameKey) autorelease];
    CGFloat fontSize = CTFontGetSize(canHazComicSans);
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    return font;
}

-(UIFont *) getComicSansFontForSize:(float) size
{
    return [self getFontForFileName:@"ComicSans"
                             ofType:@"ttf" 
                           fontsize:size];
}

-(NSString *) getDocumentsDirectoryPath
{
    NSArray *dirPaths;
    NSString *docsDir;

    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                   NSUserDomainMask, YES);

    docsDir = [dirPaths objectAtIndex:0];
    return docsDir;
}



-(NSString *) getEventsDatabasePath
{
    return [NSString stringWithFormat:@"%@/%@",[self getDocumentsDirectoryPath],EVENTS_DB_NAME];
}



-(NSString *) getHabitDatabasePath
{
    return [NSString stringWithFormat:@"%@/%@",[self getDocumentsDirectoryPath],HABIT_DB_NAME];
}



-(NSString *) getUsersDatabasePath
{
    return [NSString stringWithFormat:@"%@/%@",[self getDocumentsDirectoryPath],USER_DB_NAME];
}


-(void)backButtonClicked:(UIButton *) button
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(NSString *)today
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    return today;
}


-(NSDate *) getDateFromDateString:(NSString *) dateString
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
} 






- (NSString *)GetUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return [(NSString *)string autorelease];
}



#pragma mark
#pragma mark API Call Methods
#pragma mark




-(void)profileDataDidSaveToPlist:(id) result
{
    userProfileData = [[NSDictionary alloc] initWithDictionary:[result objectAtIndex:0]];
    NSString *filePath = [NSString stringWithFormat:@"%@/UserData.plist",[self getDocumentsDirectoryPath]];
    NSLog(@"filePath %@",filePath);
    if ([userProfileData writeToFile:filePath 
                          atomically:YES]) {
        NSLog(@"Success");
    } else {
        NSLog(@"Failure");
    }
}


-(void) getUserDataForUserName:(NSString *) userName
{
    StackMobQuery *q = [StackMobQuery query];
    [q field:@"username" mustEqualValue:userName];  //getting user data
    
    [[StackMob stackmob] get:@"user" 
                   withQuery:q 
                 andCallback:^(BOOL success, id result) {
                     if (success) {
                         [self profileDataDidSaveToPlist:result];
                     } 
                 }];
}



-(void) didRecieveUserGroups:(NSArray *) groups
{
    
}


-(void) didRecieveUserInstitutes:(NSArray *) institutes
{
    
}



-(void) getUserInstitutes
{
    StackMobQuery *q = [StackMobQuery query];
    NSLog(@"userProfileData %@",userProfileData);
    [q field:@"intitutename" mustBeOneOf:[userProfileData objectForKey:@"users_institute"]];  //getting user data
    
    [[StackMob stackmob] get:@"institute" 
                   withQuery:q 
                 andCallback:^(BOOL success, id result) {
                     // got group list for thing user's
                     if (success) {
                         //strange thing Institute name should not have spaces.
                         [self didRecieveUserInstitutes:result];
                     }
                 }];
}


-(void) getUserGroups
{
    StackMobQuery *q = [StackMobQuery query];
    NSLog(@"userProfileData %@",userProfileData);
    [q field:@"group_id" mustBeOneOf:[userProfileData objectForKey:@"users_group"]];  //getting user data
    
    [[StackMob stackmob] get:@"group" 
                   withQuery:q 
                 andCallback:^(BOOL success, id result) {
                     // got group list for thing user's
                     [self didRecieveUserGroups:result];
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
                     NSArray *userInstitutes = [userProfileData objectForKey:@"users_institute"];
                     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ CONTAINS intitutename",userInstitutes];
                     
                     NSMutableArray *institutes = [[NSMutableArray alloc] init];
                     for (NSDictionary *institute in result) {
                         if ([predicate evaluateWithObject:institute]) {
                             [institutes addObject:institute];
                         }
                     }
                     [task setObject:institutes forKey:@"INSTITUTE(S)"];
                     NSLog(@"result %@",result);
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
                     NSArray *userGroups = [userProfileData objectForKey:@"users_group"];
                     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ CONTAINS group_id",userGroups];
                     
                     NSMutableArray *groups = [[NSMutableArray alloc] init];
                     for (NSDictionary *group in result) {
                         if ([predicate evaluateWithObject:group]) {
                             [groups addObject:[NSMutableDictionary dictionaryWithDictionary:group]]; //mutating a Dictionary to add data later
                         }
                     }
                     [task setObject:groups forKey:@"GROUP(S)"];
                     [self getGroupProgressForTaskDictionary:task];
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
                     }];
    }
}


-(void) getUserTasks
{
    StackMobQuery *q = [StackMobQuery query];
    [q field:@"things_doing_id" mustBeOneOf:[userProfileData objectForKey:@"user_things"]];  //getting user data
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
                                                      ForUserName:[userProfileData objectForKey:@"username"]];
                         [self getUserGroupsForTaskDictionary:task];
                         [self getUserInstitutesForTaskDictionary:task];
                         [tasks addObject:task];
                         [task release];
                     }
                     [tasks release];
                 }];
}



@end
