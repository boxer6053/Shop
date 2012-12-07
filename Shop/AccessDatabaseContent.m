//
//  AccessDatabaseContent.m
//  Shop
//
//  Created by Matrix Soft on 30.11.12.
//  Copyright (c) 2012 Matrix Soft. All rights reserved.
//

#import "AccessDatabaseContent.h"
#import "AppDelegate.h"

@interface AccessDatabaseContent ()

@property BOOL isExceptionThrow;

@end

@implementation AccessDatabaseContent

@synthesize managedObjectContext = _managedObjectContext;
@synthesize isExceptionThrow = _isExceptionThrow;

-(NSManagedObjectContext *)managedObjectContext
{
    if(!_managedObjectContext)
    {
        _managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    return _managedObjectContext;
}

- (void)setRecordToEntity:(NSString *)entityName withDictionaryAttribute:(NSDictionary *)attributeDictionary
{
    NSManagedObjectContext *context = self.managedObjectContext;
    
    //Масив адішок таблиці
    NSArray *ids = [self fetchAllIdsFromEntity:entityName]; 
    
    if (![self isExceptionThrow]) {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
        
        if ([ids count] != 0) {
            for (int i = 0; i < ids.count; i++) {
                
                //перевірка на наявність однакових айдішок в таблиці
                if ([[ids objectAtIndex:i] intValue] == [[attributeDictionary valueForKey:@"id"] intValue]) {
                    //якщо знайшли, то видаляєм
                    [self deleteRecordFromEntity:entityName withId:[ids objectAtIndex:i]];
                }
            }
        }
        
        NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:[entityDescription name] inManagedObjectContext:context];
        
        //масив імен полів
        NSArray *entityFields = [attributeDictionary allKeys];
        
        for (NSString *field in entityFields) {
            @try {
                //запис до таблиці
                [managedObject setValue:[attributeDictionary valueForKey:field] forKey:field];
            }
            @catch (NSException *exception) {
                NSLog(@"%@: %@", [exception name], field);
            }
        }
        
        NSError *error;
        //збереження контексту
        if (![context save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSArray *)fetchContentFromEntity:(NSString *)entityName
               withSortedDescriptor:(NSString *)sortedDescriptor
{
    
    NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    
    [request setEntity:entityDesc];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortedDescriptor ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    [request setResultType:NSDictionaryResultType];
    
    NSError *error;
    NSArray *resultOfRequest = [context executeFetchRequest:request error:&error];
    
    return resultOfRequest;
}

- (NSArray *)fetchAllIdsFromEntity:(NSString *)entityName
{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    
    NSError *error;
    NSArray *items;
    
    [self setIsExceptionThrow:NO];
    
    @try {
        items= [context executeFetchRequest:request error:&error];
    }
    @catch (NSException *exception) {
        [self setIsExceptionThrow:YES];
    }
    
    NSMutableArray *arrayOfIds = [[NSMutableArray alloc] init];
    if (items.count != 0)
    {
        for (int i = 0; i<items.count; i++)
        {
            [arrayOfIds addObject:[[items objectAtIndex:i] valueForKey:@"id"]];
        }
        return arrayOfIds.copy;
    }
    else
    {
        return nil;
    }
}

- (void)deleteRecordFromEntity:(NSString *)entityName
                        withId:(NSString *)recordId
{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:request error:&error];
    
    for (int i = 0; i < items.count; i++) {
        if ([[[items objectAtIndex:i] valueForKey:@"id"] intValue] == recordId.intValue)
        {
            [context deleteObject:[items objectAtIndex:i]];
            break;
        }
    }
    
    //збереження контексту
    if (![context save:&error]) {
        NSLog(@"Error deleting %@ - error:%@", entityName, error);
    }
}

@end
