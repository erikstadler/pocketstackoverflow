//
//  Badge.h
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface Badge : NSObject

- (id)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* rank; // bronze silver gold
@property (nonatomic, assign) NSInteger timesAwarded;

@property (nonatomic, retain) User* user;

@end
