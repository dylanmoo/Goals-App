//
//  StepAppDelegate.h
//  Step
//
//  Created by Dylan Moore on 11/10/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
