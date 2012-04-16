//
//  CartViewController.h
//  Virtual Fridge
//
//  Created by Patrick Hagen on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartViewController : UITableViewController
{
@private NSMutableArray *cartItems;
@private NSMutableArray *cartItemsCat;
    
}
@property (nonatomic, strong) NSMutableArray *cartItems;
@property (nonatomic, strong) NSMutableArray *cartItemsCat;


-(void) fetchCartAlpha;
-(void) fetchCartCat;

@end
