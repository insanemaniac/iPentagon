//
//  DataManager.h
//  StackMobStarterProject
//
//  Created by Parag Dulam on 19/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
@interface DataManager : NSObject
{
    NSDictionary *credentials;
    NSDictionary *userData;
}

+(DataManager *) sharedSingleton;
+(NSString *) getDocumentsDirectoryPath;

@property (nonatomic,retain) NSDictionary *credentials;
@property (nonatomic,retain) NSDictionary *userData;



@end
