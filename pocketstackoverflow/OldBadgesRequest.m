//
//  OldBadgesRequest.m
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/15/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "OldBadgesRequest.h"

@implementation OldBadgesRequest

@synthesize userIDArray,multiDelegateArray;

static OldBadgesRequest * handler;

+ (OldBadgesRequest*) handler {
	if (handler != nil) {
		return handler;
	}
	else {
		handler = [[OldBadgesRequest alloc] init];
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

- (int)getInterval {
	NSDate *now = [NSDate date];
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setMonth:-6];
	NSDate *sixmonthsago = [calendar dateByAddingComponents:components toDate:now options:0];
	NSTimeInterval interval = floor([sixmonthsago timeIntervalSince1970]);
	return (int)interval;
}

- (void)getOldBadgesForUserID:(NSInteger)userID {

	NSString *string = [NSString stringWithFormat:
						@"https://api.stackexchange.com/2.1/users/%d/badges?todate=%d&order=desc&sort=awarded&site=stackoverflow&page=1&key=TUy5lpkPAMjaEqftXKcvPw((",
						userID,[self getInterval]];
	
	self.needsAllPages = YES;
	self.requestString = string;
	[self run];
}

- (void)getOldBadges {
	
	NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"oldBadgesRequest"];
	if (array) {
		for (id<OldBadgesRequestDelegate> aDelegate in multiDelegateArray) {
			[aDelegate oldBadgesRequestReturnedArray:array andQuotaLeft:100];
		}
	}
	else {
		
		if (!userIDArray) return;
		if ([userIDArray count] == 0) return;
		
		NSDate *now = [NSDate date];
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		[components setMonth:-6];
		NSDate *sixmonthsago = [calendar dateByAddingComponents:components toDate:now options:0];
		NSTimeInterval interval = floor([sixmonthsago timeIntervalSince1970]);
		
		NSString *subString = [NSString stringWithFormat:@"%@",[userIDArray objectAtIndex:0]];
		for (int i = 1; i < [userIDArray count]; i++) {
			subString = [NSString stringWithFormat:@"%@;%@",subString,[userIDArray objectAtIndex:i]];
		}
		
		NSString *string = [NSString stringWithFormat:
							@"https://api.stackexchange.com/2.1/users/%@/badges?todate=%d&order=desc&sort=awarded&site=stackoverflow&page=1&key=TUy5lpkPAMjaEqftXKcvPw((",
							subString,(int)interval];

		self.needsAllPages = NO;
		self.requestString = string;
		[self run];
	}
	
}

- (void)dataRequestReturnedArray:(NSArray *)array andQuotaLeft:(float)quotaLeft {
	[[NSUserDefaults standardUserDefaults] setObject:array forKey:@"oldBadgesRequest"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	for (id<OldBadgesRequestDelegate> aDelegate in multiDelegateArray) {
		[aDelegate oldBadgesRequestReturnedArray:array andQuotaLeft:100];
	}
}

- (void)dataRequestReturnedError:(NSError *)error {
	for (id<OldBadgesRequestDelegate> aDelegate in multiDelegateArray) {
		[aDelegate oldBadgesRequestReturnedError:error];
	}
}

@end
