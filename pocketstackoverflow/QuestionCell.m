//
//  QuestionCell.m
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "QuestionCell.h"

@implementation QuestionCell


- (void)setupWithQuestion:(Question*)question {
		_userName.text = [NSString stringWithFormat:@"%@",question.user.name];
		_title.text = [NSString stringWithFormat:@"%@",question.title];
		_link.text = [NSString stringWithFormat:@"%@",question.link];
		_answersSubmitted.text = [NSString stringWithFormat:@"%d",question.answersSubmitted];
		_totalScore.text = [NSString stringWithFormat:@"%d",question.totalScore];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
