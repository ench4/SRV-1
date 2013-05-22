//
//  Sensor.m
//  SRV-1
//
//  Created by Виктор on 02.05.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import "Sensor.h"

@implementation Sensor

-(id) init
{
    self=[super init];
    if (self)
    {
        time=[NSDate timeIntervalSinceReferenceDate];
    }
    return self;
}

-(float) speedValue
{
    float result;
    double deltaTime=[NSDate timeIntervalSinceReferenceDate]-time;
    if (deltaTime<2.0) result=5.0/64.0*deltaTime;
    if (deltaTime>=2.0 && deltaTime<8.0) result=50.0/64.0;
    if (deltaTime>=8.0) result=100.0/64.0-deltaTime*5.0/64.0;
    
    //тут внести шум
    NSLog(@"%f",result);
    
    return result;
}

@end
