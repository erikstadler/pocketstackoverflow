//
//  BadgesRequest.h
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "DataRequest.h"

@protocol RecentBadgesRequestDelegate
- (void)recentBadgesRequestReturnedError:(NSError*)error;
- (void)recentBadgesRequestReturnedArray:(NSArray*)array andQuotaLeft:(float)quotaLeft;
@end

@interface RecentBadgesRequest : DataRequest<DataRequestDelegate>

+ (RecentBadgesRequest*) handler;
- (void)reset;

- (void)getRecentBadgeListForUserID:(NSInteger)userID;
- (void)getRecentBadgeListForAllUsersInUserArray;

@property (nonatomic, retain) NSMutableArray *multiDelegateArray;
@property (nonatomic, retain) NSMutableArray *userIDArray;

@end
