//
//  TaskGridCell.m
//  StackMobStarterProject
//
//  Created by Parag Dulam on 06/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "TaskGridCell.h"

@implementation TaskGridCell

-(iCarousel *) carousel
{
    return taskGridView;
}

-(void) setTask:(NSDictionary *)aDictionary
{
    task = aDictionary;
    NSLog(@"task %@",task);
    [groups removeAllObjects];
    if ([[task objectForKey:@"GROUP(S)"] count]) {
        [groups addObjectsFromArray:[task objectForKey:@"GROUP(S)"]];
    }
    if ([[task objectForKey:@"INSTITUTE(S)"] count]) {
        [groups addObjectsFromArray:[task objectForKey:@"INSTITUTE(S)"]];
    }
    [groups addObject:[NSMutableDictionary dictionary]];
    
    [taskGridView reloadData];
}

-(NSDictionary *) task
{
    return task;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        taskGridView = [[iCarousel alloc] init];
        taskGridView.dataSource = self;
        taskGridView.delegate = self;
        taskGridView.type = iCarouselTypeLinear;
        [self addSubview:taskGridView];
        
        groups = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void) layoutSubviews
{
    [super layoutSubviews];
    taskGridView.frame = self.contentView.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



#pragma mark
#pragma mark DTGridViewDataSource,DTGridViewCellDelegate
#pragma mark


- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{    
    return [groups count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
//    UILabel *label = nil;
//    
//    //create new view if no view is available for recycling
//    if (view == nil)
//    {
//        view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page.png"]] autorelease];
//        view.layer.doubleSided = NO; //prevent back side of view from showing
//        label = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
//        label.backgroundColor = [UIColor clearColor];
//        label.textAlignment = UITextAlignmentCenter;
//        label.font = [label.font fontWithSize:50.0f];
//        [view addSubview:label];
//    }
//    else
//    {
//        label = [[view subviews] lastObject];
//    }
//    
//    //set label
//    label.text = (index == 0)? @"[": @"]";
//    
//    return view;
    
    IndividualTaskGridCell *cell = nil;
    if (!view) {
        cell = [[IndividualTaskGridCell alloc] initWithReuseIdentifier:@"IndividualTaskGridCell"]; 
        [cell setFrame:CGRectMake(0, 0, 320.f, 83.f)];
    } else {
        cell = (IndividualTaskGridCell *)view;
    }
    [cell setNeedsLayout];
    [cell setBackgroundImage:[UIImage imageNamed:@"tasks_cell_background.png"]];
    [cell setTaskName:[[task objectForKey:@"THING"] objectForKey:@"things_doing_name"]];
    NSDictionary *group = [groups objectAtIndex:index];
    if ([[group objectForKey:@"group_name"] length]) {
        [cell setGroupName:[group objectForKey:@"group_name"]];
    } else if([[group objectForKey:@"intitutename"] length]) {
        [cell setGroupName:[group objectForKey:@"intitutename"]];
    } else {
        [cell setGroupName:nil];
        NSLog(@"OVERALL_PROGRESS %@",[task objectForKey:@"OVERALL_PROGRESS"]);
        [cell setGroupProgress:[task objectForKey:@"OVERALL_PROGRESS"]];
    }

    return cell;

}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return YES;
}


//#pragma mark
//#pragma mark DTGridViewDataSource,DTGridViewCellDelegate
//#pragma mark
//
//
//- (NSInteger)numberOfRowsInGridView:(DTGridView *)gridView
//{
//    return 1;
//}
//
//- (NSInteger)numberOfColumnsInGridView:(DTGridView *)gridView forRowWithIndex:(NSInteger)index
//{
//    return [groups count];
//}
//- (CGFloat)gridView:(DTGridView *)gridView heightForRow:(NSInteger)rowIndex
//{
//    return 83.f;
//}
//- (CGFloat)gridView:(DTGridView *)gridView widthForCellAtRow:(NSInteger)rowIndex column:(NSInteger)columnIndex
//{
//    return 320.f;
//}
//- (DTGridViewCell *)gridView:(DTGridView *)gridView viewForRow:(NSInteger)rowIndex column:(NSInteger)columnIndex
//{
//    IndividualTaskGridCell *cell = (IndividualTaskGridCell *)[gridView dequeueReusableCellWithIdentifier:@"IndividualTaskGridCell"];
//    if (!cell) {
//        cell = [[IndividualTaskGridCell alloc] initWithReuseIdentifier:@"IndividualTaskGridCell"];
//    }
//    [cell setBackgroundImage:[UIImage imageNamed:@"tasks_cell_background.png"]];
//    [cell setTaskName:[[task objectForKey:@"THING"] objectForKey:@"things_doing_name"]];
//    NSDictionary *group = [groups objectAtIndex:columnIndex];
//    if ([[group objectForKey:@"group_name"] length]) {
//        [cell setGroupName:[group objectForKey:@"group_name"]];
//    } else {
//        [cell setGroupName:[group objectForKey:@"intitutename"]];
//    }
//    return cell;
//}






//#pragma mark
//#pragma mark GMGridViewDataSource
//#pragma mark
//
//- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
//{
//    return [[task objectForKey:@"GROUP(S)"] count] + [[task objectForKey:@"INSTITUTE(S)"] count];
//}
//
//- (CGSize)sizeForItemsInGMGridView:(GMGridView *)gridView
//{
//    return CGSizeMake(320.f, 83.f);
//}
//
//- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
//{
//    IndividualTaskGridCell *cell = (IndividualTaskGridCell *)[gridView dequeueReusableCell];
//    CGSize size = [self sizeForItemsInGMGridView:gridView];
//    if (!cell) {
//        cell = [[IndividualTaskGridCell alloc] init];
//        [cell setFrame:CGRectMake(0, 
//                                  0,
//                                  size.width,
//                                  size.height)];
//    }
//    [cell setNeedsLayout];
//    [cell setBackgroundImage:[UIImage imageNamed:@"tasks_cell_background.png"]];
//    [cell setTaskName:[[task objectForKey:@"THING"] objectForKey:@"things_doing_name"]];
//    return cell;
//}


@end
