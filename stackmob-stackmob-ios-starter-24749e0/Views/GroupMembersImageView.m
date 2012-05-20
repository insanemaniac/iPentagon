//
//  GroupMembersImageView.m
//  StackMobStarterProject
//
//  Created by Parag Dulam on 01/05/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "GroupMembersImageView.h"

@implementation GroupMembersImageView


-(void) setImages:(NSArray *)anArray
{
    images = anArray;
    for (int i = 0 ; i < [images count] ; i++) {
        if ([images count] <= 6) {
            UIImageView * iView = [imageViews objectAtIndex:i];
            [iView setImage:[images objectAtIndex:i]];
        }
    }
    [self setNeedsLayout];
}


-(NSArray *) images
{
    return images;
}




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




-(id) init
{
    if (self = [super init]) {
        imageViews = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < 6; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.backgroundColor = [UIColor redColor];
            [self addSubview:imageView];
            [imageViews addObject:imageView];
        }
    }
    return self;
}

-(id) initWithImagesArray:(NSArray *) imagesArray
{
    if (self = [super init]) {
        self.images = imagesArray;
        imageViews = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < 6; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.backgroundColor = [UIColor redColor];
            [self addSubview:imageView];
            [imageViews addObject:imageView];
        }
    }
    return self;
}



-(void) layoutSubviews
{
    [super layoutSubviews];
    int index = 0;
    for (int i = 0 ; i < 2 ; i++) {
        for (int j = 0; j < 3; j++) {
            UIImageView * iView = [imageViews objectAtIndex:index++];
//            iView.image = [images objectAtIndex:i];
            iView.frame = CGRectMake(j * (self.frame.size.width/3), 
                                     i * (self.frame.size.height/2),
                                     self.frame.size.width/3,
                                     self.frame.size.height/2);
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
