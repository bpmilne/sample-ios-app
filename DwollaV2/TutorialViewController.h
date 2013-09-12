//
//  TutorialViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/15/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+DwollaColors.h"

@interface TutorialViewController : UIViewController <UIScrollViewDelegate>
{
    UIPageControl* tutorialControl;
    UIScrollView* tutorial;
    
    UIImageView* background;
    UIButton* loginButton;
    CGRect screenBounds;
}


- (void)dropDown;

- (void)startUp;

- (void)moveUp;

- (void)backDown;

@end
