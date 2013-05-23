//
//  PID.h
//  SRV
//
//  Created by Виктор on 25.04.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Engine.h"
#import "EngineSensor.h"

@interface PIDController : NSObject<PIDControllerProtocol>
{
    float prevError;
    float integralValue;
}

-(id) initWithk1:(float) k1 k2:(float) k2 andK3: (float)k3;
@property float neededValue;
@property Engine* engine;


@end
