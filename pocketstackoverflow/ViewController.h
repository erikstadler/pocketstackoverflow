//
//  ViewController.h
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionRequest.h"
#import "Question.h"
#import "QuestionCell.h"
#import "OldBadgesRequest.h"

@interface ViewController : UIViewController <QuestionRequestDelegate,UITableViewDelegate,UITableViewDataSource>

- (IBAction)queryJSON:(id)sender;
- (IBAction)clearCaches:(id)sender;

@property (nonatomic, retain) IBOutlet UIProgressView *progressView;

@property (nonatomic, retain) IBOutlet UILabel *highestScoreQuestionLabel;
@property (nonatomic, retain) IBOutlet UILabel *sumReputationTitle;

@property (nonatomic, retain) NSMutableArray *allQuestions;
@property (nonatomic, retain) IBOutlet UITableView *questionTable;

@end
