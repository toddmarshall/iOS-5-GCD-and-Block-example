//
//  Validator.h
//  BlockGCDTest
//
//  Created by Todd Marshall on 2/11/12.
//  Copyright (c) 2012 SunGard Global Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

typedef void (^ValidatorSuccessBlock)(void);
typedef void (^ValidatorFailureBlock)(void);

@interface Validator : NSObject
{
    dispatch_queue_t backgroundQueue;
}

- (void) validateUrl: (NSString *) candidate withSuccessBlock:(ValidatorSuccessBlock)successBlock withFailureBlock:(ValidatorFailureBlock) failBlock;

- (void) validateUrlNoGCD: (NSString *) candidate withSuccessBlock:(ValidatorSuccessBlock)successBlock withFailureBlock:(ValidatorFailureBlock) failBlock;
@end
