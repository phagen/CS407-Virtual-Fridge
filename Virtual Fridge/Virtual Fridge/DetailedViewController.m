//
//  DetailedViewController.m
//  Virtual Fridge
//
//  Created by Patrick Hagen on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailedViewController.h"
#import "Food.h"

@implementation DetailedViewController
@synthesize navBar;
@synthesize category;
@synthesize name, foodName;
@synthesize selectedFood;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Init Screen Vars
    self.name.text = selectedFood.name;
    self.category.text = selectedFood.category;
    self.navBar.topItem.title = selectedFood.name;
    
}


- (void)viewDidUnload
{
    [self setName:nil];
    [self setNavBar:nil];
    [self setCategory:nil];
    [super viewDidUnload];
    }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
