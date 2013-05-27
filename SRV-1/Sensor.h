//
//  Sensor.h
//  SRV-1
//
//  Created by Виктор on 02.05.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SensorController.h"

@interface Sensor : NSObject<SensorProtocol>
{
    double time;
}

-(float) speedValue;

//для вывода

@property NSArrayController* sharedPureArray;

@end
