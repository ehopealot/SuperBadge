//
//  ViewController.h
//  Example
//
//  Created by Erik Hope on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SuperBadge;
@interface ViewController : UIViewController
{
    IBOutlet SuperBadge *smallCircleBadge;
    IBOutlet SuperBadge *largeCircleBadge;
    IBOutlet SuperBadge *smallRectBadge;

    IBOutlet SuperBadge *largeRectBadge;
    IBOutlet SuperBadge *hugeBadge;
    
    int numberInBadge;
    
}


@end
