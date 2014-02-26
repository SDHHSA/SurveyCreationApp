//
//  UserHomePageViewController.m
//  HaitiQuestionnaireJan2014
//
//  Created by Rex Fatahi on 1/14/14.
//  Copyright (c) 2014 Rex Fatahi. All rights reserved.
//

#import "UserHomePageViewController.h"
#import "QuestionnaireCreateViewController.h"

@interface UserHomePageViewController () <UITableViewDataSource, UITableViewDelegate>

{
    NSArray* dataSource;
}

@property (strong, nonatomic) UITableView* tableView;

@end

@implementation UserHomePageViewController

- (void)loadView
{
    [super loadView];
 
    
    
    [self loadCustomLifeCycleInit];

    
}

- (void)loadCustomLifeCycleInit
{
    [self.navigationController setNavigationBarHidden:YES];

    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // list of created surveys
    
    CGRect selectQuestionnaireLabelRect = CGRectMake(10, 24, self.view.bounds.size.width - 20, 30);
    UILabel* seletQuestionnaireLabel = [[UILabel alloc] initWithFrame:selectQuestionnaireLabelRect];
    seletQuestionnaireLabel.text = @"SELECT QUESTIONNAIRE";
    [self.view addSubview:seletQuestionnaireLabel];
    
    
    CGRect tvFrame = CGRectMake(10, 64, self.view.bounds.size.width - 20, self.view.bounds.size.height - 64 - 60);
    
    _tableView = [[UITableView alloc] initWithFrame:tvFrame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    // option to create survey
    CGRect createSurveyButtonRect = CGRectMake(10, tvFrame.origin.y + tvFrame.size.height + 10, self.view.bounds.size.width - 20, 44);
    UIButton* createSurveyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    createSurveyButton.backgroundColor = [UIColor blueColor];
    [createSurveyButton setTitle:@"CREATE SURVEY" forState:UIControlStateNormal];
    createSurveyButton.frame = createSurveyButtonRect;
    [createSurveyButton addTarget:self action:@selector(createSurvey) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createSurveyButton];
    
    
    // retrieve data source
    NSString* urlString = @"http://localhost:1230/surveyget";
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"connectionErroe = %@", connectionError);
            return;
        }
        
        dataSource = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
        
    }];
    
    
    
    
    
    // data source is list of surveys found under user's id
}

#pragma mark - button action
- (void)createSurvey
{
     NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    QuestionnaireCreateViewController* questionnaireCreateViewController = [[QuestionnaireCreateViewController alloc] init];
    [self.navigationController pushViewController:questionnaireCreateViewController animated:NO];
}

#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return dataSource.count;
    //return _listQuestionnaires.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    NSDictionary* curentObject= [dataSource objectAtIndex:indexPath.row];

    
    NSString *stringFromDate = [curentObject valueForKey:@"date"];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"survey created at %@", stringFromDate];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
}

@end
