//
//  DataRequest.m
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "DataRequest.h"

@implementation DataRequest {
	NSArray *allData; // Loads up if more pages are required
	
	float quotaRemaining;
	float quotaMax;
	BOOL hasMore;
	NSInteger currentPage;
}

@synthesize requestString,needsAllPages,dataRequestDelegate;

- (void)run {
	if (!dataRequestDelegate || !requestString) {
		NSLog(@"Requires delegate and request string to be set before proceeding");
	}
	
	// Start
	currentPage = 1;
	allData = [[NSArray alloc] init];
	[self queryJSON:requestString];
}

- (NSString*)nextPage:(NSString*)string {
	NSString *oldString = [NSString stringWithFormat:@"page=%d",currentPage];
	NSString *newString = [NSString stringWithFormat:@"page=%d",++currentPage];
	return [string stringByReplacingOccurrencesOfString:oldString withString:newString];
}

- (void)queryJSON:(NSString*)string {
	
	//NSLog(@"Data Request query %@",string);
	
	NSURL *url = [NSURL URLWithString:string];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		
		if (error) {
			[dataRequestDelegate dataRequestReturnedError:error];
		}
		else {
			NSError *jsonError;
			NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
			
			if (jsonError) {
				[dataRequestDelegate dataRequestReturnedError:jsonError];
			}
			else {
				quotaMax = 0;
				quotaRemaining = 0;
				quotaMax = [[json objectForKey:@"quota_max"] integerValue];
				quotaRemaining = [[json objectForKey:@"quota_remaining"] integerValue];
				hasMore = [[json objectForKey:@"has_more"] boolValue];
				
				NSArray *array = [json objectForKey:@"items"];
				if (!array) {
					NSLog(@"Data Request returned with no items but with response of %@",json);
				}
				
				allData = [allData arrayByAddingObjectsFromArray:array];
				
				if ( !quotaMax || !quotaRemaining) {
					[dataRequestDelegate dataRequestReturnedArray:allData andQuotaLeft:0];
				}
				// If requiring all pages, continue till data is exhausted
				else if (hasMore && needsAllPages) {
					[self queryJSON:[self nextPage:string]];
				}
				else {
					[dataRequestDelegate dataRequestReturnedArray:allData andQuotaLeft:(quotaRemaining/quotaMax)];
				}
				
			}
			
		}
		
	}];
	
}

@end
