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

    
    dispatch_async(backgroundQueue, ^{
        NSError * error = nil;
        NSURL * url = [NSURL URLWithString:urlString];
        NSString * results = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error);
            });
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock(results);
            });
        }
        
    });
    
    

}
@end
