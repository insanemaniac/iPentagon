//
//  APPButton.h
//  MyGang
//
//  Created by Parag Dulam on 08/03/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define APP_BUTTON_CORNER_RADIUS 2.f
#define APP_BUTTON_SHADOW_COLOR [[UIColor blackColor] CGColor]
#define APP_BUTTON_BORDER_COLOR [[UIColor blackColor] CGColor]
#define APP_BUTTON_BORDER_WIDTH 1.f
#define APP_BUTTON_GRADIENT_ARRAY [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:213.f/255.f green:213.f/255.f blue:213.f/255.f alpha:1.f] CGColor],(id)[[UIColor colorWithRed:186.f/255.f green:186.f/255.f blue:186.f/255.f alpha:1.f] CGColor], nil]


@interface APPButton : UIButton

-(void) setAttributes;


@end
