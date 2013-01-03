//
//  ETSolver.h
//  LSystem
//
//  Created by Michael Abed on 1/2/13.
//  Copyright (c) 2013 Michael Abed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETSolver : NSObject

@property NSString *system;
@property NSMutableArray *generations;
@property NSDictionary *rules;


- (ETSolver*) initWithSystem: (NSString*) sys andRules:(NSDictionary*) rulesDict;
- (void) solveForGenerations: (NSUInteger) gens;
- (void) expandLastGeneration;
- (NSString*) getGeneration: (int) gen;
- (NSString*) lastGeneration;

@end
