//
//  GroupMembersImageView.h
//  StackMobStarterProject
//
//  Created by Parag Dulam on 01/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupMembersImageView : UIView
{
    NSArray *images;
    NSMutableArray *imageViews;
}

@property(nonatomic,retain) NSArray *images;

@end
