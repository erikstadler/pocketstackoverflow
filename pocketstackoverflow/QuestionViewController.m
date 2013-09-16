//
//  QuestionViewController.m
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController
@synthesize question;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[self updateUI];
	
	if (question) {
		if (question.user) {
			
			if (!question.user.mostRecentBadge) {
				[[RecentBadgesRequest handler] getRecentBadgeListForUserID:question.user.userID];
			}
			
			if (!question.user.badges) {
				[[OldBadgesRequest handler] getOldBadgesForUserID:question.user.userID];
			}
			else if ([question.user.badges count] == 0) {
				[[OldBadgesRequest handler] getOldBadgesForUserID:question.user.userID];
			}
		}
	}

}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	if (_timer) [_timer invalidate];
}

- (void)updateUI {

	_userLabel.text = question.user.name;
	
	if (!_userGravatarImageView.image) {
		_userGravatarImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:question.user.gravatar]]];
	}
	
	if (question.user.mostRecentBadge) {
		_mostRecentBadgeLabel.text = question.user.mostRecentBadge.name;
	}
	else {
		_mostRecentBadgeLabel.text = @"None";
	}
	
	if (question.user.badges) {
		if ([question.user.badges count] != 0) {

			_numBadgesSixMonthsAgoLabel.text = [NSString stringWithFormat:@"%d",[question.user.badges count]];

			_goldAmtLabel.text = [NSString stringWithFormat:@"%d",[self findAmtBadgesByRank:@"gold"]];
			_silverAmtLabel.text = [NSString stringWithFormat:@"%d",[self findAmtBadgesByRank:@"silver"]];
			_bronzeAmtLabel.text = [NSString stringWithFormat:@"%d",[self findAmtBadgesByRank:@"bronze"]];
			
		}
		else {
			_numBadgesSixMonthsAgoLabel.text = @"None";
			_goldAmtLabel.text = @"0";
			_silverAmtLabel.text = @"0";
			_bronzeAmtLabel.text = @"0";
		}
	}
	else {
		_numBadgesSixMonthsAgoLabel.text = @"None";
		_goldAmtLabel.text = @"0";
		_silverAmtLabel.text = @"0";
		_bronzeAmtLabel.text = @"0";
	}
	
	_titleLabel.text = question.title;
	_linkLabel.text = question.link;
	_numAnswersSubmittedLabel.text = [NSString stringWithFormat:@"%d",question.answersSubmitted];
	_totalScoreLabel.text = [NSString stringWithFormat:@"%d",question.totalScore];
	
}

- (NSInteger)findAmtBadgesByRank:(NSString*)rank {
	NSInteger total = 0;
	for (Badge *badge in question.user.badges) {
		if ([rank isEqualToString:badge.rank]) {
			total++;
		}
	}
	return total;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
