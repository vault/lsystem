//
//  ETLSysView.m
//  LSystem
//
//  Created by Michael Abed on 1/2/13.
//  Copyright (c) 2013 Michael Abed. All rights reserved.
//

#import "ETLSysView.h"

@implementation ETDrawContext

@synthesize currentPoint;
@synthesize angle;
@synthesize context;

+ (ETDrawContext*) contextWithPoint:(NSPoint)point andAngle:(NSNumber *)angle andContext:(NSGraphicsContext *)ctx
{
    ETDrawContext *instance = [[ETDrawContext alloc] init];
    [instance setCurrentPoint:point];
    [instance setAngle:angle];
    [instance setContext:ctx];
    
    return instance;
}

@end

@implementation ETLSysView

@synthesize  system;
@synthesize rules;
@synthesize drawnSystem;
@synthesize path;
@synthesize image;

- (id) initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame: frameRect];
    return self;
}

- (NSImage*) drawImageForSystem
{
        
    if ([self computePathForSystem] != nil) {

        NSPoint neworig = [path bounds].origin;
        
        NSAffineTransform *xform = [NSAffineTransform transform];
        [xform translateXBy:-neworig.x yBy:-neworig.y];        
        [path transformUsingAffineTransform:xform];

        image = [[NSImage alloc] initWithSize:path.bounds.size];
        [image lockFocus];
        
        [[NSColor whiteColor] set];
        NSRectFill(path.bounds);
        
        [[NSColor blueColor] setStroke];
        [path setLineWidth:1];
        [path stroke];
        
        [image unlockFocus];
        
        return image;
        
    } else {
        return nil;
    }
}


- (void) drawRect:(NSRect)dirtyRect
{
    if (image == nil) {
        [[NSColor whiteColor] set];
        NSRectFill(dirtyRect);
    } else {
        [image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
    }
}

- (NSBezierPath *) computePathForSystem
{
    if ([self system] == nil)
        return nil;
    if (![drawnSystem isEqualToString:system]) {
        path = [NSBezierPath bezierPath];
    
        NSMutableArray *contextStack = [NSMutableArray arrayWithCapacity:20];
        
        NSPoint currentPoint = NSZeroPoint;
        NSNumber *angle = [NSNumber numberWithDouble:0];
        
        [path moveToPoint:currentPoint];
        
        for (int i = 0; i < [system length]; i++) {
            unichar _character = [system characterAtIndex:i];
            NSString *character = [NSString stringWithCharacters:&_character length:1];
            ETRule *rule = [rules objectForKey:character];
            if (rule != nil) {
                int action = [rule.action intValue];
                
                ETDrawContext *ctx;
                
                NSPoint nextPoint = [self nextPointFromDistance:rule.argument andAngle:angle];
                
                switch (action) {
                    case ETNOTHING:
                        break;
                    case ETDRAW:
                        [path relativeLineToPoint:nextPoint];
                        currentPoint.x += nextPoint.x;
                        currentPoint.y += nextPoint.y;
                        break;
                    case ETMOVE:
                        [path relativeMoveToPoint:nextPoint];
                        currentPoint.x += nextPoint.x;
                        currentPoint.y += nextPoint.y;
                        break;
                    case ETROTATE:
                        angle = [NSNumber numberWithDouble:[angle doubleValue] + [rule.argument doubleValue]];
                        break;
                    case ETPUSH:
                        ctx = [ETDrawContext contextWithPoint:currentPoint andAngle:angle andContext:[NSGraphicsContext currentContext]];
                        [contextStack addObject:ctx];
                        break;
                    case ETPOP:
                        ctx = [contextStack lastObject];
                        [contextStack removeLastObject];
                        
                        currentPoint = [ctx currentPoint];
                        [path moveToPoint:currentPoint];
                        angle = [ctx angle];
                        
                        break;
                    default:
                        NSLog(@"How did you get here? Action %d", action);
                        break;
                }
            }
        }
    }
    return path;
}

- (NSPoint) nextPointFromDistance: (NSNumber*) distance andAngle: (NSNumber*) angle
{
    NSPoint next = NSZeroPoint;
    const double PI = 3.141592654;

    next.x = [distance doubleValue] * cos(2 * PI * [angle doubleValue] / 360.0);
    next.y = [distance doubleValue] * sin(2 * PI * [angle doubleValue] / 360.0);
    
    return next;
}

- (BOOL) isOpaque
{
    return YES;
}

@end
