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
    smallRectBadge.text = @"123456789";
    largeRectBadge.text = @"123456789";
    hugeBadge.text = @"Really Long Text in this Badge";
    hugeBadge.badgeBorderColor = [UIColor greenColor];
    hugeBadge.badgeBackgroundColor = [UIColor magentaColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
