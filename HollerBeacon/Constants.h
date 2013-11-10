//
//  Constants.h
//  HollerBeacon
//
//  Created by Natasha Murashev on 11/9/13.
//  Copyright (c) 2013 NatashaTheRobot. All rights reserved.
//


#pragma mark - iBeacon UUID

static NSString * const HOLLER_BEACON_IDENTIFIER            = @"com.holler.event"; // Add Attendees Email Address

#pragma mark - Parse Setup Keys

static NSString * const PARSE_APPLICATION_ID                = @"KiJUo0YsOa0i3HZcAqmexghkikkbGmJJvUOXdpQL";
static NSString * const PARSE_CLIENT_KEY                    = @"mXHFPgmgsDLjt940mlpnnQAVc5v6DfsX3vDXw0fu";

#pragma mark - Parse Classes

// Attendee

static NSString * const sParseClassAttendee                 = @"Attendee";

static NSString * const sParseClassAttendeeKeyFirstName     = @"firstName";
static NSString * const sParseClassAttendeeKeyLastName      = @"lastName";
static NSString * const sParseClassAttendeeKeyCompany       = @"company";
static NSString * const sParseClassAttendeeKeyEmail         = @"email";
static NSString * const sParseClassAttendeeKeyCheckedIn     = @"checkedIn";
static NSString * const sParseClassAttendeeKeyUUID          = @"attendeeUUID";
