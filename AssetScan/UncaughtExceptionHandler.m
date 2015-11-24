//
//  UncaughtExceptionHandler.m
//  AssetScan
//
//  Created by Kenneth Allan on 24/11/2015.
//  Copyright © 2015 Norganna's AddOns Pty Ltd. All rights reserved.
//

#import "UncaughtExceptionHandler.h"

@implementation UncaughtExceptionHandler

void exceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
}

NSUncaughtExceptionHandler *exceptionHandlerPtr = &exceptionHandler;

+ (void)registerHandler {

}

@end