//
//  ViewController.m
//  pocketstackoverflow
//
//  Created by Erik Stadler on 9/14/13.
//  Copyright (c) 2013 Erik Stadler. All rights reserved.
//

#import "ViewController.h"
#import "QuestionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	_allQuestions = [[NSMutableArray alloc] init];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertTitle:(NSString*)title andMessage:(NSString*)message {
	UIAlertView *alert = [[UIAlertView alloc]
			initWithTitle:title
			message:message
			delegate:nil
			cancelButtonTitle:@"OK"
			otherButtonTitles:nil];
	[alert show];
}

- (IBAction)queryJSON:(id)sender {

	QuestionRequest *request = [[QuestionRequest alloc] init];
	[request setDelegate:self];
	[request getQuestionList];

}

- (IBAction)clearCaches:(id)sender {
	
	[[OldBadgesRequest handler] reset];
	[[RecentBadgesRequest handler] reset];

	[[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"questionRequest"];
	[[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"oldBadgesRequest"];
	[[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"recentBadgesRequest"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	_highestScoreQuestionLabel.text = @"";
	_sumReputationTitle.text = @"";
	[_allQuestions removeAllObjects];
	[_questionTable reloadData];
	[_questionTable reloadInputViews];
}

// DataRequest Delegates
- (void)questionRequestReturnedArray:(NSArray *)array andQuotaLeft:(float)quotaLeft {

	[_progressView setProgress:quotaLeft];
	[_allQuestions removeAllObjects];
	NSInteger reputationSum = 0;
	
	for (NSDictionary *questionFromDictionary in array) {
		
		Question *question = [[Question alloc] initWithDictionary:questionFromDictionary];
		
		[_allQuestions addObject:question];
		
		reputationSum += question.user.reputation;
	}

	// Get Highest Scored question and title
	if (_allQuestions) {
		if ([_allQuestions count] != 0) {
			Question *highestQuestion = [_allQuestions objectAtIndex:0];
			_highestScoreQuestionLabel.text = [NSString stringWithFormat:@"%@",highestQuestion.title];
			_sumReputationTitle.text = [NSString stringWithFormat:@"%d",reputationSum];
		}
	}
	
	// reload question table
	[_questionTable reloadData];
	[_questionTable reloadInputViews];
	
	// AutoContinue Data Collection
	[[RecentBadgesRequest handler] getRecentBadgeListForAllUsersInUserArray];
	[[OldBadgesRequest handler] getOldBadges];
}

- (void)questionRequestReturnedError:(NSError *)error {
	NSLog(@"Recent Question Data Error %@",error.localizedDescription);
	[self showAlertTitle:@"Recent Question Data Error" andMessage:error.localizedDescription];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Recent Questions List";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (!_allQuestions) return 0;
	return [_allQuestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"QuestionCell";
	QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[QuestionCell alloc] init];
	}

	Question *currentQuestion = [_allQuestions objectAtIndex:indexPath.row];
	[cell setupWithQuestion:currentQuestion];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath	{
	Question *selectedQuestion = [_allQuestions objectAtIndex:indexPath.row];
	[self performSegueWithIdentifier:@"ShowQuestionViewController" sender:selectedQuestion];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	QuestionViewController *vc = [segue destinationViewController];
	[vc setQuestion:(Question*)sender];
}











@end
