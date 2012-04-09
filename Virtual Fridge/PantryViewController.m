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
@synthesize pantryItemsCat;

static int *viewFlag = 0;
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
        viewFlag = 0;
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
        viewFlag = 1; // This needed for reload
         
        NSArray *categories = [NSArray arrayWithObjects: @"produce", @"frozen food", @"bulk food", @"baking food", @"breads", @"meat and seafood", @"deli", @"bakery", @"dairy", @"pasta and rice", @"ethnic foods", @"canned foods", @"condiments", @"snacks", @"cereal", @"beverages", @"household items", @"health and beauty", @"other", nil];
        
        [pantryItemsCat removeAllObjects];
        pantryItemsCat = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < [categories count]; i++)
        {
            NSMutableArray *allItems = [[NSMutableArray alloc] init];
            predicate = [NSPredicate predicateWithFormat: @"((state == %@ OR state == %@ OR state == %@ OR state == %@) AND category == %@)", 
                         [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:6], [NSNumber numberWithInt:7], [categories objectAtIndex:i]];
        
            [fetchRequest setPredicate:predicate]; //fetch with predicate
            
            NSError *error;
            allItems = ((NSMutableArray *)[appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error]);
            
            [pantryItemsCat addObject:allItems];
        
            
        }
    }
    [self.tableView reloadData];
    
    
    
    
    
    
    
    
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
    if(viewFlag == 0)
    {
        return 1;
    }
    else if(viewFlag == 1)
    {
        return 19;
    }
    else
    {
        NSLog(@"Bad viewFlag state");
        return 1;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    // Return the number of rows in the section.
    if(viewFlag == 0)
    {
    return [pantryItems count];
    }
    else if(viewFlag == 1)
    {
        return [[pantryItemsCat objectAtIndex:section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (viewFlag == 0)
    {
        cell.textLabel.text = ((Food *)[pantryItems objectAtIndex:indexPath.row]).name;
    }
    else if (viewFlag == 1)
    {
        NSMutableArray* array = [pantryItemsCat objectAtIndex: indexPath.section];
        cell.textLabel.text = ((Food *)[array objectAtIndex:indexPath.row]).name;
    }
    
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(viewFlag == 0)
    {
       return @" "; 
    }
    else if (viewFlag == 1)
    {
        switch (section) {
            case 0:
                return @"Produce";
                break;
            case 1:
                return @"Frozen Food";
            case 2:
                return @"Bulk Food";
            case 3:
                return @"Baking Food";
            case 4:
                return @"Breads";
            case 5:
                return @"Meat and Seafood";
            case 6:
                return @"Deli";
            case 7:
                return @"Bakery";
            case 8:
                return @"Dairy";
            case 9:
                return @"Pasta and Rice";
            case 10:
                return @"Ethnic Food";
            case 11:
                return @"Canned Food";
            case 12:
                return @"Condiments";
            case 13:
                return @"Snacks";
            case 14:
                return @"Cereal";
            case 15:
                return @"Beverages";
            case 16:
                return @"Household Items"; 
            case 17:   
                return @"Health and Beauty";
            case 18:
                return @"Other";
            default:
                return @"Bad Access";
                break;
        }
    }
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
