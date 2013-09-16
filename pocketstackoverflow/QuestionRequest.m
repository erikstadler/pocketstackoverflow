//
//  QuestionRequest.m
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/15/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "QuestionRequest.h"

@implementation QuestionRequest

@synthesize delegate;

- (id)init {
    if ((self = [super init])) {
		self.requestString = @"https://api.stackexchange.com/2.1/questions?order=desc&sort=votes&site=stackoverflow&page=1&key=TUy5lpkPAMjaEqftXKcvPw((";
		self.dataRequestDelegate = self;
		self.needsAllPages = NO;
    }
    return self;
}

- (void)getQuestionList {
	
	NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"questionRequest"];
	if (array) {
		[delegate questionRequestReturnedArray:array andQuotaLeft:100];
	}
	else {
		[self run];
	}
}

- (void)dataRequestReturnedArray:(NSArray *)array andQuotaLeft:(float)quotaLeft {
	[[NSUserDefaults standardUserDefaults] setObject:array forKey:@"questionRequest"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[delegate questionRequestReturnedArray:array andQuotaLeft:quotaLeft];
}

- (void)dataRequestReturnedError:(NSError *)error {
	[delegate questionRequestReturnedError:error];
}

@end
