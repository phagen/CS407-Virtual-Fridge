//
//  DetailedViewController.h
//  Virtual Fridge
//
//  Created by Patrick Hagen on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface DetailedViewController : UIViewController
{
    //IBOutlet UILabel *name;
    NSString *foodName;
    NSInteger *foodQty;
    NSDate *foodPurDate;
    NSDate *foodExpDate;
    NSString *foodComment;
    NSString *foodCategory;
    
    Food *selectedFood;
    
}

@property (nonatomic, retain) NSString *foodName;
@property (nonatomic, retain) Food *selectedFood;



- (IBAction)addToList:(id)sender;

@property (nonatomic, retain) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *expDate;
@property (weak, nonatomic) IBOutlet UILabel *purDate;
- (IBAction)backButton:(id)sender;

@end
