//
//  ETLSysView.h
//  LSystem
//
//  Created by Michael Abed on 1/2/13.
//  Copyright (c) 2013 Michael Abed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETRule.h"

enum {
    ETNOTHING,
    ETDRAW,
    ETMOVE,
    ETROTATE,
    ETPUSH,
    ETPOP
}  ETACTION;

@interface ETDrawContext : NSView

@property NSPoint currentPoint;
@property NSNumber *angle;
@property NSGraphicsContext *context;

+ (ETDrawContext*) contextWithPoint: (NSPoint) point andAngle: (NSNumber*) angle andContext: (NSGraphicsContext*) ctx;

@end

@interface ETLSysView : NSView

@property NSString *system;
@property NSString *drawnSystem;
@property NSBezierPath *path;
@property NSDictionary *rules;
@property NSImage *image;

- (NSImage*) drawImageForSystem;
- (NSBezierPath*) computePathForSystem;
- (NSPoint) nextPointFromDistance: (NSNumber*) distance andAngle: (NSNumber*) angle;
@end
