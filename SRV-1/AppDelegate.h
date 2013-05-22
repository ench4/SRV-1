//
//  AppDelegate.h
//  SRV-1
//
//  Created by Виктор on 02.05.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Calculating.h"
#import "Sensor.h"
#import "SensorController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    Calculating* calc;
    Sensor* sensor;
    SensorController* sensorController;
};

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSObjectController *valueController;

@end
