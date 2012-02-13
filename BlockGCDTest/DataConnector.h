//
//  DataConnector.h
//  BlockGCDTest
//
//  Created by Todd Marshall on 2/11/12.
//  Copyright (c) 2012 SunGard Global Services. All rights reserved.
//
//  This class shows how to implement a background data load from a url and return the data to the main thread.  In this 
//  case blocks replace what would normally be done with a delegate.

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>


// typedefs make your code much more readable when using blocks
typedef void (^DataConnectorSuccessBlock)(NSString * returnData);
typedef void (^DataConnectorFailureBlock)(NSError  * error);

@interface DataConnector : NSObject
{
    dispatch_queue_t backgroundQueue;
}
- (void) getContentsOfURLFromString:(NSString *) urlString 
                   withSuccessBlock:(DataConnectorSuccessBlock) successBlock 
                   withFailureBlock:(DataConnectorFailureBlock) failureBlock;
@end
