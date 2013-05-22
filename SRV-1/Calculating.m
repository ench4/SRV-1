//
//  Calculating.m
//  SRV-1
//
//  Created by Виктор on 02.05.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import "Calculating.h"

@implementation Calculating
@synthesize h;

-(id) init
{
    self=[super init];
    if (self)
    {
        s=1.0;
    }
    return self;
}

-(void) setDelegate:(id<pull>)delegate
{
    _delegate=delegate;
    [delegate setReciever:self withSelector:@selector(updateH)];
}

-(id<pull>) delegate
{
    return _delegate;
}

-(float) calc
{
    float x=[self.delegate pullValueFromBuffer];
    return x*s;
}

-(void) updateH
{
    self.h+=[self calc];
}

@end
