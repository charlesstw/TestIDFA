//
//  TADIdfaCreator.m
//  TWM TAMedia Ads SDK
//
//  Created by Charles on 2020/7/27.
//  Copyright © 2020 TaiwanMobile. All rights reserved.
//

#import "TADIdfaHandler.h"
#import <AdSupport/ASIdentifierManager.h>
#import <UIKit/UIKit.h>

@implementation TADIdfaHandler

- (NSString *)getIDFV {
    NSString *idfv = [UIDevice currentDevice].identifierForVendor.UUIDString;
    if (idfv) {
        return idfv;
    }
    return @"";
}

- (NSString *)getIDFA {
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if ([self isValid:idfa]) {
        return idfa;
    }
    return @"";
}

- (BOOL)getIsAllowTracking {
    if ([[self getIDFA] isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (BOOL)isValid:(NSString *)idfa {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:idfa];
    if (uuid && ![idfa isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
        return YES;
    }
    return NO;
}

@end
