//
//  LoadAppViewController.h
//  Shop
//
//  Created by Matrix Soft on 28.11.12.
//  Copyright (c) 2012 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessDatabaseContent.h"

@interface LoadAppViewController : UIViewController<NSURLConnectionDataDelegate>
{
    NSMutableData *responseData;
    NSURLConnection *connection;
}

@property (nonatomic, strong) AccessDatabaseContent *dbContent;


- (void)getDBData;

@end
