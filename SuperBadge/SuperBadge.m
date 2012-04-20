//
//  SuperBadge.m
//  Example
//
//  Created by Erik Hope on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SuperBadge.h"
#import <QuartzCore/QuartzCore.h>

@interface SuperBadgeLabel : UILabel
@end

@implementation SuperBadgeLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = NO;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor redColor];
        self.textColor = [UIColor whiteColor];
        self.textAlignment = UITextAlignmentCenter;
        self.layer.cornerRadius = self.frame.size.height/2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = self.frame.size.height/10.0f;
        self.layer.cornerRadius = self.frame.size.height/2;
    }
    return self;
}

- (void)drawRect:(CGRect)rect 
{
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 1.0, 1.0, 1.0,  // Start color
        1.0, 1.0, 1.0, 0.06 }; // End color
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    
    CGRect currentBounds = self.bounds;
    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
    CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMaxY(currentBounds));
    CGContextDrawLinearGradient(currentContext, glossGradient, topCenter, midCenter, 0);
    
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace); 
    [super drawRect:rect];
    
}


@end


@interface SuperBadge()

- (void) setUp;

@end


@implementation SuperBadge
{
    SuperBadgeLabel *badge;
    CGFloat originalWidth;
}

@synthesize badgeBackgroundColor, badgeBorderColor, hasBorder, hasShadow;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setUp
{
    badge = [[SuperBadgeLabel alloc] initWithFrame:self.bounds];
    [self addSubview:badge];
    originalWidth = self.frame.size.height;
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = self.frame.size.width/2;
    self.clipsToBounds = NO;
    self.layer.shadowRadius = 1.0f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.userInteractionEnabled = NO;
    self.layer.shouldRasterize = YES;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:self.layer.cornerRadius];
    self.layer.shadowPath = path.CGPath;
}

- (void)setBadgeBorderColor:(UIColor *)theBorderColor
{
    badge.layer.borderColor = theBorderColor.CGColor;
    badgeBorderColor = theBorderColor;
}

- (void)setBadgeBackgroundColor:(UIColor *)theBackgroundColor
{
    badge.backgroundColor = theBackgroundColor;
    badgeBackgroundColor = theBackgroundColor;
}

- (void)awakeFromNib
{
    [self setUp];
}

- (NSString*) text{
    return badge.text;
}

- (void)setText:(NSString *)text
{
    CGRect myFrame = self.frame;

    [badge setText:text];
    
    CGSize constrainingSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize textSize;
    for (int i = 300; i > 5; i--){
        badge.font = [UIFont boldSystemFontOfSize:i];
        textSize = [badge.text sizeWithFont:badge.font constrainedToSize:constrainingSize
                                lineBreakMode:UILineBreakModeWordWrap];
        if (textSize.height <= badge.frame.size.height*7.0f/10.0f){
            break;
        }
    }
    
    if (text.length <= 1){
        myFrame.size.width = originalWidth;
    } else {
        myFrame.size.width = textSize.width + originalWidth;
    }
    self.frame = myFrame;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:self.layer.cornerRadius];
    self.layer.shadowPath = path.CGPath;
    badge.frame = self.bounds;

}

@end
