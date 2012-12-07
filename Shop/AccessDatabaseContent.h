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
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

- (void)setRecordToEntity:(NSString *)entityName
withDictionaryAttribute:(NSDictionary *)attributeDictionary;
- (NSArray *)fetchContentFromEntity:(NSString *)entityName
               withSortedDescriptor:(NSString *)sortedDescriptor;
- (NSArray *)fetchAllIdsFromEntity:(NSString *)entityName;
- (void)deleteRecordFromEntity:(NSString *)entityName
                        withId:(NSString *)recordId;

@end
