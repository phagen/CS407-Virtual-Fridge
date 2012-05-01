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
}
@property (nonatomic, retain) epicuriousWebPage *epic;

- (IBAction)changedValue:(id)sender;
- (IBAction)sliderChangedValue:(id)sender;

@end
