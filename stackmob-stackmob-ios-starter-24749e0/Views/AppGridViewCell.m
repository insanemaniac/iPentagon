//
//  AppGridViewCell.m
//  MyGang
//
//  Created by Parag Dulam on 08/03/12.
//  Copyright (c) 2012 Sapna Solutions. All rights reserved.
//

#import "AppGridViewCell.h"

@implementation AppGridViewCell
@synthesize touchDelegate;


-(void) dealloc
{
    touchDelegate = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        habitNameLabel = [[UILabel alloc] init];
        habitNameLabel.font = [self getComicSansFontForSize:20.f];
        [self addSubview:habitNameLabel];
        habitNameLabel.backgroundColor = [UIColor clearColor];
        habitNameLabel.userInteractionEnabled = NO;
        habitNameLabel.textAlignment = UITextAlignmentCenter;
        habitNameLabel.adjustsFontSizeToFitWidth = YES;
        [habitNameLabel release];
        
        updateLabel = [[UILabel alloc] init];
        updateLabel.font = [self getComicSansFontForSize:20.f];
        [self addSubview:updateLabel];
        updateLabel.backgroundColor = [UIColor clearColor];
        updateLabel.userInteractionEnabled = NO;
        updateLabel.textAlignment = UITextAlignmentCenter;
        updateLabel.adjustsFontSizeToFitWidth = YES;
        [updateLabel release];

        
    }
    return self;
}


-(void) setSelected:(BOOL) aBool
{
    if (aBool) {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor],(id)[[UIColor greenColor] CGColor], nil];
        [self.layer replaceSublayer:baseLayer with:gradientLayer];
        baseLayer = gradientLayer;
    }
}



-(void) setTotalGradient
{
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor],(id)[[UIColor orangeColor] CGColor], nil];
        [self.layer replaceSublayer:baseLayer with:gradientLayer];
        baseLayer = gradientLayer;
}



-(void) setUpdateString:(NSString *)aUpdateString
{
    updateLabel.text = aUpdateString;
}

-(NSString *) updateString
{
    return updateLabel.text;
}

-(void)setHabitName:(NSString *)aHabitName
{
    habitNameLabel.text = aHabitName;
}

-(void)setHabitLabelAlpha:(float)alpha
{
    habitNameLabel.alpha = alpha;
}

-(void)setUpdateLabelAlpha:(float)alpha
{
    updateLabel.alpha = alpha;
}



-(NSString *) habitName
{
    return habitNameLabel.text;
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    habitNameLabel.frame = CGRectMake(0, (3 * frame.size.height)/4 - 10.f, frame.size.width, frame.size.height/4);
    updateLabel.frame = CGRectMake(0, habitNameLabel.frame.origin.y - 50.f, frame.size.width, 50.f);
    [self setAttributes];
}

-(id) init
{
    if (self = [super init]) {
        [self setAttributes];
        
        habitNameLabel = [[UILabel alloc] init];
        habitNameLabel.font = [self getComicSansFontForSize:20.f];
        [self addSubview:habitNameLabel];
        habitNameLabel.backgroundColor = [UIColor clearColor];
        habitNameLabel.userInteractionEnabled = NO;
        habitNameLabel.textAlignment = UITextAlignmentCenter;
        habitNameLabel.adjustsFontSizeToFitWidth = YES;
        [habitNameLabel release];
        
        updateLabel = [[UILabel alloc] init];
        updateLabel.font = [self getComicSansFontForSize:20.f];
        [self addSubview:updateLabel];
        updateLabel.backgroundColor = [UIColor clearColor];
        updateLabel.userInteractionEnabled = NO;
        updateLabel.textAlignment = UITextAlignmentCenter;
        updateLabel.adjustsFontSizeToFitWidth = YES;
        [updateLabel release];

        
        
    }
    return self;
}


-(void) setAttributes
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = APP_BUTTON_CORNER_RADIUS;
    
//    self.layer.shadowColor = APP_BUTTON_SHADOW_COLOR;
//    self.layer.shadowOffset = CGSizeMake(10.f, 10.f);
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
//    self.layer.shadowRadius = 2.f;
//    self.layer.shadowOpacity = 1.f;
    
    self.layer.borderColor = APP_BUTTON_BORDER_COLOR;
    self.layer.borderWidth = APP_BUTTON_BORDER_WIDTH;
    
    baseLayer = [CAGradientLayer layer];
    baseLayer.frame = self.bounds;
    baseLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor],(id)[[UIColor redColor] CGColor], nil];
    [self.layer insertSublayer:baseLayer atIndex:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



-(NSString *) getDocumentsDirectoryPath
{
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                   NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    return docsDir;
}


-(NSString *) getUserDatabasePath
{
    return [NSString stringWithFormat:@"%@/%@",[self getDocumentsDirectoryPath],EVENTS_DB_NAME];
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setSelected:YES];
    if ([touchDelegate respondsToSelector:@selector(cellDidTouchBegan:)]) {
        [touchDelegate cellDidTouchBegan:self];
    }
    [self setUserInteractionEnabled:NO];
}



#pragma mark Fonts


- (CTFontRef)newCustomFontWithName:(NSString *)fontName
                            ofType:(NSString *)type
                        attributes:(NSDictionary *)attributes
{
    NSString *fontPath = [[NSBundle mainBundle] pathForResource:fontName ofType:type];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:fontPath];
    CGDataProviderRef fontProvider = CGDataProviderCreateWithCFData((CFDataRef)data);
    [data release];
    
    CGFontRef cgFont = CGFontCreateWithDataProvider(fontProvider);
    CGDataProviderRelease(fontProvider);
    
    CTFontDescriptorRef fontDescriptor = CTFontDescriptorCreateWithAttributes((CFDictionaryRef)attributes);
    CTFontRef font = CTFontCreateWithGraphicsFont(cgFont, 0, NULL, fontDescriptor);
    CFRelease(fontDescriptor);
    CGFontRelease(cgFont);
    return font;
}


-(UIFont *) getFontForFileName:(NSString *)fontFileName 
                        ofType:(NSString *)type 
                    attributes:(NSDictionary *)attributes
{
    CTFontRef canHazComicSans = [self newCustomFontWithName:fontFileName 
                                                     ofType:type 
                                                 attributes:attributes];
    NSString *fontName = [(NSString *)CTFontCopyName(canHazComicSans, kCTFontPostScriptNameKey) autorelease];
    CGFloat fontSize = CTFontGetSize(canHazComicSans);
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    return font;
}


-(UIFont *) getFontForFileName:(NSString *)fontFileName 
                        ofType:(NSString *)type 
                      fontsize:(float)size
{
    CTFontRef canHazComicSans = [self newCustomFontWithName:fontFileName 
                                                     ofType:type 
                                                 attributes:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:size] forKey:(NSString *)kCTFontSizeAttribute]];
    NSString *fontName = [(NSString *)CTFontCopyName(canHazComicSans, kCTFontPostScriptNameKey) autorelease];
    CGFloat fontSize = CTFontGetSize(canHazComicSans);
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    return font;
}

-(UIFont *) getComicSansFontForSize:(float) size
{
    return [self getFontForFileName:@"ComicSans"
                             ofType:@"ttf" 
                           fontsize:size];
}


@end
