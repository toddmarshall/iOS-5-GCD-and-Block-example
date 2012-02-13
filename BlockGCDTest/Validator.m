//
//  Validator.m
//  BlockGCDTest
//
//  Created by Todd Marshall on 2/11/12.
//  Copyright (c) 2012 SunGard Global Services. All rights reserved.
//

#import "Validator.h"

@implementation Validator
- (id) init
{
    if (self = [super init]) {
        backgroundQueue = dispatch_queue_create("com.sungard.sgs.blockgcdtest.vq", NULL);
    }
    return self;
}

- (void) validateUrl: (NSString *) candidate withSuccessBlock:(ValidatorSuccessBlock)successBlock withFailureBlock:(ValidatorFailureBlock) failBlock {
    
    // execute the block on another thread
    dispatch_async(backgroundQueue, ^{
        NSString *urlRegEx =
        @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
        NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
        BOOL result = [urlTest evaluateWithObject:candidate];
        
        
            // execute this block on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) 
                    successBlock();
                else
                    failBlock();
            });
       

    });
}

- (void) validateUrlNoGCD: (NSString *) candidate withSuccessBlock:(ValidatorSuccessBlock)successBlock withFailureBlock:(ValidatorFailureBlock) failBlock
{
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    BOOL result = [urlTest evaluateWithObject:candidate];

        if (result) 
            successBlock();
        else
            failBlock();


}

@end
