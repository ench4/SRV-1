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

@synthesize sharedFiltredSignal;
@synthesize sharedNoisedSignal;

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
        time=[NSDate timeIntervalSinceReferenceDate];
    }
    return self;
}

-(void) pushValueToBuffer
{
    //NSLog(@"pushing");
    double speed=[self.sensor speedValue];

    double now=[NSDate timeIntervalSinceReferenceDate];
    double dt=now-time;
    time=now;
    NSNumber* v=[NSNumber numberWithFloat:speed*dt];
    printf("%f\n",[v floatValue]);
    [bufferLock lock];
    [buffer addObject:v];
    [bufferLock unlock];
    
    [self.sharedNoisedSignal performSelector:@selector(addObject:) onThread:[NSThread mainThread] withObject:[NSNumber numberWithFloat:speed] waitUntilDone:NO];
    
    NSInvocationOperation* operation=[[NSInvocationOperation alloc]initWithTarget:calculator selector:calcSelector object:nil];
    [queue addOperation:operation];
}

-(float) pullValueFromBuffer
{
    //NSLog(@"pulling");
    [bufferLock lock];
    if ([buffer count]==0)
    {
        return NAN;
    }
    NSNumber* x=[buffer objectAtIndex:0];
    [buffer removeObjectAtIndex:0];
    [bufferLock unlock];
    
    //отфильтровать шум
    x=[NSNumber numberWithFloat:[self filterNewValue:[x floatValue]]];
    
    
    [self.sharedFiltredSignal performSelector:@selector(addObject:) onThread:[NSThread mainThread] withObject:x waitUntilDone:NO];
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

-(float) filterNewValue:(float)newValue
{
    static float x=INFINITY;
    if (x==INFINITY) x=newValue/2;
    
    x=x*0.5+newValue*0.5;
    return x;
    
    
    /*static NSMutableArray* array=nil;
        if (array==nil) array=[[NSMutableArray alloc]init];
    [array addObject:[NSNumber numberWithFloat:newValue]];
    float sum=0;
    for (NSNumber* x in array) {
        sum+=[x floatValue];
    }
    sum/=[array count];
    
    [array removeLastObject];
    [array addObject:[NSNumber numberWithFloat:sum]];
    
    if ([array count]>1 ) [array removeObjectAtIndex:0];
    
    return sum;*/
    
}

-(void) wait
{
    [queue waitUntilAllOperationsAreFinished];
}

@end
