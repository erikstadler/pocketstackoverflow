//
//  DataRequest.h
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataRequestDelegate
- (void)dataRequestReturnedError:(NSError*)error;
- (void)dataRequestReturnedArray:(NSArray*)array andQuotaLeft:(float)quotaLeft;
@end

@interface DataRequest : NSObject

// Public
- (void)run;

@property (nonatomic, retain) NSString *requestString;
@property (nonatomic, assign) BOOL needsAllPages; // Otherwise just return first page
@property (nonatomic, retain) id<DataRequestDelegate> dataRequestDelegate;

@end
