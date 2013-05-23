//
//  Engine.m
//  SRV
//
//  Created by Виктор on 25.04.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import "Engine.h"
#define DELTA_T 1
@interface Engine ()

@property float currentAngularV;

@end

@implementation Engine

-(id) init
{
    self=[super init];
    if (self)
    {
        self.currentAngularV=0;
    }
    return self;
}

-(float) angularSpeed
{
    NSLog(@"current angular speed %f",self.B*U_);
    self.currentAngularV+=(self.A*self.currentAngularV+self.B*U_)*DELTA_T;
    
    return self.currentAngularV;
}

-(void) setU:(float)U
{
    U_=U;
}

-(float) speedValue
{
    return [self angularSpeed];
}

@end
