//
//  UncaughtExceptionHandler.h
//  AssetScan
//
//  Created by Kenneth Allan on 24/11/2015.
//  Copyright © 2015 Norganna's AddOns Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

void exceptionHandler(NSException *exception);
extern NSUncaughtExceptionHandler *exceptionHandlerPtr;

@interface UncaughtExceptionHandler : NSObject
+ (void)registerHandler;
@end
