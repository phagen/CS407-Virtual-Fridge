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
    @private NSMutableArray *filtered;

}

@property (nonatomic, strong) NSMutableArray *nonPantry;
@property (nonatomic, strong) NSMutableArray *filtered;


- (IBAction)dismissView:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

//Helper Functions
-(void) saveDB;
-(void) updateDB;

@end

