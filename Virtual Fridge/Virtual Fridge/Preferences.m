//
//  Preferences.m
//  Virtual Fridge
//
//  Created by Matt Wysocki on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Preferences.h"

@implementation Preferences

+ (Boolean)notifications
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"notifications"];
}

@end
