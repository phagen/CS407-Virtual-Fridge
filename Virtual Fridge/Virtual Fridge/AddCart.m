//
//  AddCart.m
//  Virtual Fridge
//
//  Created by Patrick Hagen on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//
//  AddShoppingList.m
//  Virtual Fridge
//
//  Created by Patrick Hagen on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddCart.h"
#import <CoreData/CoreData.h>
#import "Food.h"
#import "AppDelegate.h"
#import "Foundation/NSValue.h"
#import "PantryViewController.h"



@implementation AddCart


@synthesize nonPantry;


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
    
    NSSortDescriptor *sortDecsriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES]; //Call will be sorted
    [fetchRequest setSortDescriptors:[NSArray   arrayWithObject:sortDecsriptor]];
    
    NSPredicate *predicate;
    
    
     NSArray *categories = [NSArray arrayWithObjects: @"Produce", @"Frozen Food", @"Bulk Food", @"Baking Food", @"Breads", @"Meat and Seafood", @"Deli", @"Bakery", @"Dairy", @"Pasta and Rice", @"Ethnic Foods", @"Canned Foods", @"Condiments", @"Snacks", @"Cereal", @"Beverages", @"Household Items", @"Health and Beauty", @"Other", nil];
    
    categories = [categories sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    nonPantry = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [categories count]; i++)
    {
        NSMutableArray *allItems = [[NSMutableArray alloc] init];
        predicate = [NSPredicate predicateWithFormat: @"((state == %@ OR state == %@ OR state == %@ OR state == %@) AND category == %@)", 
                     [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4],[NSNumber numberWithInt:0], [categories objectAtIndex:i]];
        
        [fetchRequest setPredicate:predicate]; //fetch with predicate
        
        NSError *error;
        allItems = ((NSMutableArray *)[appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error]);
        
        [nonPantry addObject:allItems];
        
    }
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

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
    return 19;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [[nonPantry objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    NSMutableArray* array = [nonPantry objectAtIndex: indexPath.section];
    cell.textLabel.text = ((Food *)[array objectAtIndex:indexPath.row]).name;
    
    
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
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
    //NSLog(@"Row: %d",[self.tableView indexPathForSelectedRow].section);
    int selSection = [self.tableView indexPathForSelectedRow].section;
    int selRow = [self.tableView indexPathForSelectedRow].row;
    
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(thisCell.accessoryType == UITableViewCellAccessoryNone)
    {
        thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self adustCoreDatainSection:selSection atRow:selRow doAdd:TRUE];
    }
    else
    {
        thisCell.accessoryType = UITableViewCellAccessoryNone;
        [self adustCoreDatainSection:selSection atRow:selRow doAdd:false];
    }
}
-(void) adustCoreDatainSection: (int) sec atRow:(int) row doAdd: (bool) add
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *sect = ((NSMutableArray*)[nonPantry objectAtIndex: sec]);
    Food *selected = ((Food*)[sect objectAtIndex: row]);
    int currState = selected.state.intValue;
    if(add)
    {
        switch (currState) {
            case 0:
                selected.state = [NSNumber numberWithInt:3];
                break;
            case 1:
                selected.state = [NSNumber numberWithInt:6];
                break;
            case 2:
                selected.state = [NSNumber numberWithInt:5];
                break;
            case 4:
                selected.state = [NSNumber numberWithInt:7];
                break;
            default:
                NSLog(@"Invalid State Error");
                break;
        }
    }
    else
    {
        switch (currState) {
            case 3:
                selected.state = [NSNumber numberWithInt:0];
                break;
            case 6:
                selected.state = [NSNumber numberWithInt:1];
                break;
            case 5:
                selected.state = [NSNumber numberWithInt:2];
                break;
            case 7:
                selected.state = [NSNumber numberWithInt:4];
                break;
            default:
                NSLog(@"Invalid State Error");
                break;
        }
        
    }
    NSError *error;
    [appDelegate.managedObjectContext save: &error];
    return;
}

- (IBAction)dissmissView:(id)sender {
     [self dismissModalViewControllerAnimated:YES];
}

@end
