//
//  BagViewController.h
//  Shop
//
//  Created by Matrix Soft on 13.12.12.
//  Copyright (c) 2012 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BagViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
