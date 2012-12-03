//
//  AccessDatabaseContent.h
//  Shop
//
//  Created by Matrix Soft on 30.11.12.
//  Copyright (c) 2012 Matrix Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface AccessDatabaseContent : NSObject<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResult;

@end
