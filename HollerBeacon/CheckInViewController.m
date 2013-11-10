//
//  CheckInViewController.m
//  HollerBeacon
//
//  Created by Natasha Murashev on 11/9/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//

#import "CheckInViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface CheckInViewController () <CBPeripheralManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

@end

@implementation CheckInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initBeacon];
    
    self.welcomeLabel.text = [NSString stringWithFormat:@"Hello %@! Welcome to the Largest Hackathon on Earth! #LaunchHack", self.attendee[sParseClassAttendeeKeyFirstName]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self transmitBeacon];
}

#pragma mark - iBeacon

- (void)initBeacon {
    if (!self.attendee[sParseClassAttendeeKeyUUID]) {
        self.attendee[sParseClassAttendeeKeyUUID] = [[NSUUID UUID] UUIDString];
        [self.attendee saveInBackground];
    }
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:self.attendee[sParseClassAttendeeKeyUUID]];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                           identifier:[NSString stringWithFormat:@"%@.%@", HOLLER_BEACON_IDENTIFIER, self.attendee[sParseClassAttendeeKeyEmail]]];
}

- (void)transmitBeacon
{
    self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        if (![self.peripheralManager isAdvertising]) {
            [self.peripheralManager startAdvertising:self.beaconPeripheralData];
        }
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        [self.peripheralManager stopAdvertising];
    }
}

@end
