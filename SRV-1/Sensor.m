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
    double result;
    double deltaTime=[NSDate timeIntervalSinceReferenceDate]-time;
    if (deltaTime<2.0) result=25.0/16.0*deltaTime;
    if (deltaTime>=2.0 && deltaTime<8.0) result=25.0/8.0;
    if (deltaTime>=8.0) result=125.0/8.0-deltaTime*25.0/16.0;
    if (deltaTime>10) {
        [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"complete" object:nil]];
        [NSThread exit];
    }
    float pureResult=result;
    
    //тут внести шум

    double noise = ((double)arc4random() / 0x100000000)*0.6;
    
    if (rand()%2) noise=-noise;
    result+=noise;
    
    [self.sharedPureArray performSelector:@selector(addObject:) onThread:[NSThread mainThread] withObject:[NSNumber numberWithFloat:pureResult] waitUntilDone:NO];
    return result;
}


@end
