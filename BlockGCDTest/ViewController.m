//
//  ViewController.m
//  BlockGCDTest
//
//  Created by Todd Marshall on 2/10/12.
//  Copyright (c) 2012 SunGard Global Services. All rights reserved.
//

#import "ViewController.h"
#import <dispatch/dispatch.h>

@interface ViewController(Private)
- (void) validateUrlField:(NSString *) urlString;
@end

@implementation ViewController
@synthesize loadButton, urlTextField, textView, spinner;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.loadButton setEnabled:NO];
    [self.urlTextField setDelegate:self];
    
    dataConnector = [[DataConnector alloc] init];
    validator = [[Validator alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        return YES;
    }
    else
    {
        return NO;
    }
}

// regular expression for checking to see if a url is potentially valid


#pragma mark datasource
- (IBAction) loadUrl {

    // start the load 
    [self.loadButton setEnabled:NO];
    [self.spinner startAnimating];
    
    // dataConnector call using blocks.  I like the way it keeps all of the code in the same place instead of spreading it accross multiple delegate calls
    [dataConnector getContentsOfURLFromString:[self.urlTextField text] 
                                  withSuccessBlock:(DataConnectorSuccessBlock)^(NSString * resultString) {
                                      [self.textView setText:resultString];
                                      [self.spinner stopAnimating];
                                      [self.loadButton setEnabled:YES];
                                      [self.urlTextField setBackgroundColor:[UIColor whiteColor]];
                                  
                                  } 
                                  withFailureBlock:(DataConnectorFailureBlock)^(NSError * error) {
                                      [self.textView setText:[error description]];
                                      [self.spinner stopAnimating];
                                      [self.loadButton setEnabled:NO];
                                      [self.urlTextField setBackgroundColor:[UIColor redColor]];
                                  
                                  }];
        
    
}

- (void) validateUrlField:(NSString *) urlString
{
    // check to see if it's a potentially valid url
    [validator validateUrl:urlString
          withSuccessBlock:(ValidatorSuccessBlock)^{
              [self.loadButton setEnabled:YES];
              [self.urlTextField setBackgroundColor:[UIColor whiteColor]];
          } 
          withFailureBlock:(ValidatorFailureBlock)^{
              [self.loadButton setEnabled:NO];
              [self.urlTextField setBackgroundColor:[UIColor redColor]];
          }];
}

#pragma mark delegates
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    // get the text
    NSString * url = [self.urlTextField text];
    [self validateUrlField:url];
    
    
}
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * url = [self.urlTextField text];
    [self validateUrlField:url];
    return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}



@end
