//
//  SingleQuestionCreateViewController
//  HaitiQuestionnaireJan2014
//
//  Created by Rex Fatahi on 1/13/14.
//  Copyright (c) 2014 Rex Fatahi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateQuestionsArrayProtocol <NSObject>

- (void)updateQuestionsArray:(NSDictionary *)question;

@end

@interface SingleQuestionCreateViewController : UIViewController
@property (strong, nonatomic) id <UpdateQuestionsArrayProtocol> delegate;
@property (strong, nonatomic) NSDictionary* surveyInfo;

@end
