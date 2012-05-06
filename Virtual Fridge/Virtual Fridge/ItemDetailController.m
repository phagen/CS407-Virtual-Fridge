//
//  ItemDetailController.m
//  Virtual Fridge
//
//  Created by Matt Wysocki on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemDetailController.h"
#import "Food.h"
#import "CustomDetailCell.h"
#import "AppDelegate.h"


@implementation ItemDetailController
@synthesize editButton;
@synthesize datePicker;

@synthesize food;
@synthesize myTableView;
@synthesize navBar;

static int editMode = 0;
static bool editPurchase = FALSE;
static bool editExp = FALSE;

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
     self.navBar.topItem.title = food.name;
}

- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [self setNavBar:nil];


    [self setEditButton:nil];
    [self setDatePicker:nil];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)myTableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];

    static NSString *CellIdentifier = @"custom";
    
    CustomDetailCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CustomDetailCell alloc]
                initWithStyle:UITableViewCellStyleDefault 
                reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.row) {
        case 0:
            cell.left.text = @"Name:";
            cell.right.text = food.name;
            break;
        case 1:
            cell.left.text = @"Category:";
            cell.right.text = food.category;
            break;
        case 2:
            cell.left.text = @"Experation Date:";
            if(editMode == 1 && !editExp)
            {
                cell.right.text = @"Tap to Edit";
            }
            else if(editExp)
            {
                cell.right.text = @" ";
            }
            else
            {
                cell.right.text = [dateFormat stringFromDate:food.expiration_date];
            }
            break;
        case 3:
            cell.left.text = @"Purchase Date:";
            if(editMode == 1 && !editPurchase)
            {
                cell.right.text = @"Tap to Edit";
            }
            else if(editPurchase)
            {
                cell.right.text = @" ";
            }
            else
            {
                cell.right.text = [dateFormat stringFromDate:food.purchase_date];
            }
            break;
        default:
            cell.left.text = @"Error";
            cell.right.text = @"Error";
            break;
    }
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

- (void)tableView:(UITableView *)myTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //CustomDetailCell *cell = ((CustomDetailCell*)[self.myTableView cellForRowAtIndexPath:indexPath]);
   if(editMode == 1)
   {
       switch (indexPath.row) {
           case 2:
               [self.datePicker setDate:food.expiration_date];
               [self.datePicker setHidden:NO];
               editExp = TRUE;
               editPurchase = FALSE;
               break;
            case 3:
               [self.datePicker setDate:food.purchase_date];
               [self.datePicker setHidden:NO];
               editPurchase = TRUE;
               editExp = FALSE;
               break;
           default:
               break;
       }
       [self.myTableView reloadData];
   }
}

- (IBAction)doneButton:(id)sender {
    if (editMode == 1) {
        editMode = 0;
        [self.datePicker setHidden:YES];
        editExp = FALSE;
        editPurchase = FALSE;
        [self.myTableView reloadData];
    }
    else
    {
        [self saveDB];
        [self dismissModalViewControllerAnimated:YES];
        
    }
}

- (IBAction)addToList:(id)sender {
    if(editMode == 0)
    {
        switch (food.state.intValue) {
            case 1:
                food.state = [NSNumber numberWithInt:2];
                break;
            case 4:
                food.state = [NSNumber numberWithInt:2];
                food.comment = @"Edit to change comment";
                break;
            case 6:
                food.state = [NSNumber numberWithInt:5];
                food.comment = @"Edit to change comment";
                break;
            case 7:
                food.state = [NSNumber numberWithInt:5];
                food.comment = @"Edit to change comment";
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
}

- (IBAction)edit:(id)sender {
    if(editMode == 0)
    {
        editMode = 1;
        [self.myTableView reloadData];
    }
}
- (IBAction)dateChange:(id)sender {
    if(editPurchase){
        food.purchase_date = [datePicker date];
    }
    else if(editExp){
        food.expiration_date = [datePicker date];
    }
    else {
        NSLog(@"How did you get here?");
    }
}
-(void) saveDB{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
    [appDelegate.managedObjectContext save: &error];
    return;

}
@end
