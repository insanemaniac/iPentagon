//
//  TaskCell.m
//  StackMobStarterProject
//
//  Created by Parag Dulam on 15/04/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "TaskCell.h"

@implementation TaskCell




-(void) setImages:(NSArray *)anArray
{
    imageView.images = anArray;
}

-(NSArray *) images
{
    return imageView.images;
}

-(void) setGroupProgress:(NSString *)aString
{
    group_ProgressLabel.text = aString;
}


-(NSString *) groupProgress
{
    return group_ProgressLabel.text;
}

-(void) setInstituteProgress:(NSString *)aString
{
    institute_ProgressLabel.text = aString;
}

-(NSString *) instituteProgress
{
    return institute_ProgressLabel.text;
}


-(void) setBackgroundImage:(UIImage *)aImage
{
    backgroundImageView.image = aImage;
}

-(UIImage *) backgroundImage
{
    return backgroundImageView.image;
}



-(void) setInstituteName:(NSString *)aName
{
    instituteNameLabel.text = aName;
}

-(NSString *) instituteName
{
    return instituteNameLabel.text;
}

-(void) setGroupName:(NSString *)aName
{
    groupNameLabel.text = aName;
}

-(NSString *) groupName
{
    return groupNameLabel.text;
}

-(void) setTaskName:(NSString *)aName
{
    taskNameLabel.text = aName;
}


-(NSString *) taskName
{
    return taskNameLabel.text;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:backgroundImageView];
        [backgroundImageView release];
        
        
        
        
        taskNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:taskNameLabel];
        taskNameLabel.backgroundColor = [UIColor clearColor];
        [taskNameLabel release];
        
        groupNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:groupNameLabel];
        groupNameLabel.backgroundColor = [UIColor clearColor];
        [groupNameLabel release];
        
        instituteNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:instituteNameLabel];
        instituteNameLabel.backgroundColor = [UIColor clearColor];
        [instituteNameLabel release];
        
        group_ProgressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:group_ProgressLabel];
        group_ProgressLabel.backgroundColor = [UIColor clearColor];
        [group_ProgressLabel release];
        
        institute_ProgressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:institute_ProgressLabel];
        institute_ProgressLabel.backgroundColor = [UIColor clearColor];
        [institute_ProgressLabel release];
        
        
        imageView = [[GroupMembersImageView alloc] init];
        [self addSubview:imageView];
        [imageView release];
        
        
    }
    return self;
}


-(void) layoutSubviews
{
    backgroundImageView.frame = CGRectMake(2, 
                                           2, 
                                           self.bounds.size.width - 4.f,
                                           self.bounds.size.height - 4.f);
    
    imageView.frame = CGRectMake(4.f,
                                 15.f,
                                 81.f,
                                 self.bounds.size.height - 30.f);
//    [imageView layoutSubviews];
    
    taskNameLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame),
                                     0,
                                     200,
                                     25);
    
    groupNameLabel.frame = CGRectMake(taskNameLabel.frame.origin.x,
                                      CGRectGetMaxY(taskNameLabel.frame),
                                      taskNameLabel.frame.size.width,
                                      taskNameLabel.frame.size.height);
    
    instituteNameLabel.frame = CGRectMake(groupNameLabel.frame.origin.x,
                                          CGRectGetMaxY(groupNameLabel.frame),
                                          groupNameLabel.frame.size.width,
                                          groupNameLabel.frame.size.height);
    
    group_ProgressLabel.frame = CGRectMake(CGRectGetMaxX(groupNameLabel.frame),
                                           groupNameLabel.frame.origin.y,
                                           30,
                                           groupNameLabel.frame.size.height);
    
    institute_ProgressLabel.frame = CGRectMake(CGRectGetMaxX(instituteNameLabel.frame),
                                               instituteNameLabel.frame.origin.y,
                                               30,
                                               instituteNameLabel.frame.size.height);

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
