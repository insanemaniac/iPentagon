//
//  DataManager.h
//  StackMobStarterProject
//
//  Created by Parag Dulam on 19/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "StackMob.h"

@class BaseViewController;
@interface DataManager : NSObject
{
    NSDictionary *credentials;
    NSDictionary *userData;
}

+(DataManager *) sharedSingleton;
+(NSString *) getDocumentsDirectoryPath;
-(NSArray *) tasks;
-(void) getTasksWhereTasks:(NSArray *) tasks WhereViewController:(BaseViewController *) vc;
-(void) getTaskDictionaryWhereTaskId:(NSString *) taskId WhereViewController:(BaseViewController *) vc;
-(NSArray *) groups;
-(NSArray *) institutes;
-(void) getGroupsWhereGroups:(NSArray *) groups 
         WhereViewController:(BaseViewController *) vc;
-(void) getUserGroupsWhereTask:(NSDictionary *) task 
    andCallBackViewConrtroller:(BaseViewController *) vc;
-(void) getUserInstitutesWhereTask:(NSDictionary *) task 
        andCallBackViewConrtroller:(BaseViewController *) vc;







@property (nonatomic,retain) NSDictionary *credentials;
@property (nonatomic,retain) NSDictionary *userData;



@end
