//
//  AppDelegate.m
//  SRV-1
//
//  Created by Виктор on 02.05.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()
@property NSMutableArray* noisedSignal;
@property NSMutableArray* filtredSignal;
@property NSMutableArray* pureSignal;
@property NSMutableArray* waterLevelSignal;

@end

@implementation AppDelegate
@synthesize noisedSignal;
@synthesize filtredSignal;
@synthesize pureSignal;

-(id) init
{
    self=[super init];
    if (self)
    {
        noisedSignal=[[NSMutableArray alloc]init];
        [noisedSignal addObject:[NSNumber numberWithFloat:0.0]];
        
        self.filtredSignal=[[NSMutableArray alloc]init];
        [self.filtredSignal addObject:[NSNumber numberWithFloat:0.0]];
        self.pureSignal=[[NSMutableArray alloc]init];
        [self.pureSignal addObject:[NSNumber numberWithFloat:0.0]];
        self.waterLevelSignal=[[NSMutableArray alloc]init];
        [self.waterLevelSignal addObject:[NSNumber numberWithFloat:0.0]];

#ifdef ENGINE_MODE
        engine=[[Engine alloc]init];
        sensor=[[EngineSensor alloc]init];
        controller=[[PIDController alloc]initWithk1:1 k2:0.3 andK3:0.3];
#else
        sensor=[[Sensor alloc]init];
#endif
        calc=[[Calculating alloc]init];
        sensorController=[[SensorController alloc]init];
        sensorController.sensor=sensor;
        calc.delegate=sensorController;

    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
#ifdef ENGINE_MODE
    engine.A=0;
    engine.B=1;
    
    sensor.engineDelegate=engine;
    sensor.controllerDelegate=controller;
    
    controller.engine=engine;
    controller.neededValue=50;
#endif
    sensorController.sharedNoisedSignal=self.noisedArrayController;
    calc.sharedWaterLevel=self.waterLevelController;
    
    [self.signalView bind:@"vector" toObject:self.noisedArrayController withKeyPath:@"arrangedObjects.floatValue" options:nil];
    [self.waterLevelView bind:@"vector" toObject:self.waterLevelController withKeyPath:@"arrangedObjects.floatValue" options:nil];
    //[self.noisedArrayController addObserver:self.signalView forKeyPath:@"arrangedObjects.floatValue" options:0 context:nil];
    
    NSThread* SensorControllerThread=[[NSThread alloc]initWithTarget:sensorController selector:@selector(run) object:nil];
    [SensorControllerThread start];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(error) name:@"complete" object:nil];
    
}

-(float) error
{
    float error=0;
    float errorNoise=0;
    for (int i=0; i<[pureSignal count]; ++i) {
        error+=fabsf([pureSignal[i] floatValue]-[filtredSignal[i] floatValue]);
        errorNoise+=fabsf([pureSignal[i] floatValue]-[noisedSignal[i] floatValue]);
    }
    [self.errorLabel setStringValue:[NSString stringWithFormat:@"%f",error]];
    [self.errorLabelNoise  setStringValue:[NSString stringWithFormat:@"%f",errorNoise]];
    return error;
}

@end
