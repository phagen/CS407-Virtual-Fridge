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
#import "ItemDetailController.h"
#import "Preferences.h"


@implementation PantryViewController

@synthesize pantryItems;
@synthesize pantryItemsCat;
@synthesize delete;

static int viewFlag = 0;
static int alertFlag = 0;
static int alertNeeded = 0;


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
    Boolean pref = [Preferences notifications];
    
    if(alertFlag == 0 && pref){
        Food * food;
        //NSString * alertMessage;
        NSDate * date;
        NSDate * expiration;
        expiration = [[NSDate date] addTimeInterval:(60*60*24*10*[Preferences expirationDays])];
        NSMutableString * message = [[NSMutableString alloc] init];
        
        [message appendFormat:@"The following items are going to expire in the next %d days: \n", [Preferences expirationDays]];
        
        for(int i = 0; i < [pantryItems count]; i++){
            food = ((Food*)[pantryItems objectAtIndex:i]);
            date = food.expiration_date;
            NSTimeInterval time;
            time = [date timeIntervalSinceDate:expiration];
            if (time < 0){
                alertNeeded = 1;
                [message appendFormat:@"%@\n", food.name];
            }
        
        }
        if(alertNeeded == 1)
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your food is expiring!!!!!" 
                                                            message:message
                                                           delegate:nil 
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        alertFlag = 1;
    }
    
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
    if (((UISegmentedControl *)sender).selectedSegmentIndex == 0) //alphabetical
    {
        viewFlag = 0;
        [self fetchPantryAlpha];
    }
    else //categories
    {
        viewFlag = 1; // This needed for reload
        [self fetchPantryCat];
    }
    [self.tableView reloadData];
}


- (IBAction)listSeg:(id)sender {
}

-(void) fetchPantryAlpha
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDecsriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES]; //Call will be sorted
    [fetchRequest setSortDescriptors:[NSArray   arrayWithObject:sortDecsriptor]];
    
    NSPredicate *predicate;
    predicate = [NSPredicate predicateWithFormat: @"(state == %@ OR state == %@ OR state == %@ OR state == %@)", 
                 [NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:6], [NSNumber numberWithInt:7]];
    
    [fetchRequest setPredicate:predicate]; //fetch with predicate
    
    NSError *error;
    NSArray *allItems = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    pantryItems = (NSMutableArray*) allItems;

}
- (void)viewDidUnload
{
    [self setDelete:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) fetchPantryCat
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDecsriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES]; //Call will be sorted
    [fetchRequest setSortDescriptors:[NSArray   arrayWithObject:sortDecsriptor]];
    
    NSPredicate *predicate;
    
    NSArray *categories = [NSArray arrayWithObjects: @"Produce", @"Frozen Food", @"Bulk Food", @"Baking Food", @"Breads", @"Meat and Seafood", @"Deli", @"Bakery", @"Dairy", @"Pasta and Rice", @"Ethnic Foods", @"Canned Foods", @"Condiments", @"Snacks", @"Cereal", @"Beverages", @"Household Items", @"Health and Beauty", @"Other", nil];
    
    categories = [categories sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
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
                              

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(viewFlag == 0)
    {
        [self fetchPantryAlpha];
    }
    else
    {
        [self fetchPantryCat];
    }
    [self.tableView reloadData];
   
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
    else
    {
        NSLog(@"State Error PantryView");
        return 1;
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
       return @""; 
    }
    else if (viewFlag == 1)
    {
        switch (section) {
            case 0:
                return @"Bakery";
                break;
            case 1:
                return @"Baking Food";
            case 2:
                return @"Beverages";
            case 3:
                return @"Breads";
            case 4:
                return @"Bulk Food";
            case 5:
                return @"Canned Goods";
            case 6:
                return @"Cereal";
            case 7:
                return @"Condiments";
            case 8:
                return @"Dairy";
            case 9:
                return @"Deli";
            case 10:
                return @"Ethnic Food";
            case 11:
                return @"Frozen Food";
            case 12:
                return @"Health and Beauty";
            case 13:
                return @"Household Items";
            case 14:
                return @"Meat and Seafood";
            case 15:
                return @"Other";
            case 16:
                return @"Pasta and Rice"; 
            case 17:   
                return @"Produce";
            case 18:
                return @"Snacks";
            default:
                return @"Bad Access";
                break;
        }
    }
    else
    {
        NSLog(@"State Error View Controller Function Title");
        return @"";
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



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Food *temp;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger row = indexPath.row;
        NSInteger sect = indexPath.section;
        if(viewFlag == 0)
        {
            temp = [pantryItems objectAtIndex:row];
        }
        else
        {
            temp = [[pantryItemsCat objectAtIndex:sect] objectAtIndex:row];
        }
        switch (temp.state.intValue) {
            case 1:
                temp.state = [NSNumber numberWithInt: 0];
                break;
            case 4:
                temp.state = [NSNumber numberWithInt:2];
                break;
            case 6:
                temp.state = [NSNumber numberWithInt:3];
                break;
            case 7:
                temp.state = [NSNumber numberWithInt:5];
                break;
            default:
                NSLog(@"Error in deleting");
                break;
        }
        [self fetchPantryCat];
        [self fetchPantryAlpha];
        [self.tableView reloadData];
        
        
        //Save DB
         AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSError *error;
        [appDelegate.managedObjectContext save: &error];
        return;
    }   
   
}


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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
   if ([[segue identifier] isEqualToString:@"itemDetail"]) {
        Food *item;
       ItemDetailController *nextViewController = [segue destinationViewController];
        NSUInteger row = [self.tableView indexPathForSelectedRow].row;
        NSUInteger sect = [self.tableView indexPathForSelectedRow].section;
        if (viewFlag == 0) {
            item = [pantryItems objectAtIndex:row];
        }
        else
        {
            item = [[pantryItemsCat objectAtIndex:sect] objectAtIndex:row];
        }
        nextViewController.food = item;
   }
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)myTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
