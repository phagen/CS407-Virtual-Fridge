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
@property (weak, nonatomic) IBOutlet UIButton *addToCart;
-(void)adjustAlphaDataUsingRow: (int) row doAdd: (bool) add;
-(void)adjustCatDataUsingSection: (int) sec atRow: (int) row doAdd: (bool) add;

- (IBAction)addToCart:(id)sender;

@end
