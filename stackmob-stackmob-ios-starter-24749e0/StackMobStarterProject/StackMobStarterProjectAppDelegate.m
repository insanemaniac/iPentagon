//
//  StackMobStarterProjectAppDelegate.m
//  StackMobStarterProject
//
//  Created by Ty Amell on 12/15/11.
//  Copyright 2011 StackMob. All rights reserved.
//

#import "StackMobStarterProjectAppDelegate.h"
#import "StackMob.h"

@implementation StackMobStarterProjectAppDelegate
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[StackMob stackmob] startSession];

//    [[StackMob stackmob] get:@"user" 
//               withArguments:[NSDictionary dictionaryWithObject:@"sandeepdeshmukh" 
//                                                         forKey:@"username"] 
//                 andCallback:^(BOOL success, id result) {
//                     NSString *resultString = (NSString *)result;
//                     NSLog(@"%@",resultString);
//                 }];
    
    
    
//    NSString *username = @"Parag";
//    NSString *password = @"parag";
//    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil];
//    
//    [[StackMob stackmob] loginWithArguments:args andCallback:^(BOOL success, id result) {
//        if (success) {
//            // Login Succeeded
//            NSLog(@"Succeess");
//        } else {
//            // Login Failed
//            NSLog(@"Failed");
//        }
//    }];    

    
    [[StackMob stackmob] startSession];
    
    
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [loginViewController release];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent; 
    //    navController.view.frame = CGRectMake(0, 0, 100, 100);
//    [self.window addSubview:navController.view];
    [self.window setRootViewController:navController];
    [navController release];


    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    [[StackMob stackmob] endSession];
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"data %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
}



@end
