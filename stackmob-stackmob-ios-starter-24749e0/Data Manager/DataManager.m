//
//  DataManager.m
//  StackMobStarterProject
//
//  Created by Parag Dulam on 19/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "DataManager.h"

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
