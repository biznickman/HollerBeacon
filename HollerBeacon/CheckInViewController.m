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
    [self transmitBeacon];
    
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome %@!", self.attendee[sParseClassAttendeeKeyFirstName]];
}

- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:HOLLER_BEACON_UUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:self.attendee.objectId];
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
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        [self.peripheralManager stopAdvertising];
    }
}

@end
