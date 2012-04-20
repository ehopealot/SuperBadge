//
//  SuperBadge.h
//  Example
//
//  Created by Erik Hope on 4/19/12.
//  Copyright (c) 2012 Erik Hope. All rights reserved.
//


#import <UIKit/UIKit.h>




@interface SuperBadge : UIView

@property (nonatomic, copy) NSString *text;

@property (nonatomic, retain) UIColor *backgroundColor; // Default is [UIColor RedColor]
@property (nonatomic, retain) UIColor *borderColor; // Default is [UIColor WhiteColor]

@property (nonatomic) BOOL hasShadow; // Default is YES
@property (nonatomic) BOOL hasBorder; // Default is YES

@end