//
//  RegistrationViewController.m
//  HollerBeacon
//
//  Created by Natasha Murashev on 11/9/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "RegistrationViewController.h"
#import "CheckInViewController.h"

NSString * const kSegueIdentifierToCheckIn = @"toCheckIn";

@interface RegistrationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) PFObject *attendee;

@end

@implementation RegistrationViewController

#pragma mark - Actions

- (IBAction)onRegisterTap:(id)sender
{
    [self registerAttendee];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CheckInViewController *checkInViewController = segue.destinationViewController;
    checkInViewController.attendee = self.attendee;
}

#pragma mark - Private Methods

- (void)registerAttendee
{
    PFObject *attendee = [PFObject objectWithClassName:sParseClassAttendee];
    attendee[sParseClassAttendeeKeyFirstName] = self.firstNameTextField.text;
    attendee[sParseClassAttendeeKeyLastName] = self.lastNameTextField.text;
    attendee[sParseClassAttendeeKeyEmail] = self.emailTextField.text;
    attendee[sParseClassAttendeeKeyCompany] = self.companyTextField.text;
    attendee[sParseClassAttendeeKeyCheckedIn] = @NO;
    
    [self.activityIndicator startAnimating];
    __weak RegistrationViewController *weakSelf = self;
    [attendee saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [weakSelf.activityIndicator stopAnimating];
            weakSelf.attendee = attendee;
            [weakSelf performSegueWithIdentifier:kSegueIdentifierToCheckIn sender:weakSelf];
        }
    }];
}

@end
