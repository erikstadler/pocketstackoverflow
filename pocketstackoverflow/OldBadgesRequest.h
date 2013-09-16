//
//  OldBadgesRequest.h
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/15/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "DataRequest.h"

@protocol OldBadgesRequestDelegate
- (void)oldBadgesRequestReturnedError:(NSError*)error;
- (void)oldBadgesRequestReturnedArray:(NSArray*)array andQuotaLeft:(float)quotaLeft;
@end

@interface OldBadgesRequest : DataRequest<DataRequestDelegate>

+ (OldBadgesRequest*) handler;
- (void)reset;

- (void)getOldBadges;
- (void)getOldBadgesForUserID:(NSInteger)userID;

@property (nonatomic, retain) NSMutableArray *multiDelegateArray; // Of id<OldBadgesRequestDelegate> objects
@property (nonatomic, retain) NSMutableArray *userIDArray;

@end
