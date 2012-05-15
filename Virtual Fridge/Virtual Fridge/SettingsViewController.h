//
//  SettingsViewController.h
//  Virtual Fridge
//
//  Created by Matt Wysocki on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class epicuriousWebPage;

@interface SettingsViewController : UITableViewController
{
    IBOutlet epicuriousWebPage *epic;
    NSIndexPath *daysPath;
}
@property (nonatomic, retain) epicuriousWebPage *epic;
@property (nonatomic, retain) NSIndexPath *daysPath;

- (IBAction)changedValue:(id)sender;
- (IBAction)sliderChangedValue:(id)sender;

@end
