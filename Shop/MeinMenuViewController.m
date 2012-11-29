//
//  MeinMenuViewController.m
//  Shop
//
//  Created by Matrix Soft on 28.11.12.
//  Copyright (c) 2012 Matrix Soft. All rights reserved.
//

#import "MeinMenuViewController.h"

@interface MeinMenuViewController ()

@end

@implementation MeinMenuViewController

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

- (IBAction)toProductClick:(id)sender {
    
    [self performSegueWithIdentifier:@"toProducts" sender:self];
    
}
@end
