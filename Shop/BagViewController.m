//
//  BagViewController.m
//  Shop
//
//  Created by Matrix Soft on 13.12.12.
//  Copyright (c) 2012 Matrix Soft. All rights reserved.
//

#import "BagViewController.h"
#import "BagCell.h"
#import "QuartzCore/QuartzCore.h"

@interface BagViewController ()

@property (nonatomic, strong) NSArray *arrayOfNames;
@property (nonatomic, strong) NSArray *arrayOfColors;
@property (nonatomic, strong) NSArray *arrayOfSizes;

@end

@implementation BagViewController

@synthesize tableView = _tableView;
@synthesize arrayOfNames = arrayOfNames;
@synthesize arrayOfColors = _arrayOfColors;
@synthesize arrayOfSizes = _arrayOfSizes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    self.arrayOfNames = [[NSArray alloc] initWithObjects:@"Product name 1", @"Product name 2", @"Product name 3", @"Product name 4", nil];
    self.arrayOfSizes = [[NSArray alloc] initWithObjects:@"M", @"L", @"S", @"XL", nil];
    self.arrayOfColors = [[NSArray alloc] initWithObjects:@"Color 1", @"Color 2", @"Color 3", @"Color 4", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayOfNames count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"BagCell";
    BagCell *cell = (BagCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];
    if(!cell)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BagCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[BagCell class]])
            {
                cell = (BagCell *)currentObject;
                break;
            }
        }
    }
    
    
    cell.productNameLabel.text = [self.arrayOfNames objectAtIndex:indexPath.row];
    cell.productColorLabel.text = [self.arrayOfColors objectAtIndex:indexPath.row];
    cell.productSizeLabel.text = [self.arrayOfSizes objectAtIndex:indexPath.row];
        
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = cell.bounds;
//    gradient.cornerRadius = .0f;
//    [gradient setBorderWidth:0.5f];
//    [gradient setBorderColor:[[UIColor darkGrayColor] CGColor]];
//    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor darkGrayColor] CGColor],(id)[[UIColor blackColor] CGColor], nil];
//    [cell.layer insertSublayer:gradient atIndex:0];
    
    
    
    return cell;
}

@end
