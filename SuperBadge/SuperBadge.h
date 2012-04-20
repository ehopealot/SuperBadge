//
//  SuperBadge.h
//  Example
//
//  Created by Erik Hope on 4/19/12.
//  Copyright (c) 2012 Erik Hope. All rights reserved.
//
//  
//  This is a simple class which emulates the badges on apps on the iOS home screen
//  and on UITabBarItems


#import <UIKit/UIKit.h>

@interface SuperBadge : UILabel

@property (nonatomic, retain) UIColor *badgeBackgroundColor; // Default is [UIColor RedColor]
@property (nonatomic, retain) UIColor *badgeBorderColor; // Default is [UIColor WhiteColor]
@property (nonatomic, retain) UIColor *badgeTextColor; // Default is [UIColor WhiteColor];

@property (nonatomic) BOOL hasShadow; // Default is YES
@property (nonatomic) BOOL hasBorder; // Default is YES
@property (nonatomic) BOOL hasGloss; // Default is YES

// Initialize with initial text to display
- (id)initWithFrame:(CGRect)frame andText:(NSString*)text;

@end