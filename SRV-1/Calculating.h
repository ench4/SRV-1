//
//  Calculating.h
//  SRV-1
//
//  Created by Виктор on 02.05.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol pull <NSObject>

-(float) pullValueFromBuffer;
-(void) setReciever:(id) reciever withSelector:(SEL) selector;

@end

@interface Calculating : NSObject
{
    float deltaTime;
    float s;
    id<pull> _delegate;
}

@property (atomic) float h;
@property id<pull> delegate;

-(void) updateH;
-(float) calc;

//для вывода

@property NSArrayController* sharedWaterLevel;

@end
