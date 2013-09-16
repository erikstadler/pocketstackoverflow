//
//  BadgesRequest.m
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "RecentBadgesRequest.h"

@implementation RecentBadgesRequest

@synthesize userIDArray,multiDelegateArray;

static RecentBadgesRequest * handler;

+ (RecentBadgesRequest*) handler {
	if (handler != nil) {
		return handler;
	}
	else {
		handler = [[RecentBadgesRequest alloc] init];
		return handler;
	}
}

- (id)init {
    if ((self = [super init])) {
		
		userIDArray = [[NSMutableArray alloc] init];
		multiDelegateArray = [[NSMutableArray alloc] init];
		
		self.dataRequestDelegate = self;
		self.needsAllPages = NO;
    }
    return self;
}

- (void)reset {
	[userIDArray removeAllObjects];
	[multiDelegateArray removeAllObjects];
}

- (void)getRecentBadgeListForUserID:(NSInteger)userID {
	
	NSString *string = [NSString stringWithFormat:
						@"https://api.stackexchange.com/2.1/users/%d/badges?order=desc&sort=awarded&site=stackoverflow&key=TUy5lpkPAMjaEqftXKcvPw((",
						userID];
	
	self.requestString = string;
	[self run];
}

- (void)getRecentBadgeListForAllUsersInUserArray {
	NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"recentBadgesRequest"];
	if (array) {
		for (id<RecentBadgesRequestDelegate> aDelegate in multiDelegateArray) {
			[aDelegate recentBadgesRequestReturnedArray:array andQuotaLeft:100];
		}
	}
	else {
		
		if (!userIDArray) return;
		if ([userIDArray count] == 0) return;
		
		NSString *subString = [NSString stringWithFormat:@"%@",[userIDArray objectAtIndex:0]];
		for (int i = 1; i < [userIDArray count]; i++) {
			subString = [NSString stringWithFormat:@"%@;%@",subString,[userIDArray objectAtIndex:i]];
		}
		
		NSString *string = [NSString stringWithFormat:
							@"https://api.stackexchange.com/2.1/users/%@/badges?order=desc&sort=awarded&site=stackoverflow&page=1&key=TUy5lpkPAMjaEqftXKcvPw((",
							subString];

		self.requestString = string;
		[self run];
	}
}

- (void)dataRequestReturnedArray:(NSArray *)array andQuotaLeft:(float)quotaLeft {
	[[NSUserDefaults standardUserDefaults] setObject:array forKey:@"recentBadgesRequest"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	for (id<RecentBadgesRequestDelegate> aDelegate in multiDelegateArray) {
		[aDelegate recentBadgesRequestReturnedArray:array andQuotaLeft:quotaLeft];
	}
}

- (void)dataRequestReturnedError:(NSError *)error {
	for (id<RecentBadgesRequestDelegate> aDelegate in multiDelegateArray) {
		[aDelegate recentBadgesRequestReturnedError:error];
	}
}

@end
