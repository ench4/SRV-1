//
//  Sensor.m
//  SRV
//
//  Created by Виктор on 25.04.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import "EngineSensor.h"



@implementation EngineSensor
@synthesize allValues;
@synthesize engineDelegate;

-(id) init
{
    self=[super init];
    if (self)
    {
        self.allValues=[[NSMutableArray alloc]init];
    }
    return self;
}

-(float) speedValue
{
    self.speedValue=[self.engineDelegate speedValue];
    [self.allValues addObject:[NSNumber numberWithFloat:speedValue_] ];
    self.allValues=self.allValues;
    [self.controllerDelegate hasNewValue:speedValue_];
    return speedValue_;
}

-(void) setSpeedValue:(float)speedValue
{
    speedValue_=speedValue;
    //внести шум
}

@end
