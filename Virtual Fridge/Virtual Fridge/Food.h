//
//  Food.h
//  Virtual Fridge
//
//  Created by Patrick Hagen on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Food : NSManagedObject

@property (nonatomic, retain) NSNumber * cart_sel;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSDate * expiration_date;
@property (nonatomic, retain) NSNumber * expiration_offset;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * prev_state;
@property (nonatomic, retain) NSDate * purchase_date;
@property (nonatomic, retain) NSNumber * shop_sel;
@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) NSNumber * add_pantry_sel;
@property (nonatomic, retain) NSNumber * add_shop_sel;
@property (nonatomic, retain) NSNumber * add_cart_sel;

@end
