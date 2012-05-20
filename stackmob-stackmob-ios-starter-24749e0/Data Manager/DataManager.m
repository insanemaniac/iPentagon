//
//  DataManager.m
//  StackMobStarterProject
//
//  Created by Parag Dulam on 19/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "DataManager.h"
#import "BaseViewController.h"

@interface DataManager()
-(void) getTaskDictionaryWhereTaskId:(NSString *) taskId WhereViewController:(BaseViewController *) vc;

@end


@implementation DataManager



+(NSString *) getDocumentsDirectoryPath
{
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                   NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    return docsDir;
}

-(void) setCredentials:(NSDictionary *)aDictionary
{
    credentials = aDictionary;
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[DataManager getDocumentsDirectoryPath],USER_CREDENTIALS_DB_NAME];
    [credentials writeToFile:filePath 
                  atomically:YES];
}


-(NSDictionary *) credentials
{
    return credentials;
}


-(NSArray *) groups
{
    NSArray *retVal = [userData objectForKey:@"users_group"];
    return retVal;
}


-(NSArray *) institutes
{
    NSArray *retVal = [userData objectForKey:@"users_institute"];
    return retVal;
}



-(NSArray *) tasks
{
    NSArray *retVal = [userData objectForKey:@"user_things"];
    return retVal;
}


-(void) getTasksWhereTasks:(NSArray *) tasks 
       WhereViewController:(BaseViewController *) vc
{
    StackMobQuery *query = [StackMobQuery query];
    [query field:@"things_doing_id" mustBeOneOf:tasks];
    [[StackMob stackmob] get:@"things_doing" 
                   withQuery:query 
                 andCallback:^(BOOL success, id result) {
                     [vc didRecieveTasks:result];
                 }];
}

-(void) getUserInstitutesWhereTask:(NSDictionary *) task 
        andCallBackViewConrtroller:(BaseViewController *) vc
{
    StackMobQuery *query = [StackMobQuery query];
    [query field:@"institute_things_doing" mustEqualValue:[task objectForKey:@"things_doing_id"]];
    //    [query ]
    [[StackMob stackmob] get:@"institute" 
                   withQuery:query 
                 andCallback:^(BOOL success, id result) {
                     NSArray *userInstitutes = [self institutes];
                     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ CONTAINS institute_id ",userInstitutes];
                     
                     NSMutableArray *institutes = [[NSMutableArray alloc] init];
                     for (NSDictionary *institute in result) {
                         if ([predicate evaluateWithObject:institute]) {
                             [institutes addObject:[NSMutableDictionary dictionaryWithDictionary:institute]]; //mutating a Dictionary to add data later
                         }
                     }
                     [vc didRecieveUserInstitutesForTask:institutes];
                 }];
}


-(void) getUserGroupsWhereTask:(NSDictionary *) task 
    andCallBackViewConrtroller:(BaseViewController *) vc;
{
    StackMobQuery *query = [StackMobQuery query];
    [query field:@"group_things_doing" mustEqualValue:[task objectForKey:@"things_doing_id"]];
//    [query ]
    [[StackMob stackmob] get:@"group" 
                   withQuery:query 
                 andCallback:^(BOOL success, id result) {
                     NSArray *userGroups = [self groups];
                     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ CONTAINS group_id",userGroups];
                     
                     NSMutableArray *groups = [[NSMutableArray alloc] init];
                     for (NSDictionary *group in result) {
                         if ([predicate evaluateWithObject:group]) {
                             [groups addObject:[NSMutableDictionary dictionaryWithDictionary:group]]; //mutating a Dictionary to add data later
                         }
                     }
                     [vc didRecieveUserGroupsForTask:groups];
                 }];
}

-(void) getGroupsWhereGroups:(NSArray *) groups 
         WhereViewController:(BaseViewController *) vc
{
    StackMobQuery *query = [StackMobQuery query];
    [query field:@"group_id" mustBeOneOf:groups];
    [[StackMob stackmob] get:@"group" 
                   withQuery:query 
                 andCallback:^(BOOL success, id result) {
                     [vc didRecieveGroups:result];
                 }];
}





-(void) getTaskDictionaryWhereTaskId:(NSString *) taskId 
                 WhereViewController:(BaseViewController *) vc
{
    StackMobQuery *query = [StackMobQuery query];
    [query field:@"things_doing_id " mustEqualValue:taskId];
    [[StackMob stackmob] get:@"things_doing" 
                   withQuery:query 
                 andCallback:^(BOOL success, id result) {
//                     [vc didRecieveTaskDictionary:result];
                 }];
}


-(void) setUserData:(NSDictionary *)aDictionary
{
    userData = aDictionary;
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[DataManager getDocumentsDirectoryPath],USER_DATA_DB_NAME];
    [userData writeToFile:filePath 
               atomically:YES];
}


-(NSDictionary *) userData
{
    return userData;
}




static DataManager *sharedInstance = nil;

+(DataManager *) sharedSingleton
{
    if (nil != sharedInstance) {
        return sharedInstance;
    }
    
    static dispatch_once_t pred; // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        sharedInstance = [[DataManager alloc] init];
    });
    
    return sharedInstance;
}


@end
