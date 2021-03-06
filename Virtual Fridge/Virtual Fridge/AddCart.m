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


@synthesize searchBar;
@synthesize nonCart;
@synthesize filtered;

static bool isFiltered = FALSE;
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
    
    searchBar.delegate = (id)self;
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
    
    nonCart = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [categories count]; i++)
    {
        NSMutableArray *allItems = [[NSMutableArray alloc] init];
        predicate = [NSPredicate predicateWithFormat: @"((state == %@ OR state == %@ OR state == %@ OR state == %@) AND category == %@)", 
                     [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4],[NSNumber numberWithInt:0], [categories objectAtIndex:i]];
        
        [fetchRequest setPredicate:predicate]; //fetch with predicate
        
        NSError *error;
        allItems = ((NSMutableArray *)[appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error]);
        
        [nonCart addObject:allItems];
        
    }
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
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
    if (isFiltered) {
        return 1;
    }
    else{
        return 19;
    }
}
    

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if(isFiltered)
    {
        return [filtered count];
    }
    return [[nonCart objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    Food *currCell;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    if(isFiltered){
        currCell = [filtered objectAtIndex:indexPath.row];
    }
    else
    {
        currCell = [[nonCart objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    if(currCell.add_cart_sel.intValue == 1){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = currCell.name;
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(isFiltered){
        return @"";
    }
    
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
        if(isFiltered){
            ((Food *)[filtered objectAtIndex:selRow]).add_cart_sel = [NSNumber numberWithInt:1];
        }
        else{
            ((Food *)[[nonCart objectAtIndex:selSection]objectAtIndex:selRow]).add_cart_sel = [NSNumber numberWithInt:1];
        }
    }
    else
    {
        thisCell.accessoryType = UITableViewCellAccessoryNone;
        if(isFiltered){
            ((Food *)[filtered objectAtIndex:selRow]).add_cart_sel = [NSNumber numberWithInt:0];
        }
        else{
            ((Food *)[[nonCart objectAtIndex:selSection]objectAtIndex:selRow]).add_cart_sel = [NSNumber numberWithInt:0];
        }
    }
}
- (IBAction)dissmissView:(id)sender {
    isFiltered = FALSE;
    //Update the database
    [self updateDB];
    //Save state of database
    [self saveDB];
    //Dismiss view
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - Search Bar
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    Food *temp;
    NSString *sub;
    if(text.length == 0)
    {
        isFiltered = FALSE;
        [self.searchBar resignFirstResponder];
    }
    else
    {
        isFiltered = TRUE;
        filtered = [[NSMutableArray alloc] init];
        for(int s =0; s < [nonCart count]; s++)
        {
            for(int r=0; r <[[nonCart objectAtIndex:s] count]; r++)
            {
                temp = ((Food*)[[nonCart objectAtIndex:s] objectAtIndex:r]);
                if(sub.length <= temp.name.length)
                {
                    sub = [temp.name substringToIndex:text.length];
                    
                    if([sub.lowercaseString isEqualToString:text.lowercaseString])
                    {
                        [filtered addObject:temp];
                    }
                }
            }
        }
    }
    [self.tableView reloadData];
}



#pragma mark - Helper Methods
-(void)saveDB{
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
    [appDelegate.managedObjectContext save: &error];
    return;
}
-(void) updateDB{
    Food *temp;
    for(int s = 0; s < [nonCart count]; s++)
    {
        for (int r = 0; r < [[nonCart objectAtIndex:s] count]; r++) {
            temp = [[nonCart objectAtIndex:s]objectAtIndex:r];
            if(temp.add_cart_sel.intValue == 1)
            {
                switch (temp.state.intValue) {
                    case 0:
                        temp.state = [NSNumber numberWithInt:3];
                        break;
                    case 1:
                        temp.state = [NSNumber numberWithInt:6];
                        break;
                    case 2:
                        temp.state = [NSNumber numberWithInt:5];
                        break;
                    case 4:
                        temp.state = [NSNumber numberWithInt:7];
                        break;
                    default:
                        NSLog(@"Invalid State Error");
                        break;
                }
            }
            temp.add_cart_sel = [NSNumber numberWithInt:0];
        }
    }
    
}
#pragma mark - Unused TableView Methods
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


@end
