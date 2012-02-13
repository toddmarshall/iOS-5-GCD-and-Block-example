//
//  Validator.h
//  BlockGCDTest
//
//  Created by Todd Marshall on 2/11/12.
//  Copyright (c) 2012 SunGard Global Services. All rights reserved.
//
//  This class is designed to show the difference that using GCD can make to interface responsivness when doing "heavy 
//  weight" input validation.  However, I picked a bad example and suspect that GCD just adds unnecessary overhead in this 
//  case.  I you were to change it to a CoreData lookup instead of a regex evaluation, it might make sense. 

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

// typedefs + blocks = better readability
typedef void (^ValidatorSuccessBlock)(void);
typedef void (^ValidatorFailureBlock)(void);

@interface Validator : NSObject
{
    dispatch_queue_t backgroundQueue;
}

- (void) validateUrl: (NSString *) candidate withSuccessBlock:(ValidatorSuccessBlock)successBlock withFailureBlock:(ValidatorFailureBlock) failBlock;

- (void) validateUrlNoGCD: (NSString *) candidate withSuccessBlock:(ValidatorSuccessBlock)successBlock withFailureBlock:(ValidatorFailureBlock) failBlock;
@end
