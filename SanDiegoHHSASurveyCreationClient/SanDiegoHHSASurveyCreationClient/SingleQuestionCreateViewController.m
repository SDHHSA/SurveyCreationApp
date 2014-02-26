//
//  SingleQuestionCreateViewController
//  HaitiQuestionnaireJan2014
//
//  Created by Rex Fatahi on 1/13/14.
//  Copyright (c) 2014 Rex Fatahi. All rights reserved.
//

#import "SingleQuestionCreateViewController.h"

@interface SingleQuestionCreateViewController () <UITextFieldDelegate>
{
    UIScrollView* scrollView;
    NSInteger scrollViewContentSizeHeight;
    UIButton* addMoreQuestionButton;
    UIButton* createQuestionButton;
    UIButton* exitButton;
    
    // ivar for question data model to pass to questionnair vc
    NSDictionary* theQuestion;
    
    NSMutableArray* questionsCreatedArray;
    
    
    // alert view ivar
    UIAlertView* submitAlert;
    UIAlertView* confirmAlert;
}

@end

@implementation SingleQuestionCreateViewController

#pragma mark - ChooseOrCreateLanguage
- (void)chooseOrSelectLanguage
{
    NSLog(@"chooseOrSelectLanguage");
    // display tableView of language options
    
    // bottom row should be button to add language to the list being displayed
}

- (void)loadView
{
    [super loadView];
    
    questionsCreatedArray = [NSMutableArray array];
    
    CGFloat heightFactorOffset = 44.0f;
    CGRect scrollViewRect = CGRectMake(0, heightFactorOffset, self.view.bounds.size.width, self.view.bounds.size.height - heightFactorOffset);
    scrollView = [[UIScrollView alloc] initWithFrame:scrollViewRect];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    // display selected language, option to add language
    
    // if no language, fields are not editable
    
    
    //    UIButton* chooseOrCreateLanguageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    [chooseOrCreateLanguageButton addTarget:self action:@selector(chooseOrSelectLanguage) forControlEvents:UIControlEventTouchUpInside];
    //    [chooseOrCreateLanguageButton setTitle:@"CREATE LANGUAGE" forState:UIControlStateNormal];
    //    chooseOrCreateLanguageButton.backgroundColor = [UIColor orangeColor];
    //    chooseOrCreateLanguageButton.frame = chooseOrCreateButtonRect;
    //    [scrollView addSubview:chooseOrCreateLanguageButton];
    
    
    // rects ordered top down
    CGRect createQuestionRect = CGRectMake(10, 0, 150, 44);
    CGRect frame1InScrollViewRect = CGRectMake(10, 10, self.view.bounds.size.width - 20, 44);
    CGRect frame2InScrollViewRect = CGRectMake(10, 64, self.view.bounds.size.width - 20, 44);
    CGRect frame3InScrollViewRect = CGRectMake(10, 108, self.view.bounds.size.width - 20, 44);
    CGRect frame4InScrollViewRect = CGRectMake(10, 282, 300, 44);
    
    
    // field to enter question
    
    UITextField* enterQuestionHereTextField = [[UITextField alloc] initWithFrame:frame1InScrollViewRect];
    enterQuestionHereTextField.delegate = self;
    enterQuestionHereTextField.tag = 99;
    enterQuestionHereTextField.backgroundColor = [UIColor orangeColor];
    enterQuestionHereTextField.placeholder = @"  Enter question here";
    [scrollView addSubview:enterQuestionHereTextField];
    
    
    // isQuestionMC label
    UILabel* isQuestionMCLabel = [[UILabel alloc] initWithFrame:frame2InScrollViewRect];
    isQuestionMCLabel.text = @"Is question multiple choice?";
    [scrollView addSubview:isQuestionMCLabel];
    
    
    // isQuestionMC segment
    
    NSArray* items = @[@"YES", @"NO"];
    UISegmentedControl* isQuestionMCSegmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    isQuestionMCSegmentedControl.frame = frame3InScrollViewRect;
    isQuestionMCSegmentedControl.selectedSegmentIndex = 1;
    [scrollView addSubview:isQuestionMCSegmentedControl];
    
    
    
    // Enter answers in to (2) fields
    CGRect answerOneRect, answerTwoRect;
    
    answerOneRect = CGRectMake(10, 172, 300, 44);
    answerTwoRect = CGRectMake(10, 228, 300, 44);
    
    UITextField* answerOneTextField = [[UITextField alloc] initWithFrame:answerOneRect];
    answerOneTextField.delegate = self;
    answerOneTextField.placeholder = @" Enter answer option here";
    answerOneTextField.backgroundColor = [UIColor orangeColor];
    [scrollView addSubview:answerOneTextField];
    
    UITextField* answerTwoTextField = [[UITextField alloc] initWithFrame:answerTwoRect];
    answerTwoTextField.delegate = self;
    answerTwoTextField.placeholder = @" Enter answer option here";
    answerTwoTextField.backgroundColor = [UIColor orangeColor];
    [scrollView addSubview:answerTwoTextField];
    
    
    // option to add more answers
    
    addMoreQuestionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addMoreQuestionButton.frame = frame4InScrollViewRect;
    addMoreQuestionButton.backgroundColor = [UIColor blueColor];
    [addMoreQuestionButton setTitle:@"Add Question" forState:UIControlStateNormal];
    [addMoreQuestionButton addTarget:self action:@selector(addMoreQuestion) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addMoreQuestionButton];
    
    
    
    // add button to create question, add to set
    
    createQuestionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    createQuestionButton.frame = createQuestionRect;
    [createQuestionButton setTitle:@"Create Question" forState:UIControlStateNormal];
    [createQuestionButton addTarget:self action:@selector(createQuestion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createQuestionButton];
    
    UIButton* finishSurveyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishSurveyButton.frame = CGRectMake(160, 3, self.view.bounds.size.width - 160, 34);
    finishSurveyButton.backgroundColor = [UIColor clearColor];
    [finishSurveyButton setTitle:@"FINISH & SEND" forState:UIControlStateNormal];
    [finishSurveyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [finishSurveyButton addTarget:self action:@selector(createSurveyInComplete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishSurveyButton];
    
    scrollViewContentSizeHeight = 336;
}

- (void)createSurveyInComplete
{
    
    //[self createQuestion];
    
    NSDate* dateNow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/dd/MM hh:mm:ss"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"PST"]];
    
    NSString *stringFromDate = [formatter stringFromDate:dateNow];
    NSDictionary* raw = @{@"date":stringFromDate, @"content":questionsCreatedArray, @"info":self.surveyInfo};
    NSData* dataToPost = [NSJSONSerialization dataWithJSONObject:raw options:0 error:nil];
    
    NSString* urlString = @"http://127.0.0.1:1230/surveyadd";
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:dataToPost];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"connectionError = %@", connectionError);
        }
        
        NSString* responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"responseString = %@", responseString);
    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}

