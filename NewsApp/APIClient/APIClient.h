//
//  APIClient.h
//  Some News App
//
//  Created by Adina Abilda on 23.09.17.
//  Copyright © 2017 Kenzhebekova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface APIClient : AFHTTPSessionManager

extern NSString* const CONST_HOST_ADDRESS;
extern NSString* const CONST_API_KEY;

+ (instancetype)sharedClient;

@end
