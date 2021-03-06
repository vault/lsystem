//
//  ETSolver.m
//  LSystem
//
//  Created by Michael Abed on 1/2/13.
//  Copyright (c) 2013 Michael Abed. All rights reserved.
//

#import "ETSolver.h"
#import "ETRule.h"

@implementation ETSolver

@synthesize system;
@synthesize rules;
@synthesize generations;

- (ETSolver*) initWithSystem: (NSString*) sys andRules:(NSDictionary*) rulesDict
{
    self = [super init];
    system = sys;
    rules = rulesDict;
    generations = [NSMutableArray arrayWithCapacity:10];
    [generations addObject:sys];
    return self;
}

- (void) solveForGenerations: (NSUInteger) gens
{
    NSUInteger solvedGens = [generations count];
    if (solvedGens < gens) {
        for (int i = 0; i < gens - solvedGens; i++) {
            [self expandLastGeneration];
        }
    }
}

- (void) expandLastGeneration
{
    NSString *lastObject = [generations lastObject];
    long cap = [lastObject length] * [lastObject length];
    NSMutableString *nextString = [NSMutableString stringWithCapacity:cap];
    NSString *character;
    unichar character_;
    ETRule *rule;
    for (int i = 0; i < [lastObject length]; i++) {
        character_ = [lastObject characterAtIndex:i];
        character = [NSString stringWithCharacters:&character_ length:1];
        rule = [rules objectForKey:character];
        if (rule != nil && rule.replacement != nil && [rule.replacement length] > 0)
            [nextString appendString: rule.replacement];
        else if (rule != nil && rule.character != nil)
            [nextString appendString: rule.character];
    }
    [generations addObject:nextString];
}   

- (NSString*) getGeneration: (int) gen
{
    if (gen >= [generations count]) {
        return [self lastGeneration];
    } else {
        return [generations objectAtIndex:gen];
    }
}

- (NSString*) lastGeneration
{
    return [generations lastObject];
}

@end
