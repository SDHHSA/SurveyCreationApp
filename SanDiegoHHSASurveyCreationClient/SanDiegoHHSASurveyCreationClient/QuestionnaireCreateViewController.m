//
//  QuestionnaireCreateViewController.m
//  HaitiQuestionnaireJan2014
//
//  Created by Rex Fatahi on 1/21/14.
//  Copyright (c) 2014 Rex Fatahi. All rights reserved.
//

#import "QuestionnaireCreateViewController.h"
#import "SingleQuestionCreateViewController.h"

@interface QuestionnaireCreateViewController () <UITextFieldDelegate>
{
    UIScrollView* scrollView;
    
    // text fields
    UITextField* enterQuestionnaireNameField;
    UITextField* enterQuestionnaireTopicField;
    
}

@end

@implementation QuestionnaireCreateViewController

- (void)loadView
{
    [super loadView];
    
    CGFloat heightFactorOffset = 44.0f;
    CGRect scrollViewRect = CGRectMake(0, heightFactorOffset, self.view.bounds.size.width, self.view.bounds.size.height - heightFactorOffset);
    scrollView = [[UIScrollView alloc] initWithFrame:scrollViewRect];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    // display selected language, option to add language
    
    // if no language, fields are not editable

    
    // rects ordered top down
    CGRect createQuestionnaireRect = CGRectMake(10, 0, 200, 44);
    CGRect frame1InScrollViewRect = CGRectMake(10, 10, self.view.bounds.size.width - 20, 44);
    CGRect frame2InScrollViewRect = CGRectMake(10, 64, self.view.bounds.size.width - 20, 44);
    CGRect frame3InScrollViewRect = CGRectMake(10, 118, self.view.bounds.size.width - 20, 44);
//    CGRect frame4InScrollViewRect = CGRectMake(10, 282, 300, 44);
    
    
    //    enter language
    /*
    UIButton* enterQuestionnaireLanguageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [enterQuestionnaireLanguageButton addTarget:self action:@selector(chooseOrSelectLanguage) forControlEvents:UIControlEventTouchUpInside];
    [enterQuestionnaireLanguageButton setTitle:@"CREATE LANGUAGE" forState:UIControlStateNormal];
    enterQuestionnaireLanguageButton.backgroundColor = [UIColor orangeColor];
    enterQuestionnaireLanguageButton.frame = frame1InScrollViewRect;
    [scrollView addSubview:enterQuestionnaireLanguageButton];
    */
    
    
    // enter name
    enterQuestionnaireNameField = [[UITextField alloc] initWithFrame:frame2InScrollViewRect];
    enterQuestionnaireNameField.delegate = self;
    enterQuestionnaireNameField.tag = 0;
    enterQuestionnaireNameField.backgroundColor = [UIColor orangeColor];
    enterQuestionnaireNameField.placeholder = @"  Enter survey name here";
    [scrollView addSubview:enterQuestionnaireNameField];
    
    // field to enter question
    
    enterQuestionnaireTopicField = [[UITextField alloc] initWithFrame:frame3InScrollViewRect];
    enterQuestionnaireTopicField.delegate = self;
    enterQuestionnaireTopicField.tag = 0;
    enterQuestionnaireTopicField.backgroundColor = [UIColor orangeColor];
    enterQuestionnaireTopicField.placeholder = @"  Enter survey topic here";
    [scrollView addSubview:enterQuestionnaireTopicField];
    
    
    // create question button
    UIButton* createQuestionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [createQuestionButton addTarget:self action:@selector(createQuestion) forControlEvents:UIControlEventTouchUpInside];
    [createQuestionButton setTitle:@"CREATE SURVEY" forState:UIControlStateNormal];
    createQuestionButton.backgroundColor = [UIColor orangeColor];
    createQuestionButton.frame = frame1InScrollViewRect;
    [scrollView addSubview:createQuestionButton];
    

}

- (void)createQuestion
{
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    
    NSString* name = enterQuestionnaireNameField.text;
    NSString* topic = enterQuestionnaireTopicField.text;
    
    NSLog(@"name = %@\ntopic = %@", name, topic);
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    
    if (enterQuestionnaireNameField.text.length == 0 || enterQuestionnaireTopicField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"please enter survey name and topic to continue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    
    NSArray* keys = @[@"survey name", @"survey topic"];
    
    
    
    NSArray* objects = @[enterQuestionnaireNameField.text, enterQuestionnaireTopicField.text];
    
    NSLog(@"objects = %@", objects);
    
    
    NSDictionary* surveyInMaking = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    // if survey name and topic, then
    SingleQuestionCreateViewController* createQuestionViewController = [[SingleQuestionCreateViewController alloc] init];
    createQuestionViewController.delegate = (id)self;
    createQuestionViewController.surveyInfo = surveyInMaking;
    [self.navigationController pushViewController:createQuestionViewController animated:YES];
}


#pragma mark chooseOrSelectLanguage
- (void)chooseOrSelectLanguage
{
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - MAKE QUESTIONS DELEGATE
- (void)updateQuestionsArray:(NSDictionary *)question
{
    [self.arrayQuestions addObject:question];
}

@end
