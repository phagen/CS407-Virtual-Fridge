//
//  PantryViewController.h
//  Virtual Fridge
//
//  Created by Patrick Hagen on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface PantryViewController : UITableViewController {
    NSArray *_Food;
    @private NSMutableArray *pantryItems;
    NSString *s;
  //  NSManagedObjectContext *_context;
}

@property (nonatomic, retain) NSArray *Food;
@property (nonatomic, retain) NSString *s;
@property (nonatomic, strong) NSMutableArray *pantryItems;


+ (NSMutableArray *) cleanItems: (NSMutableArray*) array;
//@property (nonatomic, retain) NSManagedObjectContext *context;
@end