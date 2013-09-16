//
//  QuestionViewController.h
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "RecentBadgesRequest.h"
#import "OldBadgesRequest.h"

@interface QuestionViewController : UIViewController

@property (nonatomic, retain) Question *question;

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) IBOutlet UILabel *userLabel;

@property (nonatomic, retain) IBOutlet UIImageView *userGravatarImageView;
@property (nonatomic, retain) IBOutlet UILabel *mostRecentBadgeLabel;
@property (nonatomic, retain) IBOutlet UILabel *numBadgesSixMonthsAgoLabel;
@property (nonatomic, retain) IBOutlet UILabel *goldAmtLabel;
@property (nonatomic, retain) IBOutlet UILabel *silverAmtLabel;
@property (nonatomic, retain) IBOutlet UILabel *bronzeAmtLabel;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *linkLabel;
@property (nonatomic, retain) IBOutlet UILabel *numAnswersSubmittedLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalScoreLabel;

@end
