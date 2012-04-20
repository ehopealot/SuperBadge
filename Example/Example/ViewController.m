//
//  ViewController.m
//  Example
//
//  Created by Erik Hope on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "SuperBadge.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    smallCircleBadge.text = @"1";
    smallCircleBadge.badgeBorderColor = [UIColor blueColor];
    largeCircleBadge.text = @"1";
    largeCircleBadge.badgeBackgroundColor = [UIColor orangeColor];
    largeCircleBadge.badgeBorderColor = [UIColor purpleColor];
    smallRectBadge.text = @"12";
    largeRectBadge.text = @"123";
    largeRectBadge.badgeBorderColor = [UIColor blackColor];
    hugeBadge.text = @"Really Long Text in this Badge";
    hugeBadge.badgeBorderColor = [UIColor greenColor];
    hugeBadge.badgeBackgroundColor = [UIColor magentaColor];
    hugeBadge.frame = CGRectMake(hugeBadge.frame.origin.x,
                                 hugeBadge.frame.origin.y,
                                 90,90);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated
{
    largeRectBadge.hasShadow = NO;
    [UIView animateWithDuration:.5 delay:2.0 options:0 animations:^{
        largeCircleBadge.center = CGPointMake(largeCircleBadge.center.x+50, 
                                              largeCircleBadge.center.y+50);
        largeRectBadge.text = @"123456";
    } completion:^(BOOL finished) {
    }];
    

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end
