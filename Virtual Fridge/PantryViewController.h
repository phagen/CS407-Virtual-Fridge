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
    @private NSMutableArray *pantryItems;
    @private NSMutableArray *pantryItemsCat;
}

@property (nonatomic, strong) NSMutableArray *pantryItems;
@property (nonatomic, strong) NSMutableArray *pantryItemsCat;


-(void) fetchPantryAlpha;
-(void) fetchPantryCat;

@end