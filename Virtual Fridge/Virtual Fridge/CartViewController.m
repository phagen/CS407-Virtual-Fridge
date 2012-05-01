//
//  CartViewController.m
//  Virtual Fridge
//
//  Created by Patrick Hagen on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CartViewController.h"
#import <CoreData/CoreData.h>
#import "Food.h"
#import "AppDelegate.h"


@implementation CartViewController
@synthesize cartItems;
@synthesize cartItemsCat;
@synthesize myTableView;

static int viewFlag = 0;

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
    cartItems = (NSMutableArray*) allItems;
    

}

-(void) fetchCartAlpha
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
                 [NSNumber numberWithInt:3], [NSNumber numberWithInt:6], [NSNumber numberWithInt:5], [NSNumber numberWithInt:7]];
    
    [fetchRequest setPredicate:predicate]; //fetch with predicate
    
    NSError *error;
    NSArray *allItems = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    cartItems = (NSMutableArray*) allItems;
    
}
-(void) fetchCartCat
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
    [cartItemsCat removeAllObjects];
    cartItemsCat = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [categories count]; i++)
    {
        NSMutableArray *allItems = [[NSMutableArray alloc] init];
        predicate = [NSPredicate predicateWithFormat: @"((state == %@ OR state == %@ OR state == %@ OR state == %@) AND category == %@)", 
                     [NSNumber numberWithInt:3], [NSNumber numberWithInt:6], [NSNumber numberWithInt:5], [NSNumber numberWithInt:7], [categories objectAtIndex:i]];
        
        [fetchRequest setPredicate:predicate]; //fetch with predicate
        
        NSError *error;
        allItems = ((NSMutableArray *)[appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error]);
        
        [cartItemsCat addObject:allItems];
    }
}   

