//
//  AppDelegate.m
//  SRV-1
//
//  Created by Виктор on 02.05.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

-(id) init
{
    self=[super init];
    if (self)
    {
        calc=[[Calculating alloc]init];
        sensor=[[Sensor alloc]init];
        sensorController=[[SensorController alloc]init];
        sensorController.sensor=sensor;
        calc.delegate=sensorController;
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSThread* SensorControllerThread=[[NSThread alloc]initWithTarget:sensorController selector:@selector(run) object:nil];
    [SensorControllerThread start];
}

@end
