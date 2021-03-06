//
//  AddPantry.h
//  Virtual Fridge
//
//  Created by Patrick Hagen on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPantry : UITableViewController
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