- (IBAction)segChangeEvent:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (((UISegmentedControl *)sender).selectedSegmentIndex == 0) //alphabetical
    {
        viewFlag = 0;
        [self fetchCartAlpha];
       // [self transitionBackAll];
    }
    else //categories
    {
        viewFlag = 1; // This needed for reload
        [self fetchCartCat];
       // [self transitionBackAll];
    }
    NSError *error;
    [appDelegate.managedObjectContext save: &error];
    [self.myTableView reloadData];
}
- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(viewFlag == 0)
    {
        [self fetchCartAlpha];
    }
    else
    {
        [self fetchCartCat];
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
        return [cartItems count];
    }
    else if(viewFlag == 1)
    {
        return [[cartItemsCat objectAtIndex:section] count];
    }
    else
    {
         NSLog(@"Bad viewFlag state");
        return 1;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (viewFlag == 0)
    {
        cell.textLabel.text = ((Food *)[cartItems objectAtIndex:indexPath.row]).name;
        if(((Food *)[cartItems objectAtIndex:indexPath.row]).cart_sel == [NSNumber numberWithInt: 1])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }
    }
    else if (viewFlag == 1)
    {
        NSMutableArray* array = [cartItemsCat objectAtIndex: indexPath.section];
        cell.textLabel.text = ((Food *)[array objectAtIndex:indexPath.row]).name;
        if (((Food *)[array objectAtIndex:indexPath.row]).cart_sel == [NSNumber numberWithInt: 1]) 
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
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
            temp = [cartItems objectAtIndex:row];
        }
        else
        {
            temp = [[cartItemsCat objectAtIndex:sect] objectAtIndex:row];
        }
        switch (temp.state.intValue) {
            case 3:
                temp.state = [NSNumber numberWithInt: 0];
                break;
            case 5:
                temp.state = [NSNumber numberWithInt:2];
                break;
            case 6:
                temp.state = [NSNumber numberWithInt:1];
                break;
            case 7:
                temp.state = [NSNumber numberWithInt:4];
                break;
            default:
                NSLog(@"Error in deleting");
                break;
        }
        [self fetchCartAlpha];
        [self fetchCartCat];
        [self.myTableView reloadData];
       
        //Save DB
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSError *error;
        [appDelegate.managedObjectContext save: &error];

        
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)myTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Row: %d",[self.tableView indexPathForSelectedRow].section);
    int selSection = [self.myTableView indexPathForSelectedRow].section;
    int selRow = [self.myTableView indexPathForSelectedRow].row;
    
    UITableViewCell *thisCell = [myTableView cellForRowAtIndexPath:indexPath];
    if(viewFlag == 0)
    {
        if(thisCell.accessoryType == UITableViewCellAccessoryNone)
        {
            thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
            ((Food*)[cartItems objectAtIndex:selRow]).cart_sel = [NSNumber numberWithInt:1];
            
        }
        else
        {
            thisCell.accessoryType = UITableViewCellAccessoryNone;
            ((Food*)[cartItems objectAtIndex:selRow]).cart_sel = [NSNumber numberWithInt:0];
        }
    }
    else
    {
        
        if(thisCell.accessoryType == UITableViewCellAccessoryNone)
        {
            thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
            ((Food*)[[cartItemsCat objectAtIndex:selSection] objectAtIndex:selRow] ).cart_sel = [NSNumber numberWithInt:1];
           
        }
        else
        {
            thisCell.accessoryType = UITableViewCellAccessoryNone;
            ((Food*)[[cartItemsCat objectAtIndex:selSection] objectAtIndex:selRow] ).cart_sel = [NSNumber numberWithInt:0];
        }

    }
}
#pragma mark - Button Actions
- (IBAction)CheckOut:(id)sender {
    [self updateDbOnCheckOut];
    if(viewFlag == 0)
    {
        [self fetchCartAlpha];
    }
    else
    {
        [self fetchCartCat];
    }
    [self unCheckAll];
    [self.myTableView reloadData];
   
    
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"add"]) 
    {
        [self unCheckAll];
    }
}
#pragma mark - Helper Methods
-(void) unCheckAll
{
    for (UITableViewCell *cell in [myTableView visibleCells])
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}
-(void) updateDbOnCheckOut
{
    
    Food *temp;
    if (viewFlag == 0) {
        
    for(int i = 0; i < [cartItems count]; i++)
    {
        temp = [cartItems objectAtIndex:i];
        if(temp.cart_sel.intValue == 1)
        {
                temp.cart_sel = [NSNumber numberWithInt:0];
                switch (temp.state.intValue) {
                case 3:
                    temp.state = [NSNumber numberWithInt:1];
                    temp.purchase_date = [NSDate date];
                    temp.expiration_date = [temp.purchase_date addTimeInterval:(60*60*24*temp.expiration_offset.intValue)];                   
                    break;
                case 5:
                    temp.state = [NSNumber numberWithInt:4];
                    temp.purchase_date = [NSDate date];
                    temp.expiration_date = [temp.purchase_date addTimeInterval:(60*60*24*temp.expiration_offset.intValue)];
                    break;
                case 6:
                    temp.state = [NSNumber numberWithInt:1];
                    break;
                case 7:
                    temp.state = [NSNumber numberWithInt:4];
                    break;
                default:
                    NSLog(@"Error");
                    break;
            }   

        }
    }
    }
    else
    {
    for(int s = 0; s < [cartItemsCat count]; s++)
    {
        for(int r = 0; r < [[cartItemsCat objectAtIndex:s] count];r++)
        {
            temp = [[cartItemsCat objectAtIndex:s] objectAtIndex:r];
            if(temp.cart_sel.intValue == 1)
            {
            temp.cart_sel = [NSNumber numberWithInt:0];
            switch (temp.state.intValue) {
                case 3:
                    temp.state = [NSNumber numberWithInt:1];
                    temp.purchase_date = [NSDate date];
                    temp.expiration_date = [temp.purchase_date addTimeInterval:(60*60*24*temp.expiration_offset.intValue)];
                    break;
                case 5:
                    temp.state = [NSNumber numberWithInt:4];
                    temp.purchase_date = [NSDate date];
                    temp.expiration_date = [temp.purchase_date addTimeInterval:(60*60*24*temp.expiration_offset.intValue)];
                    break;
                case 6:
                    temp.state = [NSNumber numberWithInt:1];
                    break;
                case 7:
                    temp.state = [NSNumber numberWithInt:4];
                    break;
                default:
                    NSLog(@"Error");
                    break;
            } 
            }

        }
    }
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
    [appDelegate.managedObjectContext save: &error];
    
   }
@end
