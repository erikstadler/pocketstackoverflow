//
//  User.h
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Badge.h"
#import "RecentBadgesRequest.h"
#import "OldBadgesRequest.h"

@interface User : NSObject <RecentBadgesRequestDelegate,OldBadgesRequestDelegate>

- (id)initWithDictionary:(NSDictionary*)dictionary andRequestBadges:(BOOL)willRequest;

@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* gravatar;
@property (nonatomic, retain) Badge* mostRecentBadge; // Recent Badge
@property (nonatomic, retain) NSMutableArray* badges; // array of Badges six months ago

@property (nonatomic, assign) NSInteger reputation;

@end
