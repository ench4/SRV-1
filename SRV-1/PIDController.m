//
//  PID.m
//  SRV
//
//  Created by Виктор on 25.04.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import "PIDController.h"

@interface PIDController ()

@property float kp,ki,kd;
@property float time;
-(float) effectForError:(float) error;

@end

@implementation PIDController

@synthesize neededValue;
@synthesize engine;
@synthesize time;
@synthesize kp,ki,kd;

-(id) init
{
    self=[super init];
    if (self)
    {
        self.time=1;
        prevError=0;
        integralValue=0;
    }
    return self;
}

-(id) initWithk1:(float)k1 k2:(float)k2 andK3:(float)k3
{
    self=[self init];
    if (self)
    {
        self.kp=k1;
        self.ki=k2;
        self.kd=k3;
    }
    return self;
}

-(float) effectForError:(float)error
{
    float result=0;
    
    result+=self.kp*error;
    
    integralValue+=error*self.ki;
    result+=integralValue*self.time;
    
    result+=(error-prevError)*self.kd/self.time;
    
    prevError=error;
    return result;
}

-(void) hasNewValue:(float)val
{
    float effect=[self effectForError:self.neededValue-val];
    NSLog(@"error: %f effect: %f",self.neededValue-val,effect/10);
    [self.engine setU:effect/10];
}

@end
