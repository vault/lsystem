//
//  ETAppDelegate.h
//  LSystem
//
//  Created by Michael Abed on 1/2/13.
//  Copyright (c) 2013 Michael Abed. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ETSolver.h"

@interface ETAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet id lsysview;
@property (assign) IBOutlet id initialCondition;
@property (assign) IBOutlet id iterationCount;
@property (assign) IBOutlet id lsysdisplay;
@property (assign) IBOutlet id ruleArrayController;


@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) ETSolver *solver;


- (IBAction)generate:(id)sender;
- (IBAction)saveAction:(id)sender;

- (NSDictionary*) dictionaryForRules: (NSArray*) rules;

@end
