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
#else
    sensor.sharedPureArray=self.pureArrayController;
#endif
    sensorController.sharedNoisedSignal=self.noisedArrayController;
    sensorController.sharedFiltredSignal=self.filtredArrayController;
    
    
    calc.sharedWaterLevel=self.waterLevelController;
    
    [self.signalView bind:@"vector" toObject:self.noisedArrayController withKeyPath:@"arrangedObjects.floatValue" options:nil];
    [self.waterLevelView bind:@"vector" toObject:self.waterLevelController withKeyPath:@"arrangedObjects.floatValue" options:nil];

    NSThread* SensorControllerThread=[[NSThread alloc]initWithTarget:sensorController selector:@selector(run) object:nil];
    [SensorControllerThread start];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(error) name:@"complete" object:nil];
    
}

-(void) error
{
    /*float error=0;
    float errorNoise=0;
    NSLog(@"%@",self.noisedSignal);
    for (int i=0; i<[pureSignal count]; ++i) {
        error+=fabsf([pureSignal[i] floatValue]-[filtredSignal[i] floatValue]);
        NSLog(@"%f",error);
        errorNoise+=fabsf([pureSignal[i] floatValue]-[noisedSignal[i] floatValue]);
    }
    [self.errorLabel setStringValue:[NSString stringWithFormat:@"%f",error]];
    [self.errorLabelNoise  setStringValue:[NSString stringWithFormat:@"%f",errorNoise]];
    return error;*/
   // NSLog(@"%@%@%@",self.pureSignal,self.noisedSignal,self.filtredSignal);
    [sensorController wait];
    
    for (int i=0; i<[self.pureSignal count]; ++i) {
        printf("%f\t%f\t%f\n",[pureSignal[i] floatValue],[noisedSignal[i] floatValue],[filtredSignal[i] floatValue]);
    }
    NSSet
}

@end
