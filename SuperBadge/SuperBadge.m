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
        self.font = [UIFont boldSystemFontOfSize:11.0f];
        self.textAlignment = UITextAlignmentCenter;
        self.layer.cornerRadius = self.frame.size.height/2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.cornerRadius = self.frame.size.width/2;
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
    CGFloat components[8] = { 1.0, 1.0, 1.0, 0.75,  // Start color
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

@synthesize backgroundColor, borderColor, hasBorder, hasShadow;
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
    myFrame.size.width = originalWidth + (originalWidth/4) * (text.length-1);
    self.frame = myFrame;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:self.layer.cornerRadius];
    self.layer.shadowPath = path.CGPath;
    badge.frame = self.bounds;
    [badge setText:text];
}

@end
