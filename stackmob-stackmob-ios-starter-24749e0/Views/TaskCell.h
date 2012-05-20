//
//  TaskCell.h
//  StackMobStarterProject
//
//  Created by Parag Dulam on 15/04/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupMembersImageView.h"

@interface TaskCell : UITableViewCell
{
    UIImageView *backgroundImageView;
    UILabel *taskNameLabel;
    UILabel *groupNameLabel;
    UILabel *instituteNameLabel;
    UILabel *group_ProgressLabel;
    UILabel *institute_ProgressLabel;
    
    GroupMembersImageView *imageView;
}

@property(nonatomic,assign) UIImage *backgroundImage;
@property(nonatomic,assign) NSString *taskName;
@property(nonatomic,assign) NSString *groupName;
@property(nonatomic,assign) NSString *instituteName;
@property(nonatomic,assign) NSString *groupProgress;
@property(nonatomic,assign) NSString *instituteProgress;
@property(nonatomic,assign) NSArray *images;



@end
