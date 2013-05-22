//
//  SensorController.h
//  SRV-1
//
//  Created by Виктор on 02.05.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculating.h"

@protocol SensorProtocol <NSObject>

-(float) speedValue;

@end

@interface SensorController : NSObject<pull>
{
    NSMutableArray* buffer;
    NSLock* bufferLock;
    NSOperationQueue* queue;
    id calculator;
    SEL calcSelector;
    NSTimer* timer;
    NSRunLoop* loop;
};

@property id<SensorProtocol> sensor;

-(float) pullValueFromBuffer;
-(void) pushValueToBuffer;
-(void) loop;
-(void) run;

@end
