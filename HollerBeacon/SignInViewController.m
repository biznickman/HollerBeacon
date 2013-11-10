//
//  RegistrationViewController.m
//  HollerBeacon
//
//  Created by Natasha Murashev on 11/9/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "SignInViewController.h"
#import "CheckInViewController.h"

NSString * const kSegueIdentifierToCheckIn = @"toCheckIn";

@interface SignInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@property (strong, nonatomic) PFObject *attendee;

@end

@implementation SignInViewController

#pragma mark - Actions

- (IBAction)onSignInTap:(id)sender
{
    [self signInAttendee];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CheckInViewController *checkInViewController = segue.destinationViewController;
    checkInViewController.attendee = self.attendee;
}

#pragma mark - Private Methods

- (void)signInAttendee
{
    self.signInButton.enabled = NO;
    [self.activityIndicator startAnimating];
    __weak SignInViewController *weakSelf = self;
    
    PFQuery *query = [PFQuery queryWithClassName:sParseClassAttendee];
    
    [query whereKey:sParseClassAttendeeKeyEmail equalTo:self.emailTextField.text];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *attendee, NSError *error) {
        [weakSelf.activityIndicator stopAnimating];
        weakSelf.signInButton.enabled = YES;
        if (attendee) {
            weakSelf.attendee = attendee;
            [weakSelf performSegueWithIdentifier:kSegueIdentifierToCheckIn sender:weakSelf];
        }
    }];
}

@end
