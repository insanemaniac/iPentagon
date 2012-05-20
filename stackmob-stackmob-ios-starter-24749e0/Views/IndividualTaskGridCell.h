//
//  IndividualTaskGridCell.h
//  StackMobStarterProject
//
//  Created by Parag Dulam on 06/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupMembersImageView.h"
#import "DTGridViewCell.h"


@interface IndividualTaskGridCell : DTGridViewCell
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
