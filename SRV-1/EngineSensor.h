//
//  Sensor.h
//  SRV
//
//  Created by Виктор on 25.04.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SensorController.h"

@protocol EnginePool <NSObject>

-(float) speedValue;

@end

@protocol PIDControllerProtocol <NSObject>

-(void) hasNewValue:(float) val;

@end



@interface EngineSensor : NSObject<SensorProtocol>
{
    float speedValue_;
}

@property id<EnginePool> engineDelegate;
@property id<PIDControllerProtocol> controllerDelegate;
@property NSMutableArray* allValues;
@property float speedValue;

@end
