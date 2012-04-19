//
//  ItemDetailController.h
//  Virtual Fridge
//
//  Created by Matt Wysocki on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface ItemDetailController : UITableViewController {
    Food *food;
    
}

@property (nonatomic, strong) Food *food;


@end
