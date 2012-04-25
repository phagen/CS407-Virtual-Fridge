//
//  EditFoodDetails.h
//  Virtual Fridge
//
//  Created by Patrick Hagen on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface EditFoodDetails : UIViewController <UIPickerViewDataSource>
{
    Food *item;
}

//@property
@property (nonatomic, retain) Food *item;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;




- (IBAction)doneButton:(id)sender;
- (IBAction)datePicker:(id)sender;


@end
