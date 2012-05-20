//
//  TaskGridCell.h
//  StackMobStarterProject
//
//  Created by Parag Dulam on 06/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "IndividualTaskGridCell.h"

@interface TaskGridCell : UITableViewCell<iCarouselDataSource,iCarouselDelegate>
{
    iCarousel *taskGridView;
    NSDictionary *task;
    NSMutableArray *groups;
}

@property(nonatomic,retain) NSDictionary *task;
-(iCarousel *) carousel;

@end
