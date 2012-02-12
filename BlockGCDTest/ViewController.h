//
//  ViewController.h
//  BlockGCDTest
//
//  Created by Todd Marshall on 2/10/12.
//  Copyright (c) 2012 SunGard Global Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <dispatch/dispatch.h>
#import "DataConnector.h"
#import "Validator.h"

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    DataConnector * dataConnector;
    Validator * validator;
}

@property (nonatomic, strong) IBOutlet UITextField *urlTextField;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, strong) IBOutlet UIButton *loadButton;


- (IBAction) loadUrl;
@end
