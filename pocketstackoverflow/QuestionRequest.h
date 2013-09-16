//
//  QuestionRequest.h
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/15/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "DataRequest.h"

@protocol QuestionRequestDelegate
- (void)questionRequestReturnedError:(NSError*)error;
- (void)questionRequestReturnedArray:(NSArray*)array andQuotaLeft:(float)quotaLeft;
@end

@interface QuestionRequest : DataRequest<DataRequestDelegate>

- (void)getQuestionList;

@property (nonatomic, retain) id<QuestionRequestDelegate> delegate;

@end
