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
    @private NSMutableArray *listItems;
    @private NSMutableArray *listItemsCat;

}
@property (nonatomic, strong) NSMutableArray *listItems;
@property (nonatomic, strong) NSMutableArray *listItemsCat;


-(void) fetchListAlpha;
-(void) fetchListCat;
@end
