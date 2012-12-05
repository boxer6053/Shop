//
//  AccessDatabaseContent.m
//  Shop
//
//  Created by Matrix Soft on 30.11.12.
//  Copyright (c) 2012 Matrix Soft. All rights reserved.
//

#import "AccessDatabaseContent.h"
#import "AppDelegate.h"

@implementation AccessDatabaseContent

- (void)setDataToEntity:(NSString *)entityName withDictionaryAttribute:(NSDictionary *)attributeDictionary
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Cities" inManagedObjectContext:context];
    
    NSManagedObjectContext *newContext = [NSEntityDescription insertNewObjectForEntityForName:@"Cities" inManagedObjectContext:context];
    
//    [entityDescription setValue:@"1" forKey:@"version"];
    [newContext setValue:@"1" forKey:@"version"];

}

@end
