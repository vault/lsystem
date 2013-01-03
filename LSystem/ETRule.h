//
//  ETRule.h
//  LSystem
//
//  Created by Michael Abed on 1/2/13.
//  Copyright (c) 2013 Michael Abed. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ETRule : NSManagedObject

@property (nonatomic) NSString *character, *replacement;
@property (nonatomic) NSNumber *action, *argument;

@end
