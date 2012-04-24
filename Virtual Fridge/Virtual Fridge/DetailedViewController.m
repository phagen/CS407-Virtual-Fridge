//
//  DetailedViewController.m
//  Virtual Fridge
//
//  Created by Patrick Hagen on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailedViewController.h"
#import "Food.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@implementation DetailedViewController
@synthesize navBar;
@synthesize category;
@synthesize comment;
@synthesize expDate;
@synthesize purDate;
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
    self.comment.text = selectedFood.comment;
    self.navBar.topItem.title = selectedFood.name;
    //Need to format dates
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    self.purDate.text = [dateFormat stringFromDate:selectedFood.purchase_date];
    self.expDate.text = [dateFormat stringFromDate:selectedFood.expiration_date];
}


- (void)viewDidUnload
{
    [self setName:nil];
    [self setNavBar:nil];
    [self setCategory:nil];
    [self setComment:nil];
    [self setExpDate:nil];
    [self setPurDate:nil];
    [super viewDidUnload];
    }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addToList:(id)sender {
    switch (selectedFood.state.intValue) {
        case 1:
            selectedFood.state = [NSNumber numberWithInt:2];
            break;
        case 4:
            selectedFood.state = [NSNumber numberWithInt:2];
            selectedFood.comment = @"Edit to change comment";
            break;
        case 6:
            selectedFood.state = [NSNumber numberWithInt:5];
            selectedFood.comment = @"Edit to change comment";
            break;
        case 7:
            selectedFood.state = [NSNumber numberWithInt:5];
            selectedFood.comment = @"Edit to change comment";
            break;
        default:
            NSLog(@"Invalid State Error");
            break;
    }
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
    [appDelegate.managedObjectContext save: &error];
    [self dismissModalViewControllerAnimated:YES];
    
}
@end
