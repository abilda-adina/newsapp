//
//  APIClient.m
//  Some News App
//
//  Created by Adina Abilda on 23.09.17.
//  Copyright © 2017 Kenzhebekova. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

NSString* const CONST_HOST_ADDRESS = @"https://newsapi.org/";
NSString* const CONST_API_KEY = @"5010cf3d378d4ba8ac524d3bc71c8d32";

+ (instancetype) sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:CONST_HOST_ADDRESS]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end
