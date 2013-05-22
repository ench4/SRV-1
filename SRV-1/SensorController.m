//
//  SensorController.m
//  SRV-1
//
//  Created by Виктор on 02.05.13.
//  Copyright (c) 2013 Виктор. All rights reserved.
//

#import "SensorController.h"

@interface SensorController ()

-(float) filterNewValue:(float) newValue;

@end


@implementation SensorController

-(id) init
{
    self=[super init];
    if (self)
    {
        buffer=[[NSMutableArray alloc]init];
        bufferLock=[[NSLock alloc]init];
        queue=[[NSOperationQueue alloc]init];
        queue.maxConcurrentOperationCount=1;
        loop=nil;
    }
    return self;
}

-(void) pushValueToBuffer
{
    NSLog(@"pushing");
    [bufferLock lock];
    [buffer addObject:[NSNumber numberWithFloat:[self.sensor speedValue]]];
    [bufferLock unlock];
    
    NSInvocationOperation* operation=[[NSInvocationOperation alloc]initWithTarget:calculator selector:calcSelector object:nil];
    [queue addOperation:operation];
}

-(float) pullValueFromBuffer
{
    NSLog(@"pulling");
    [bufferLock lock];
    if ([buffer count]==0)
    {
        return NAN;
    }
    NSNumber* x=[buffer objectAtIndex:0];
    [buffer removeObjectAtIndex:0];
    [bufferLock unlock];
    
    //отфильтровать шум
    
    return [x floatValue];
}

-(void) setReciever:(id)reciever withSelector:(SEL)selector
{
    calculator=reciever;
    calcSelector=selector;
}

-(void) loop
{
    [self pushValueToBuffer];    
}

-(void)run
{
    if (loop==nil){
        loop=[NSRunLoop currentRunLoop];

    }
    timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(loop) userInfo:nil repeats:YES] ;
    [loop addTimer:timer forMode:NSRunLoopCommonModes];
    [self loop];
    [loop run];
}

@end
