//
//  ShoppingListViewController.h
//  Virtual Fridge
//
//  Created by Patrick Hagen on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface ShoppingListViewController : UITableViewController
{
    @private NSMutableArray *pantryItems;
}
@property (nonatomic, strong) NSMutableArray *pantryItems;

+ (NSMutableArray *) cleanItems: (NSMutableArray*) array;

@end
