//
//  ShoppingListViewController.m
//  Virtual Fridge
//
//  Created by Patrick Hagen on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShoppingListViewController.h"
#import <CoreData/CoreData.h>
#import "Food.h"
#import "AppDelegate.h"


@implementation ShoppingListViewController
@synthesize addToCart;

@synthesize listItems;
@synthesize listItemsCat;
@synthesize myTableView;
static int *viewFlag = 0;


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
    listItems = (NSMutableArray*) allItems;

}
- (IBAction)segChangeEvent:(id)sender {
    if (((UISegmentedControl *)sender).selectedSegmentIndex == 0) //alphabetical
    {
        viewFlag = 0;
        [self fetchListAlpha];
    }
    else //categories
    {
        viewFlag = 1; // This needed for reload
        [self fetchListCat];
    }
    [self.myTableView reloadData];
}

-(void) fetchListAlpha
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
                 [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], [NSNumber numberWithInt:5], [NSNumber numberWithInt:7]];
    
    [fetchRequest setPredicate:predicate]; //fetch with predicate
    
    NSError *error;
    NSArray *allItems = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    listItems = (NSMutableArray*) allItems;
    
}
-(void) fetchListCat
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
    [listItemsCat removeAllObjects];
    listItemsCat = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [categories count]; i++)
    {
        NSMutableArray *allItems = [[NSMutableArray alloc] init];
        predicate = [NSPredicate predicateWithFormat: @"((state == %@ OR state == %@ OR state == %@ OR state == %@) AND category == %@)", 
                     [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], [NSNumber numberWithInt:5], [NSNumber numberWithInt:7], [categories objectAtIndex:i]];
        
        [fetchRequest setPredicate:predicate]; //fetch with predicate
        
        NSError *error;
        allItems = ((NSMutableArray *)[appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error]);
        
        [listItemsCat addObject:allItems];
    }
}   




- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [self setAddToCart:nil];
    [super viewDidUnload];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(viewFlag == 0)
    {
        [self fetchListAlpha];
    }
    else
    {
        [self fetchListCat];
    }
    [self.myTableView reloadData];
    
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
        return [listItems count];
    }
    else if(viewFlag == 1)
    {
        return [[listItemsCat objectAtIndex:section] count];
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
        cell.textLabel.text = ((Food *)[listItems objectAtIndex:indexPath.row]).name;
    }
    else if (viewFlag == 1)
    {
        NSMutableArray* array = [listItemsCat objectAtIndex: indexPath.section];
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
        NSLog(@"Bad Flag State: ");
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
    int selSection = [self.myTableView indexPathForSelectedRow].section;
    int selRow = [self.myTableView indexPathForSelectedRow].row;
    
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    if(viewFlag == 0)
    {
        if(thisCell.accessoryType == UITableViewCellAccessoryNone)
        {
            thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self adjustAlphaDataUsingRow:selRow doAdd:TRUE];
        }
        else
        {
            thisCell.accessoryType = UITableViewCellAccessoryNone;
            [self adjustAlphaDataUsingRow:selRow doAdd:FALSE];
        }
    }
    else
    {
        
        if(thisCell.accessoryType == UITableViewCellAccessoryNone)
        {
            thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self adjustCatDataUsingSection:selSection atRow:selRow doAdd:TRUE];
        }
        else
        {
            thisCell.accessoryType = UITableViewCellAccessoryNone;
            [self adjustCatDataUsingSection:selSection atRow:selRow doAdd:FALSE];
        }
        
    }

   }
-(void)adjustAlphaDataUsingRow: (int) row doAdd: (bool) add
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Food *selected = ((Food*)[listItems objectAtIndex: row]);
    int currState = selected.state.intValue;
    if(add)
    {
        switch (currState) {
            case 2:
                selected.prev_state = selected.state;
                selected.state = [NSNumber numberWithInt:3];
                selected.comment = @"Edit to change comment.";
                break;
            case 4:
                selected.prev_state = selected.state;
                selected.state = [NSNumber numberWithInt:6];
                break;
            case 5:
                selected.prev_state = selected.state;
                selected.state = [NSNumber numberWithInt:3];
                break;
            case 7:
                selected.prev_state = selected.state;
                selected.state = [NSNumber numberWithInt:6];
                break;
            default:
                NSLog(@"Error");
                break;
        }
        
    }
    else
    {
        selected.state = selected.prev_state;
    }
    NSError *error;
    [appDelegate.managedObjectContext save: &error];
    
}
-(void)adjustCatDataUsingSection: (int) sec atRow: (int) row doAdd: (bool) add
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *sect = ((NSMutableArray*)[listItemsCat objectAtIndex: sec]);
    Food *selected = ((Food*)[sect objectAtIndex: row]);
    int currState = selected.state.intValue;
    if(add)
    {
        switch (currState) {
            case 2:
                selected.prev_state = selected.state;
                selected.state = [NSNumber numberWithInt:3];
                break;
            case 4:
                selected.prev_state = selected.state;
                selected.state = [NSNumber numberWithInt:6];
                break;
            case 5:
                selected.prev_state = selected.state;
                selected.state = [NSNumber numberWithInt:3];
                break;
            case 7:
                selected.prev_state = selected.state;
                selected.state = [NSNumber numberWithInt:6];
                break;
            default:
                NSLog(@"Error");
                break;
        }   
    }
    else
    {
        selected.state = selected.prev_state;
    }
    NSError *error;
    [appDelegate.managedObjectContext save: &error];
}

- (IBAction)addToCart:(id)sender {
    if (viewFlag == 0) {
        [self fetchListAlpha];
    }
    else
    {
        [self fetchListCat];
    }
    [self.myTableView reloadData];
}


@end
