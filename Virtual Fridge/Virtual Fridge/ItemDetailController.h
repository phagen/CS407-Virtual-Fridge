//
//  ItemDetailController.h
//  Virtual Fridge
//
//  Created by Matt Wysocki on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface ItemDetailController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    Food *food;
    
}

@property (nonatomic, strong) Food *food;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
- (IBAction)doneButton:(id)sender;
- (IBAction)addToList:(id)sender;

@end
