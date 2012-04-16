//
//  AddShoppingList.h
//  Virtual Fridge
//
//  Created by Patrick Hagen on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddShoppingList : UITableViewController
{
    @private NSMutableArray *nonPantry;
}

@property (nonatomic, strong) NSMutableArray *nonPantry;

- (void) adustCoreDatainSection: (NSInteger*) section atRow:(NSInteger*) row doAdd: (bool) add;
- (IBAction)dismissView:(id)sender;

@end
