//
//  CartViewController.h
//  Virtual Fridge
//
//  Created by Patrick Hagen on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartViewController :UIViewController <UITableViewDataSource, UITableViewDelegate>
{
@private NSMutableArray *cartItems;
@private NSMutableArray *cartItemsCat;
    
}
@property (nonatomic, strong) NSMutableArray *cartItems;
@property (nonatomic, strong) NSMutableArray *cartItemsCat;

-(void) fetchCartAlpha;
-(void) fetchCartCat;
- (IBAction)segChangeEvent:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)CheckOut:(id)sender;
-(void)adjustCatDataUsingSection: (int) sec atRow: (int) row doAdd: (bool) add;
-(void)adjustAlphaDataUsingRow: (int) row doAdd: (bool) add;
-(void) unCheckAll;
@end
