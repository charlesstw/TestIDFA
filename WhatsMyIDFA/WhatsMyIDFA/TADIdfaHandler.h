//
//  TADIdfaCreator.h
//  TWM TAMedia Ads SDK
//
//  Created by Charles on 2020/7/27.
//  Copyright © 2020 TaiwanMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TADIdfaHandler : NSObject

- (NSString *)getIDFV;
- (NSString *)getIDFA;
- (BOOL)getIsAllowTracking;

@end

NS_ASSUME_NONNULL_END
