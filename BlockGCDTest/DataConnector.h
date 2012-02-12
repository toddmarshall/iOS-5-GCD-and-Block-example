//
//  DataConnector.h
//  BlockGCDTest
//
//  Created by Todd Marshall on 2/11/12.
//  Copyright (c) 2012 SunGard Global Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

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
