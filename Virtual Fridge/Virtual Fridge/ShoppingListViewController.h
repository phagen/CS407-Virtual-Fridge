//
//  ShoppingListViewController.h
//  Virtual Fridge
//
//  Created by Patrick Hagen on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface ShoppingListViewController :UIViewController <UITableViewDataSource, UITableViewDelegate>{
    @private NSMutableArray *listItems;
    @private NSMutableArray *listItemsCat;

}
@property (nonatomic, strong) NSMutableArray *listItems;
@property (nonatomic, strong) NSMutableArray *listItemsCat;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)segChangeEvent:(id)sender;
-(void) fetchListAlpha;
-(void) fetchListCat;


@end
