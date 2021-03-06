//
//  epicuriousWebPage.m
//  Virtual Fridge
//
//  Created by Patrick Hagen on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "epicuriousWebPage.h"

@implementation epicuriousWebPage
@synthesize webView;

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *url = @"http://epicurious.com";
    
    //Create a URL object.
    NSURL *theUrl = [NSURL URLWithString:url];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:theUrl];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
}


- (void)viewDidUnload
{
    [self setWebView:nil];
    webView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
