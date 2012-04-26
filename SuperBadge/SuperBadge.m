//
//  SuperBadge.m
//  Example
//
//  Created by Erik Hope on 4/19/12.
//  Copyright (c) 2012 Erik Hope. All rights reserved.
//

#import "SuperBadge.h"
#import <QuartzCore/QuartzCore.h>


@interface GradientLayerDelegate : NSObject

@property (nonatomic) BOOL hasGloss;

@end

@implementation GradientLayerDelegate

@synthesize hasGloss;

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)currentContext
{
    if (hasGloss){
        CGGradientRef glossGradient;
        CGColorSpaceRef rgbColorspace;
        size_t num_locations = 2;
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = { 1.0, 1.0, 1.0, .75,  // Start color
            1.0, 1.0, 1.0, 0.06 }; // End color
        
        rgbColorspace = CGColorSpaceCreateDeviceRGB();
        glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
        
        CGRect currentBounds = layer.bounds;
        CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
        CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMaxY(currentBounds));
        CGContextDrawLinearGradient(currentContext, glossGradient, topCenter, midCenter, 0);
        
        CGGradientRelease(glossGradient);
        CGColorSpaceRelease(rgbColorspace); 
    }
}

@end


@interface SuperBadge()

- (void) setUp;
- (void) setDefaults;

@end

@implementation SuperBadge
{
    CALayer *gradient;
    CALayer *borderLayer;
    GradientLayerDelegate *gradientDrawer;
}

@synthesize badgeBackgroundColor, badgeBorderColor, hasBorder, hasShadow, hasGloss,
badgeTextColor;


- (id)initWithFrame:(CGRect)frame andText:(NSString*)text
{
    self = [self initWithFrame:frame];
    if (self){
        self.text = text;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
        [self setUp];
    }
    return self;
}

- (void)setDefaults
{
    badgeTextColor = [UIColor whiteColor];
    hasGloss = YES;
    hasBorder = YES;
    hasShadow = YES;
    badgeBorderColor = [UIColor whiteColor];
    badgeBackgroundColor = [UIColor redColor];
    
    borderLayer = [[CALayer alloc] init];
    borderLayer.frame = CGRectInset(self.bounds, -1, -1);
    borderLayer.masksToBounds = YES;
    borderLayer.backgroundColor = [UIColor clearColor].CGColor;

    gradient = [[CALayer alloc] init];
    gradientDrawer = [[GradientLayerDelegate alloc] init];
    gradientDrawer.hasGloss = YES;
    gradient.delegate = gradientDrawer;
    gradient.masksToBounds = YES;
    gradient.frame = borderLayer.frame;
    gradient.backgroundColor = [UIColor clearColor].CGColor;

    
    self.textAlignment = UITextAlignmentCenter;
    self.autoresizesSubviews = YES;
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:borderLayer];
    [self.layer addSublayer:gradient];
    self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    
    self.textColor = badgeTextColor;
    self.layer.backgroundColor = badgeBackgroundColor.CGColor;
    self.layer.shadowOpacity = 0.5f;
    borderLayer.borderColor = badgeBorderColor.CGColor;
}


- (void)setUp
{
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.shadowRadius = ceilf(gradient.frame.size.height/20.0f);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:gradient.frame cornerRadius:self.layer.cornerRadius];
    self.layer.shadowPath = path.CGPath;
    
    borderLayer.borderWidth = hasBorder ? MAX(2.0f, floorf(self.frame.size.height/10)) : 0.0f;
    borderLayer.bounds = hasBorder ? CGRectInset(self.bounds, 1 - borderLayer.borderWidth, 
                                                1 - borderLayer.borderWidth) : self.bounds;
    borderLayer.cornerRadius = borderLayer.frame.size.height/2;
    borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    gradient.frame = borderLayer.bounds;
    gradient.cornerRadius = borderLayer.cornerRadius;
    gradient.position = borderLayer.position;
    [gradient setNeedsDisplay];
}

- (void)setBadgeBorderColor:(UIColor *)theBorderColor
{
    borderLayer.borderColor = theBorderColor.CGColor;
    badgeBorderColor = theBorderColor;
}

- (void)setBadgeBackgroundColor:(UIColor *)theBackgroundColor
{
    self.layer.backgroundColor = theBackgroundColor.CGColor;
    badgeBackgroundColor = theBackgroundColor;
}

- (void)setHasBorder:(BOOL)hasBorderValue
{
    hasBorder = hasBorderValue;
    borderLayer.borderWidth = hasBorder ? 2.0f : 0.0f;
}

- (void)setHasShadow:(BOOL)hasShadowValue
{
    hasShadow = hasShadowValue;
    self.layer.shadowOpacity = hasShadow ? 0.5f : 0.0f;
}

- (void)setHasGloss:(BOOL)hasGlossValue
{
    hasGloss = hasGlossValue;
    gradientDrawer.hasGloss = hasGloss;
    [gradient setNeedsDisplay];
}

- (void)setBadgeTextColor:(UIColor *)theBadgeTextColor
{
    badgeTextColor = theBadgeTextColor;
    self.textColor = badgeTextColor;
}


- (void)awakeFromNib
{
    [self setDefaults];
    [self setUp];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
   /* badge.frame = self.bounds;*/
    [self setText:self.text ? self.text : @""];
    [self setUp];
}

- (void)setText:(NSString *)text withAnimationDuration:(CGFloat)duration
{
    
}

- (void)setText:(NSString *)text
{
    CGRect myFrame = self.frame;
    [super setText:text];

    // If there's just one letter in the badge display
    // as a circle
    if (text.length < 1){
        myFrame.size.width = myFrame.size.height;
    } else {
        CGSize constrainingSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
        CGSize textSize;
        
        // Determines what size the label needs to be based on the constraint
        // that the text in the label should be 70% the height of the badge
        for (int i = 100; i > 5; i--){
            self.font = [UIFont boldSystemFontOfSize:i];
            textSize = [self.text sizeWithFont:self.font constrainedToSize:constrainingSize
                                  lineBreakMode:UILineBreakModeWordWrap];
            if (textSize.height <= self.frame.size.height*.8f){
                break;
            }
        }
        if (text.length == 1){
            myFrame.size.width = myFrame.size.height;
        } else {
            myFrame.size.width = textSize.width + myFrame.size.height*.7f;
        }
    }
    [super setFrame:myFrame];
    // Adjust the shadow to fit the new frame
    [self setUp];
}
@end
