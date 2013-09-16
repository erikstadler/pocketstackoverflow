//
//  Badge.m
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "Badge.h"
#import "User.h"

@implementation Badge

@synthesize name,rank,timesAwarded,user;

- (id)initWithDictionary:(NSDictionary*)dictionary {
    if ((self = [super init])) {
		
		name = [dictionary objectForKey:@"name"];
		rank = [dictionary objectForKey:@"rank"];
		timesAwarded = [[dictionary objectForKey:@"award_count"] integerValue];
		user = [[User alloc] initWithDictionary:[dictionary objectForKey:@"user"] andRequestBadges:NO];
    }
    return self;
}

@end
