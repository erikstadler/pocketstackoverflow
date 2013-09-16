//
//  User.m
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDictionary:(NSDictionary*)dictionary andRequestBadges:(BOOL)willRequest {
    if ((self = [super init])) {
		
		_userID = [[dictionary objectForKey:@"user_id"] integerValue];
		_name = [dictionary objectForKey:@"display_name"];
		_gravatar = [dictionary objectForKey:@"profile_image"];
		
		if (willRequest) {
			[[[RecentBadgesRequest handler] userIDArray] addObject:[NSNumber numberWithInteger:_userID]];
			[[[RecentBadgesRequest handler] multiDelegateArray] addObject:self];
			[[[OldBadgesRequest handler] userIDArray] addObject:[NSNumber numberWithInteger:_userID]];
			[[[OldBadgesRequest handler] multiDelegateArray] addObject:self];
		}
		
		_mostRecentBadge = nil;
		_badges = [[NSMutableArray alloc] init];
		
		_reputation = [[dictionary objectForKey:@"reputation"] integerValue];
		
    }
    return self;
}

// Delegates
- (void)recentBadgesRequestReturnedArray:(NSArray *)array andQuotaLeft:(float)quotaLeft	{

	for (NSDictionary *badgeAsDictionary in array) {
		
		Badge *badge = [[Badge alloc] initWithDictionary:badgeAsDictionary];
		if (badge.user.userID == _userID) {
			badge.user = self; // Important else you will have two duplicate User objects.  ARC handles release of duplicate
			_mostRecentBadge = badge;
			break;// Only want the newest badge here
		}
	}

}

- (void)recentBadgesRequestReturnedError:(NSError *)error {
	NSLog(@"Recent Badges Data Error %@ for user %@",error.localizedDescription,_name);
}

- (void)oldBadgesRequestReturnedArray:(NSArray *)array andQuotaLeft:(float)quotaLeft {
	
	for (NSDictionary *badgeAsDictionary in array) {
		
		Badge *badge = [[Badge alloc] initWithDictionary:badgeAsDictionary];
		
		if (badge.user.userID == _userID) {
			
			badge.user = self; // Important else you will have two duplicate User objects.  ARC handles release of duplicate
			[_badges addObject:badge];
		}
	}
	
}

- (void)oldBadgesRequestReturnedError:(NSError *)error {
	NSLog(@"Old Badges Data Error %@ for user %@",error.localizedDescription,_name);
}

@end
