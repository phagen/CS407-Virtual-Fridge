//
//  AppDelegate.m
//  Virtual Fridge
//
//  Created by Patrick Hagen on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Food.h"
#import "PantryViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

-(void) initCoreData
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    Food *food = nil;
    //Food *food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
    
    NSArray *bakery = [NSArray arrayWithObjects:@"Boxed Cakes - Angel Food",@"Boxed Cakes",@"Vanilla",@"Boxed Cakes - Swirl",@"Boxed Cakes - Chocolate",@"Boxed Cakes - Other",@"Bread - Bakery",@"Cupcakes",@"Danishes",@"Donuts",@"Fruit Pies",@"Muffins",@"Other Pastries",nil];
    
    for (int i = 0; i < [bakery count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[bakery objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Bakery";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:3];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *bakingfood = [NSArray arrayWithObjects:@"Baking Chips - Milk Chocolate",@"Baking Chips - Butterscotch",@"Baking Chips - Peanut Butter",@"Baking Chips - Other",@"Baking Soda",@"Bread Mix",@"Brownie Mix - Chocolate",@"Brownie Mix - Fudge",@"Brownie Mix - Other",@"Basil",@"Bay Leaves",@"Cajun Seasoning",@"Cayenne Powder",@"Chicken Seasoning",@"Chili Powder",@"Chives",@"Cinnamon",@"Cookie Mix - Chocolate Chip",@"Cookie Mix - Peanut Butter",@"Cookie Mix - Oatmeal",@"Cookie Mix - Sugar",@"Cookie Mix - Other",@"Coriander",@"Cornbread Mix",@"Croutons",@"Cumin",@"Dill",@"Flour",@"Frosting",@"Garlic Powder",@"Garlic Salt",@"Ginger",@"Italian Seasoning",@"Jell-O Mix",@"Lemon Seed",@"Majarom",@"Marshmellows",@"Mint",@"Muffin Mix - Blueberry",@"Muffin Mix - Chocolate Chip",@"Muffin Mix - Other",@"Mustard Seed",@"Nutmeg",@"Nuts - Walnuts",@"Nuts - Hazelnuts",@"Nuts - Peanuts",@"Nuts - Pecans",@"Nuts - Other",@"Oils - Vegetable",@"Oils - Olive",@"Oils - Peanut",@"Oils - Sesame",@"Oils - Spray",@"Oils - Other",@"Onion Powder",@"Oregano",@"Other Dessert Mix",@"Other Spices",@"Paprika",@"Pepper",@"Pie Crust",@"Pie Mix - Apple",@"Pie Mix - Cherry",@"Pie Mix - Chocolate",@"Pie Mix - Key Lime",@"Pie Mix - French Silk",@"Pie Mix - Lemon Meringue",@"Pie Mix - Pumpkin",@"Pie Mix - Strawberry",@"Pie Mix - Other",@"Pudding Mix - Rice",@"Pudding Mix - Chocolate",@"Pudding Mix - Vanilla",@"Pudding Mix - Other",@"Red Pepper",@"Rosemary",@"Sage",@"Salt",@"Sugar - Regular",@"Sugar - Brown",@"Sugar - Other",@"Sugar Substitute",@"Thyme",@"Yeast",nil];
    
    for (int i = 0; i < [bakingfood count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[bakingfood objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Baking Food";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:365];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *beverages = [NSArray arrayWithObjects:@"Apple Juice",@"Beer",@"Bottled Water",@"Coffee",@"Grape Juice",@"Liquor",@"Orange Juice",@"Other Fruit Juice",@"Powder Drinks",@"Soft Drinks",@"Tea",@"Wine",nil];
    
    for (int i = 0; i < [beverages count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[beverages objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Beverages";
        food.comment = @"Edit to change comment.";
        
        switch (i) {
            case 0:
            case 4:
            case 7:
                food.expiration_offset = [NSNumber numberWithInt:90];
                break;
                
            case 1:
            case 9:
                food.expiration_offset = [NSNumber numberWithInt:270];
                break;
                
            case 2:
            case 11:
                food.expiration_offset = [NSNumber numberWithInt:730];
                break;
                
            case 3:
                food.expiration_offset = [NSNumber numberWithInt:180];
                break;
                
            case 5:
                food.expiration_offset = [NSNumber numberWithInt:1000];
                break;
                
            case 6:
                food.expiration_offset = [NSNumber numberWithInt:14];
                break;
                
            case 8:
            case 10:
                food.expiration_offset = [NSNumber numberWithInt:365];
                break;
                
            default:
                break;
        }
        
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *breads = [NSArray arrayWithObjects:@"Bagels",@"Biscuits",@"Bread - White",@"Bread - Multi-Grain",@"Bread - Wheat",@"Bread - Rye",@"Bread - Other",@"Buns - Hamburger",@"Buns - Hot Dog",@"Rolls",nil];
    
    for (int i = 0; i < [breads count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[breads objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Breads";
        food.comment = @"Edit to change comment.";
        
        switch (i) {
            case 0:
            case 2:
            case 3:
            case 4:
            case 7:
            case 8:
                food.expiration_offset = [NSNumber numberWithInt:7];
                break;
                
            case 1:
            case 9:
                food.expiration_offset = [NSNumber numberWithInt:3];
                break;
                
            case 5:
            case 6:
                food.expiration_offset = [NSNumber numberWithInt:5];
                break;
                
            default:
                break;
        }
        
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    
    NSArray *cannedgoods = [NSArray arrayWithObjects:@"Apple Sauce",@"Canned Fruit - Oranges",@"Canned Fruit - Peaches",@"Canned Fruit - Pears",@"Canned Fruit - Pineapple",@"Canned Fruit - Fruit Cocktail",@"Canned Fruit - Other",@"Canned Seafood - Anchovies",@"Canned Seafood - Clams",@"Canned Seafood - Crab",@"Canned Seafood - Oysters",@"Canned Seafood - Salmon",@"Canned Seafood - Sardines",@"Canned Seafood - Tuna",@"Canned Seafood - Other",@"Canned Veggies - Artichokes",@"Canned Veggies - Baked Beans",@"Canned Veggies - Black Beans",@"Canned Veggies - Carrots",@"Canned Veggies - Chick Peas",@"Canned Veggies - Corn",@"Canned Veggies - Cream-Style Corn",@"Canned Veggies - Green Beans",@"Canned Veggies - Kidney Beans",@"Canned Veggies - Mixed Vegetables",@"Canned Veggies - Mushrooms",@"Canned Veggies - Black Olives",@"Canned Veggies - Green Olives",@"Canned Veggies - Onions",@"Canned Veggies - Peas",@"Canned Veggies - Pinto Beans",@"Canned Veggies - Potatoes",@"Canned Veggies - Red Beans",@"Canned Veggies - Refried Beans",@"Canned Veggies - Sauerkraut",@"Canned Veggies - Spinach",@"Canned Veggies - Tomato Paste",@"Canned Veggies - Tomatoes",@"Canned Veggies - Water Chestnuts",@"Canned Veggies - Yams",@"Canned Veggies - Other",@"Chicken",@"Chili",@"Corned Beef Hash",@"Marinades",@"Pesto",@"Peanut Sauce",@"Sloppy Joe Mix",@"Soup - Chicken Noodle",@"Soup - Tomato",@"Soup - Cream of Mushroom",@"Soup - Cream of Chicken",@"Soup - Broccoli and Cheese",@"Soup - Chicken Broth",@"Soup - Beef Broth",@"Soup - Other",@"Spam",nil];
    
    for (int i = 0; i < [cannedgoods count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[cannedgoods objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Canned Foods";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:365];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *breakfast = [NSArray arrayWithObjects:@"Cereal",@"Breakfast Bars",@"Eggs - Medium",@"Eggs - Large",@"Egg Beaters",@"French Toast",@"Granola Bars",@"Oats",@"Pancakes",@"Waffles",nil];
    
    for (int i = 0; i < [breakfast count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[breakfast objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Cereal";
        food.comment = @"Edit to change comment.";
        
        switch (i) {
                
            case 0:
            case 1:
            case 6:
            case 7:
                food.expiration_offset = [NSNumber numberWithInt:365];
                break;
                
            case 2:
            case 3:
                food.expiration_offset = [NSNumber numberWithInt:28];
                break;
                
            case 4:
                food.expiration_offset = [NSNumber numberWithInt:90];
                break;
                
            case 5:
            case 8:
            case 9:
                food.expiration_offset = [NSNumber numberWithInt:180];
                break;
                
            default:
                break;
        }
        
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    
    NSArray *condiments = [NSArray arrayWithObjects:@"Alfredo Sauce",@"BBQ Sauce",@"Honey",@"Gravy",@"Jelly/Marmalade",@"Ketchup",@"Mayonnaise",@"Mustard - Regular",@"Mustard - Dijon",@"Peanut Butter",@"Salad Dressing",@"Spaghetti Sauce",@"Syrup",@"Vinegar - Red Wine",@"Vinegar - White",@"Vinegar - Balsamic",@"Vinegar - Malt",@"Vinegar - Other",nil];
    
    for (int i = 0; i < [condiments count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[condiments objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Condiments";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:365];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *dairy = [NSArray arrayWithObjects:@"Butter - Stick",@"Butter - Spread",@"Butter - Spray",@"Cheese - American",@"Cheese - Blue",@"Cheese - Colby Jack",@"Cheese - Cheddar",@"Cheese - Feta",@"Cheese - Gorgonzola",@"Cheese - Mozzarella",@"Cheese - Provolone",@"Cheese - Swiss",@"Cheese - Other",@"Cottage Cheese",@"Creamer",@"Eggs - Medium",@"Eggs - Large",@"Egg Beaters",@"Milk - Whole",@"Milk - One Percent",@"Milk - Two Percent",@"Milk - Skim",@"Milk - Chocolate",@"Milk - Other",@"Ricotta",@"Sour Cream",@"Whip Cream",@"Yogurt - Plain",@"Yogurt - Fruit",@"Yogurt - Other",nil];
    
    for (int i = 0; i < [dairy count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[dairy objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Dairy";
        food.comment = @"Edit to change comment.";
        
        switch (i) {
                
            case 0:
            case 1:
            case 2:
                food.expiration_offset = [NSNumber numberWithInt:30];
                break;
                
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
                food.expiration_offset = [NSNumber numberWithInt:45];
                break;
                
            case 13:
            case 14:
            case 25:
                food.expiration_offset = [NSNumber numberWithInt:10];
                break;
                
            case 15:
            case 16:
                food.expiration_offset = [NSNumber numberWithInt:28];
                break;
                
            case 17:
                food.expiration_offset = [NSNumber numberWithInt:90];
                break;
                
            case 18:
            case 19:
            case 20:
            case 21:
            case 22:
            case 23:
            case 24:
                food.expiration_offset = [NSNumber numberWithInt:7];
                break;
                
            case 26:
                food.expiration_offset = [NSNumber numberWithInt:14];
                break;
                
            case 27:
            case 28:
            case 29:
                food.expiration_offset = [NSNumber numberWithInt:21];
                break;
                
            default:
                break;
        }
        
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *deli = [NSArray arrayWithObjects:@"American Cheese",@"Baked Beans",@"Cheddar Cheese",@"Chicken",@"Colby Cheese",@"Colby Jack Cheese",@"Cole Slaw",@"Corned Beef",@"Feta Cheese",@"Ham",@"Hot Pepper",@"Mozzarella Cheese",@"Muenster Cheese",@"Other Cheese",@"Pastrami",@"Pepperoni",@"Potato Salad",@"Provolone Cheese",@"Roast Beef",@"Salad",@"Salami",@"Swiss Cheese",@"Tabouli",@"Turkey",nil];
    
    for (int i = 0; i < [deli count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[deli objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Deli";
        food.comment = @"Edit to change comment.";
        
        switch (i) {
                
            case 0:
            case 2:
            case 4:
            case 5:
            case 8:
            case 11:
            case 12:
            case 13:
            case 17:
            case 21:
                food.expiration_offset = [NSNumber numberWithInt:7];
                break;
                
            case 1:
            case 3:
            case 6:
            case 7:
            case 9:
            case 10:
            case 14:
            case 15:
            case 16:
            case 18:
            case 19:
            case 20:
            case 22:
            case 23:
                food.expiration_offset = [NSNumber numberWithInt:3];
                break;
                
            default:
                break;
        }
        
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *ethnicfood = [NSArray arrayWithObjects:@"Bamboo Shoots",@"Burrito Shells",@"Cardamom",@"Chile Paste",@"Coconut Milk",@"Curry Powder",@"Dates",@"Fennel Seeds",@"Fish Sauce",@"Five Spice Powder",@"Ginger Root",@"Grape Leaves",@"Oyster Sauce",@"Palm Sugar",@"Peanut Oil",@"Refried Beans",@"Rice Flour",@"Roasted Rice Powder",@"Salsa - Hot",@"Salsa - Mild",@"Samba Powder",@"Sesame Oil",@"Shrimp Paste",@"Soy Sauce",@"Sweet & Sour Sauce",@"Taco Shells - Hard",@"Taco Shells - Soft",@"Tortillas",@"Turmeric",nil];
    
    for (int i = 0; i < [ethnicfood count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[ethnicfood objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Ethnic Foods";
        food.comment = @"Edit to change comment.";
        
        switch (i) {
                
            case 0:
            case 2:
            case 6:
            case 27:
            case 28:
                food.expiration_offset = [NSNumber numberWithInt: 28];
                break;
                
            case 1:
            case 8:
            case 25:
            case 26:
                food.expiration_offset = [NSNumber numberWithInt: 180];
                break;
                
            case 3:
            case 4:
            case 5:
            case 7:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
            case 21:
            case 22:
            case 23:
            case 24:
                food.expiration_offset = [NSNumber numberWithInt: 365];
                break;
                
            default:
                break;
        }
        
        food.expiration_offset = [NSNumber numberWithInt:5];
        
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *frozenfood = [NSArray arrayWithObjects:@"Breads - Breadsticks",@"Breads - Garlic Bread",@"Breads - Rolls",@"Breads - Other",@"Frozen Fruit - Blackberries",@"Frozen Fruit - Blueberries",@"Frozen Fruit - Cherries",@"Frozen Fruit - Mixed Fruit",@"Frizen Fruit",@"Peaches",@"Frozen Fruit - Pineapple",@"Frozen Fruit - Strawberries",@"Frozen Fruit - Other",@"French Fries",@"Hash Browns",@"Ice Cream - Vanilla",@"Ice Cream - Chocolate",@"Ice Cream - Other",@"Juice Concentrates - Grape",@"Juice Concentrates",@"Lemonade",@"Juice Concentrates - Orange",@"Juice Concentrates - Pineapple",@"Juice Concentrates - Other",@"Meals - Breakfast",@"Meals - Crock Pot",@"Meals - Lunch/Dinner",@"Meals - Skillet",@"Frozen Meats - Beef",@"Frozen Meats - Chicken",@"Frozen Meats - Pork",@"Frozen Meats - Turkey",@"Frozen Meats - Other",@"Frozn Seafood - Cod",@"Frozen Seafood - Crab Legs",@"Frozen Seafood - Grouper",@"Frozen Seafood - Halibut",@"Frozen Seafood - Lobster",@"Frozen Seafood - Salmon",@"Frozen Seafood - Scallops",@"Frozen Seafood - Sea Bass",@"Frozen Seafood - Shrimp",@"Frozen Seafood - Tuna",@"Frozen Seafood - Other",@"Frozen Veggies - Artichokes",@"Frozen Veggies - Asparagus",@"Frozen Veggies - Beans",@"Frozen Veggies - Broccoli",@"Frozen Veggies - Brussels Sprouts",@"Frozen Veggies - Carrots",@"Frozen Veggies - Cauliflower",@"Frozen Veggies - Corn",@"Frozen Veggies - Mixed",@"Frozen Veggies - Onions",@"Frozen Veggies - Peas",@"Frozen Veggies - Peppers",@"Frozen Veggies - Potatoes",@"Frozen Veggies - Spinach",@"Frozen Veggies - Squach",@"Frozen Veggies - Sweet Peas",@"Frozen Veggies - Other",@"Frozen Yogurt",@"Pancakes",@"Pizza",@"Popsicles",@"Sausage",@"Tater-Tots",@"Waffles",nil];
    
    for (int i = 0; i < [frozenfood count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[frozenfood objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Frozen Food";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:180];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *healthandbeauty = [NSArray arrayWithObjects:@"ACE Bandages",@"Allergy Medication",@"Antibiotic Cream",@"Anti-Diarrhea",@"Antifungals",@"Band-Aids",@"Brushes",@"Cold/Cough Medicine",@"Combs",@"Conditioner",@"Contact Cleaner",@"Contact Solution",@"Cotton Balls",@"Dental Floss",@"Deodorant",@"Eye Makeup",@"Foot Soles",@"Foundation",@"Gauze Pads",@"Hair Dye",@"Hair Gel",@"Hair Removal Products",@"Hair Spray",@"Hemorrhoid Cream",@"Hydrogen Peroxide",@"Lipstick",@"Lotion",@"Medical Tape",@"Motrin",@"Mouthwash",@"Nail Polish",@"Neosporin",@"Other Cosmetics",@"Other Feminine Products",@"Other Injury Supplies",@"Other Medication",@"Panty Shields",@"Pregnancy Tests",@"Razors",@"Rubbing Alcohol",@"Saline Solution",@"Shampoo",@"Soap (Body) - Bar",@"Soap (Body) - Liquid",@"Sunscreen",@"Tampads",@"Tampons",@"Therapeutic Socks",@"Toothbrushes",@"Toothpaste",@"Tooth Whitening",@"Travel - Shampoo",@"Travel - Conditioner",@"Travel - Deodorant",@"Travel - Mouthwash",@"Travel - Tooth Brush Case",@"Travel - Toothbrush",@"Travel - Toothpaste",@"Travel - Other",@"Tylenol",@"Vitamins",nil];
    
    for (int i = 0; i < [healthandbeauty count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[healthandbeauty objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Health and Beauty";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:180];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *householditems = [NSArray arrayWithObjects:@"Air Fresheners - Solid",@"Air Fresheners - Liquid",@"Air Fresheners - Other",@"Bleach",@"Brillo Pads",@"Broom",@"Carpet Cleaner",@"Dishwashing Soap - Gel",@"Dishwashing Soap - Tablets",@"Dishwashing Soap -Other",@"Disinfectant Spray",@"Disinfectant Wipes",@"Dustpan",@"Fabric Softner",@"Furniture Polish",@"Gloves - Latex",@"Gloves - Vinyl",@"Gloves - Other",@"Garbage Bags",@"Hand Soap - Gel",@"Hand Soap - Bar",@"Hand Soap - Other",@"Laundry Detergent",@"Light Bulbs",@"Mop",@"Napkins",@"Oven Cleaner",@"Paper Towels",@"Paper/Plastic Cups",@"Paper/Plastic Plates",@"Spot Remover",@"Storage Bags",@"Storage Containers",@"Tin Foil",@"Tissues",@"Toilet Paper",@"Wax Paper",@"Window Cleaner",nil];
    
    for (int i = 0; i < [householditems count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[householditems objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Household Items";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:360];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *meatandseafood = [NSArray arrayWithObjects:@"Beef - Ground",@"Beef - Steaks",@"Beef - Roast",@"Beaf - Other",@"Bologna",@"Catfish",@"Chicken - Whole",@"Chicken - Breast",@"Chicken - Legs/Thighs",@"Chicken - Other",@"Cod",@"Crab Legs",@"Frog Legs",@"Hot Dogs - All Beef",@"Hot Dogs - Other",@"Ham",@"Lamb - Chops",@"Lamb - Cutlets",@"Lamb - Ground",@"Lamb - Leg",@"Lamb - Other",@"Lobster",@"Mussels",@"Oysters",@"Pork - Chops",@"Pork - Country Ribs",@"Pork - Spare Ribs",@"Pork - Ground",@"Pork - Other",@"Salmon",@"Scallops",@"Snapper",@"Steak - Chuck",@"Steak - Cube",@"Steak - Filet Mignon",@"Steak - Flank",@"Steak - Porterhouse",@"Steak - Rib Eye",@"Steak - Rump",@"Steak - Sirloin",@"Steak - T-Bone",@"Steak - Other",@"Tilapia",@"Trout",@"Tuna",@"Turkey - Legs/Thighs",@"Turkey - Ground",@"Turkey - Whole",@"Turkey - Other",@"Veal",nil];
    
    for (int i = 0; i < [meatandseafood count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[meatandseafood objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Meat and Seafood";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:3];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *other = [NSArray arrayWithObjects:@"Bird Food",@"Cat Food",@"Dog Food - Wet",@"Dog Food - Dry",@"Dog Food - Treats",@"Dog Food - Other",@"Fish Food - Flakes",@"Fish Food - Pellets",@"Reptile Food",@"Small Pet Food",nil];
    
    for (int i = 0; i < [other count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[other objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Other";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:180];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }  
    
    NSArray *pastaandrice = [NSArray arrayWithObjects:@"Noodles - Angel Hair",@"Noodles - Bow Tie",@"Noodles - Couscous",@"Noodles - Elbow Macaroni",@"Noodles - Fettuccine",@"Noodles - Lasagna",@"Noodles - Orzo",@"Noodles - Shell",@"Noodles - Spaghetti",@"Noodles - Twist",@"Noodles - Other",@"Pasta Sauce - Pesto",@"Pasta Sauce - Red",@"Pasta Sauce - White",@"Pasta Sauce - Other",@"Rice - White",@"Rice - Brown",@"Rice - Other",nil];
    
    for (int i = 0; i < [pastaandrice count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[pastaandrice objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Pasta and Rice";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:365];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }  
    
    NSArray *produce = [NSArray arrayWithObjects:@"Apples",@"Apricots",@"Artichokes",@"Asparagus",@"Avocados",@"Bananas",@"Bean Sprouts",@"Blackberries",@"Blueberries",@"Broccoli",@"Brussels Sprouts",@"Carrots - Mini",@"Carrots - Shredded",@"Carrots - Whole",@"Cabbage",@"Cantaloupes",@"Cauliflower",@"Celery",@"Cherries",@"Cilantro",@"Collards",@"Corn",@"Cucumbers",@"Clementines",@"Dates",@"Eggplants",@"Elderberries",@"Fennels",@"Garlic",@"Goose Berries",@"Grapes",@"Grapefruits",@"Green Beans",@"Guavas",@"Honeydews",@"Kiwis",@"Kumquats",@"Lemons",@"Lettuce - Iceberg",@"Lettuce - Romaine",@"Lettuce - Red Leaf",@"Lettuce - Bagged",@"Limes",@"Mangos",@"Mushrooms - Sliced",@"Mushrooms - Whole",@"Nectarines",@"Okras",@"Onions - Sweet",@"Onions - White",@"Onions - Yellow",@"Onions - Red",@"Onions - Scallions",@"Oranges",@"Peaches",@"Pears",@"Peppers - Green",@"Peppers - Red",@"Peppers - Orange",@"Peppers - Chili",@"Peppers - Jalapeno",@"Pineapples",@"Plums",@"Pomegranates",@"Potatoes - White",@"Potatoes - Sweet",@"Pumpkins",@"Radishes",@"Raspberries",@"Rhubarbs",@"Snow Peas",@"Spinach",@"Squash",@"Strawberries",@"Tomatoes",@"Watermelons",@"Yellow Beans",@"Zucchini",nil];
    
    
    //Produce Init
    for (int i = 0; i < [produce count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[produce objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Produce";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:5];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    NSArray *snacks = [NSArray arrayWithObjects:@"Beef Jerky",@"Candy Bars",@"Cheese Puffs",@"Chewy Candy",@"Cookies - Chocolate Chip",@"Cookies - Figs",@"Cookies - Oatmeal",@"Cookies - Oreos",@"Cookies - Peanut Butter",@"Cookies - Shortbread",@"Cookies - Other",@"Corn Chips",@"Crackers",@"Dips",@"Dried Fruit",@"Fruit Snacks",@"Gum",@"Hard Candy",@"Licorice",@"Lollipops/Suckers",@"Other Candy",@"Other Snacks",@"Popcorn - Regular",@"Popcorn - Caramel Corn",@"Popcorn - Other",@"Potato Chips",@"Pretzels",@"Raisins",@"Rice Cakes",@"Soy Chips",@"Veggie Chips",nil];
    
    for (int i = 0; i < [snacks count]; i++) {
        food = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        food.name = ((NSString*)[snacks objectAtIndex:i]);
        food.state =  [NSNumber numberWithInt:0];
        food.prev_state =  [NSNumber numberWithInt:0];
        food.category = @"Snacks";
        food.comment = @"Edit to change comment.";
        food.expiration_offset = [NSNumber numberWithInt:180];
        food.cart_sel = [NSNumber numberWithInt: 0];
        food.shop_sel = [NSNumber numberWithInt: 0];
    }
    
    return;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //Trying to set up core data
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error: &error];
    
    if([fetchedObjects count] == 0)
    {
        [self initCoreData];
    }
    return YES;
    
}							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"foodDB" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"foodDB.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
