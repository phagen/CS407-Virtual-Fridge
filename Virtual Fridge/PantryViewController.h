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
    @private NSMutableArray *pantryItemsCat;
    NSString *s;
    NSInteger *viewFlag;
  //  NSManagedObjectContext *_context;
}

@property (nonatomic, retain) NSArray *Food;
@property (nonatomic, retain) NSString *s;
@property (nonatomic, strong) NSMutableArray *pantryItems;
@property (nonatomic, strong) NSMutableArray *pantryItemsCat;


+ (NSMutableArray *) cleanItems: (NSMutableArray*) array;
//@property (nonatomic, retain) NSManagedObjectContext *context;
@end