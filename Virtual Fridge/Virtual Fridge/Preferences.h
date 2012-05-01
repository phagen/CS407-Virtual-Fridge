//
//  Preferences.h
//  Virtual Fridge
//
//  Created by Matt Wysocki on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preferences : NSObject
{
    
}

+ (Boolean)notifications;
+ (float)expirationDays;
+ (void)setNotifications:(Boolean)notifications;
+ (void)setExpirationDays:(float)expirationDays;
@end
