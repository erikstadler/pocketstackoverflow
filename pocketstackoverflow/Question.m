//
//  Question.m
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "Question.h"

@implementation Question

@synthesize user,title,link,answersSubmitted,totalScore;

- (id)initWithDictionary:(NSDictionary*)dictionary {
    if ((self = [super init])) {

		user = [[User alloc] initWithDictionary:[dictionary objectForKey:@"owner"] andRequestBadges:YES];
		title = [dictionary objectForKey:@"title"];
		link = [dictionary objectForKey:@"link"];
		answersSubmitted = [[dictionary objectForKey:@"answer_count"] integerValue];
		totalScore = [[dictionary objectForKey:@"score"] integerValue];
		
    }
    return self;
}

@end
