//
//  Question.h
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Question : NSObject

- (id)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic, retain) User* user;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* link;
@property (nonatomic, assign) NSInteger answersSubmitted;
@property (nonatomic, assign) NSInteger totalScore;

@end
