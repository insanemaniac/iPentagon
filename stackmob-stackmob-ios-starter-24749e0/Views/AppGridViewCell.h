//
//  AppGridViewCell.h
//  MyGang
//
//  Created by Parag Dulam on 08/03/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "APPButton.h"
#import "Constants.h"




@interface AppGridViewCell : UIView
{
    UILabel * habitNameLabel;
    UILabel * updateLabel;
    CAGradientLayer *baseLayer;
    id touchDelegate;
}

@property(nonatomic,assign) NSString *habitName;
@property(nonatomic,assign) NSString *updateString;
@property(nonatomic,assign) id touchDelegate;


-(void) setAttributes;
-(void)setHabitLabelAlpha:(float)alpha;
-(void)setUpdateLabelAlpha:(float)alpha;
-(void) setSelected:(BOOL) aBool;
-(void) setTotalGradient;



@end

@protocol AppGridViewCellTouchDelegate <NSObject>

-(void) cellDidTouchBegan:(AppGridViewCell *) cell;

@end


