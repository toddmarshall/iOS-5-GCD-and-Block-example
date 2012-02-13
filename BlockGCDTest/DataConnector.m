//
//  DataConnector.m
//  BlockGCDTest
//
//  Created by Todd Marshall on 2/11/12.
//  Copyright (c) 2012 SunGard Global Services. All rights reserved.
//

#import "DataConnector.h"


@implementation DataConnector
- (id) init
{
    if (self = [super init]) {
        backgroundQueue = dispatch_queue_create("com.sungard.sgs.blockgcdtest.bgq", NULL);
    }
    return self;
}

- (void) getContentsOfURLFromString:(NSString *) urlString 
                   withSuccessBlock:(DataConnectorSuccessBlock) successBlock 
                   withFailureBlock:(DataConnectorFailureBlock) failureBlock
{

    // run the dataload on another thread so we don't block the main thread that handles the interface
    dispatch_async(backgroundQueue, ^{
        NSError * error = nil;
        NSURL * url = [NSURL URLWithString:urlString];
        NSString * results = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        
        // execute this block on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                failureBlock(error);
            }
            else {
                successBlock(results);
            }
        });
        
    });
    
    

}
@end
