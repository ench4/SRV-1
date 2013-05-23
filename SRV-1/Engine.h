//
//  Engine.h
//  SRV
//
//  Created by Виктор on 25.04.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EngineSensor.h"



@interface Engine : NSObject<EnginePool>
{
    float U_;
}

@property float A,B;
-(float) angularSpeed;
-(void) setU:(float) U;

@end
