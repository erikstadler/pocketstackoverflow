//
//  QuestionCell.h
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionCell : UITableViewCell

- (void)setupWithQuestion:(Question*)question;

@property (nonatomic, retain) IBOutlet UILabel *userName;
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *link;
@property (nonatomic, retain) IBOutlet UILabel *answersSubmitted;
@property (nonatomic, retain) IBOutlet UILabel *totalScore;

@end
