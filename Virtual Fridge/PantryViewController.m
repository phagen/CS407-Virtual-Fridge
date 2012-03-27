//
//  PantryViewController.m
//  Virtual Fridge
//
//  Created by Patrick Hagen on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "PantryViewController.h"
#import <CoreData/CoreData.h>
#import "Food.h"
#import "AppDelegate.h"


@implementation PantryViewController

@synthesize Food = _Food;
@synthesize s;
@synthesize pantryItems;
//@synthesize context = _context;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //Use predicate to get items from the database with parameters: syntax demonstrated below
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(state == %@ OR state == %@ OR state == %@ OR state == %@)", 
                              [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:6], [NSNumber numberWithInt:7]];
    [fetchRequest setPredicate:predicate]; //fetch with predicate
    
    NSSortDescriptor *sortDecsriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES]; //Call will be sorted
    [fetchRequest setSortDescriptors:[NSArray   arrayWithObject:sortDecsriptor]];
    
    NSError *error;
    NSArray *allItems = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    pantryItems = (NSMutableArray*) allItems;
    /*for(int i =0; i < [pantryItems count]; i++)
    {
        NSLog(@"Name: %@", ((Food *)[pantryItems objectAtIndex: i]).name);
        NSLog(@"State: %d",((Food *)[pantryItems objectAtIndex: i]).state.intValue);
    }*/

          
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)segmentChangeEvent:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDecsriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES]; //Call will be sorted
    [fetchRequest setSortDescriptors:[NSArray   arrayWithObject:sortDecsriptor]];
    
    NSPredicate *predicate;
    
    if (((UISegmentedControl *)sender).selectedSegmentIndex == 0) //alphabetical
    {
        predicate = [NSPredicate predicateWithFormat: @"(state == %@ OR state == %@ OR state == %@ OR state == %@)", 
                                  [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:6], [NSNumber numberWithInt:7]];
        
        [fetchRequest setPredicate:predicate]; //fetch with predicate
        
        NSError *error;
        NSArray *allItems = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        pantryItems = (NSMutableArray*) allItems;
        
        //TODO call refresh on the list
    }
    else //categories
    {
        NSArray *categories = [NSArray arrayWithObjects: @"produce", @"frozen food", @"bulk food", @"baking food", @"breads", @"meat and seafood", @"deli", @"bakery", @"dairy", @"pasta and rice", @"ethnic foods", @"canned foods", @"condiments", @"snacks", @"cereal", @"beverages", @"household items", @"health and bueaty", @"other"];
        
        for(int i = 0; i < categories.count; i++)
        {
            predicate = [NSPredicate predicateWithFormat: @"(state == %@ OR state == %@ OR state == %@ OR state == %@ AND category == %@)", 
                         [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:6], [NSNumber numberWithInt:7], [categories objectAtIndex:[NSNumber numberWithInt:i]]];
        
            [fetchRequest setPredicate:predicate]; //fetch with predicate
            
            NSError *error;
            NSArray *allItems = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            
            [pantryItems addObject:allItems];
            
            
        }
        
        //TODO call refresh on the list
    }
    
    
    
    
    
    
    
    
}
                              
                              
/* cleanItems DEPRECATED
+(NSMutableArray*) cleanItems: (NSArray*) array
{
    int i = 0;
    int state = -1;
    NSMutableArray *temp = [[NSMutableArray alloc] init];
   // Food *item;
    while(i < [array count])
    {
        state = ((Food*)[array objectAtIndex:i]).state.intValue;
        if(state == 1 || state == 4 || state == 6 || state == 7)
        {
            [temp addObject: [array objectAtIndex:i]];
        }
        i++;
    }
    return temp;
}*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    // Return the number of rows in the section.
    return [pantryItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = ((Food *)[pantryItems objectAtIndex:indexPath.row]).name;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
