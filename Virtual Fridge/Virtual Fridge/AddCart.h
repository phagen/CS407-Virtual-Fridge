//
//  AddCart.h
//  Virtual Fridge
//
//  Created by Patrick Hagen on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCart : UITableViewController
{
@private NSMutableArray *nonPantry;
}

@property (nonatomic, strong) NSMutableArray *nonPantry;

- (void) adustCoreDatainSection: (NSInteger*) section atRow:(NSInteger*) row doAdd: (bool) add;
- (IBAction)dissmissView:(id)sender;


@end
