//
//  DetailProductViewController.m
//  Shop
//
//  Created by Matrix Soft on 29.11.12.
//  Copyright (c) 2012 Matrix Soft. All rights reserved.
//

#import "DetailProductViewController.h"

@interface DetailProductViewController ()

@end

@implementation DetailProductViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toInfoProduct:(id)sender {
    
    [self performSegueWithIdentifier:@"toInfo" sender:self];
    
}

- (IBAction)toShare:(id)sender {
    
    [self performSegueWithIdentifier:@"toShare" sender:self];
    
}
@end