- (void)createQuestion
{
    
    // find question textField
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    NSMutableArray* arrayOptionsAnswers = [NSMutableArray array]; int counter = 0; NSString* q; NSString* isMC;
    for (UIView* aView in scrollView.subviews) {
        NSLog(@"view = %@", aView);
        NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
        if ([aView isKindOfClass:[UITextField class]]) {
            counter++;
            NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
            UITextField* tf = (UITextField *)aView;
            if (tf.tag == 99) {
                // question field (there is one question)
                q = tf.text;
                
                if (q.length == 0) {
                    NSLog(@"q = %@", q);
                    [[[UIAlertView alloc] initWithTitle:@"You must enter question" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    return;
                }
                
                continue;
                
            } else {
                
                NSString* answer = tf.text;
                NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
                NSLog(@"question = %@", answer);
                if (answer.length > 0) {
                    [arrayOptionsAnswers addObject:answer];
                }
                
            }
            
        }
        
        if ([aView isKindOfClass:[UISegmentedControl class]]) {
            UISegmentedControl* controlInstance = (UISegmentedControl *)aView;
            isMC = [controlInstance titleForSegmentAtIndex:controlInstance.selectedSegmentIndex];
        }
        
    }
    
    if (arrayOptionsAnswers.count == 0) {
        NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
        [[[UIAlertView alloc] initWithTitle:@"You must enter answers" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    
    // cut question string to set length of 20 chars
    // define the range you're interested in
    NSRange stringRange = {0, MIN([q length], 20)};
    
    // adjust the range to include dependent chars
    stringRange = [q rangeOfComposedCharacterSequencesForRange:stringRange];
    
    // Now you can create the short string
    NSString *shortString = [q substringWithRange:stringRange];
    
    
    
    NSArray* keys = @[@"question", @"answers", @"isMC"];
    NSArray* objects = @[q, arrayOptionsAnswers, isMC];
    NSDictionary* questionDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    theQuestion = [NSDictionary dictionaryWithDictionary:questionDictionary];
    
    NSLog(@"questionDictionary = %@", questionDictionary);
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    
    
    [questionsCreatedArray addObject:questionDictionary];
    
    
    NSLog(@"questions nsset = %@", questionsCreatedArray);
    NSLog(@"counter count = %i", counter);
    
    
    
    
    
    NSString* questionAlertString = [NSString stringWithFormat:@"Question: %@\n%i answers options", shortString, counter - 1];
    
    confirmAlert = [[UIAlertView alloc] initWithTitle:@"Please Confirm" message:questionAlertString delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create", nil];
    [confirmAlert show];
    
    [arrayOptionsAnswers removeAllObjects];
    
    
}

#pragma mark - add more question
- (void)addMoreQuestion
{
    CGRect oldButtonRect = addMoreQuestionButton.frame;
    CGRect newButtonRect = CGRectMake(10, scrollViewContentSizeHeight, 300, 44);
    UITextField* addQuestionTextField = [[UITextField alloc] initWithFrame:oldButtonRect];
    addQuestionTextField.placeholder = @" Enter answer option here";
    addQuestionTextField.backgroundColor = [UIColor orangeColor];
    addQuestionTextField.delegate = self;
    [scrollView addSubview:addQuestionTextField];
    
    addMoreQuestionButton.frame = newButtonRect;
    
    scrollViewContentSizeHeight += 54;
    [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, scrollViewContentSizeHeight)];
}

#pragma mark - TEXTFIELD DELEGATE
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - ALERT DELEGATE
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == submitAlert) {
        if (buttonIndex == 1) {
            NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
            return;
        }

        
        NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    }
    
    if (alertView == confirmAlert) {
        if (buttonIndex == 1) {
            NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
            [self.delegate updateQuestionsArray:theQuestion];
            [self clearContent];
            return;
        }
        
        NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    }
}

#pragma mark - CLEAR VIEW/NEW QUESTION
- (void)clearContent
{
    theQuestion = nil;
    for (UIView* aView in scrollView.subviews) {
        
        if ([aView isKindOfClass:[UITextField class]]) {
            NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
            UITextField* tf = (UITextField *)aView;
            
            tf.text = nil;
            
        }
        
        if ([aView isKindOfClass:[UISegmentedControl class]]) {
            UISegmentedControl* controlInstance = (UISegmentedControl *)aView;
            controlInstance.selectedSegmentIndex = 1;
        }
        
    }
}

@end
