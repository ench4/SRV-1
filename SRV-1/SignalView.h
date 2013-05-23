//
//  ViewController.h
//  graph_sv
//
//  Created by Samez on 06.10.12.
//  Copyright (c) 2012 Samez. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SignalView : NSView
{
    float bordersShift;
    float leftPadding;
    float zero;
    float min;
    float max;
    float shift_y;
    float shift_x;
    NSInteger ind;
    float diameter;
    NSArrayController* AC;
    NSString* key;
    bool mutable;
};

- (void) drawRect:(NSRect)rect;
- (void) drawPoint:(NSPoint)point :(BOOL)Bold;
- (void) recalcMinAndMax:(NSRect)rect;
- (void) recalcBorder:(NSRect) rect;
@property NSArray* vector;
@property bool mutable;


@end
