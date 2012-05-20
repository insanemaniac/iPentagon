//
//  APPButton.m
//  MyGang
//
//  Created by Parag Dulam on 08/03/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import "APPButton.h"

@implementation APPButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setAttributes];
    }
    return self;
}


-(void) setAttributes
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = APP_BUTTON_CORNER_RADIUS;
    
//    self.layer.shadowColor = APP_BUTTON_SHADOW_COLOR;
//    self.layer.shadowOffset = CGSizeMake(5, 5);
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
//    self.layer.shadowRadius = 10.f;
//    self.layer.shadowOpacity = 1.f;

    self.layer.borderColor = APP_BUTTON_BORDER_COLOR;
    self.layer.borderWidth = APP_BUTTON_BORDER_WIDTH;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = APP_BUTTON_GRADIENT_ARRAY;
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    
    CAGradientLayer *glossLayer = [CAGradientLayer layer];
    glossLayer.cornerRadius = self.layer.cornerRadius / 2;
    glossLayer.frame = CGRectMake(self.bounds.origin.x + 4.f,
                                  self.bounds.origin.y + 2.f,
                                  self.bounds.size.width - 8.f,
                                  self.bounds.size.height/5);
    glossLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:235.f/255.f
                                                                       green:235.f/255.f  
                                                                        blue:235.f/255.f  alpha:0.8f] CGColor],(id)[[UIColor colorWithRed:255.f/255.f
                                                                                                                                    green:255.f/255.f  
                                                                                                                                     blue:255.f/255.f  alpha:0.2f] CGColor],nil];
    [self.layer insertSublayer:glossLayer atIndex:1];

}


-(id) init
{
    if (self = [super init]) {
        [self setAttributes];
    }
    return self;
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
