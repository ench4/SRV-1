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
#import "SignalView.h"
#import "Engine.h"
#import "PIDController.h"

//#define ENGINE_MODE

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    Calculating* calc;
#ifdef ENGINE_MODE
    EngineSensor* sensor;
#else
    Sensor* sensor;
#endif
    SensorController* sensorController;
    
    Engine* engine;
    PIDController* controller;
};
@property (weak) IBOutlet NSTextField *errorLabel;
@property (weak) IBOutlet NSTextField *errorLabelNoise;

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSObjectController *valueController;
@property (weak) IBOutlet SignalView *signalView;
@property (weak) IBOutlet SignalView *waterLevelView;
@property (weak) IBOutlet NSArrayController *noisedArrayController;
@property (weak) IBOutlet NSArrayController *filtredArrayController;
@property (weak) IBOutlet NSArrayController *pureArrayController;
@property (weak) IBOutlet NSArrayController *waterLevelController;

@end
