//
//  News.m
//  Some News App
//
//  Created by Adina Abilda on 23.09.17.
//  Copyright © 2017 Kenzhebekova. All rights reserved.
//

#import "Article.h"
#import "APIClient.h"

@implementation Article

- (NSDate *) parsePublishedAtFromString:(NSString *)string {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    return [dateFormat dateFromString:string];
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.author = [attributes valueForKeyPath:@"author"];
    self.title = [attributes valueForKeyPath:@"title"];
    self.body = [attributes valueForKeyPath:@"description"];
    self.url = [attributes valueForKeyPath:@"url"];
    self.imageUrl = [attributes valueForKeyPath:@"urlToImage"];
    self.publishedAt = [self parsePublishedAtFromString:[attributes valueForKeyPath:@"publishedAt"]];
    
    return self;
}

+ (NSURLSessionDataTask *)fetchLatestWithBlock:(void (^)(NSArray *articles, NSError *error))block {
    NSDictionary *parameters = @{
        @"source": @"al-jazeera-english",
        @"sortBy": @"latest",
        @"apiKey": CONST_API_KEY
    };
    
    return [[APIClient sharedClient] GET:@"v1/articles/" parameters:parameters progress:nil success:^(NSURLSessionDataTask * __unused task, id response) {
        if ([[response valueForKeyPath:@"status"] isEqualToString:@"ok"]) {
            NSArray *articles = [response valueForKeyPath:@"articles"];
            NSMutableArray *result = [NSMutableArray arrayWithCapacity:[articles count]];

            for (NSDictionary *attributes in articles) {
                Article *article = [[Article alloc] initWithAttributes:attributes];
                [result addObject:article];
            }
        
            if (block) {
                block([NSArray arrayWithArray:result], nil);
            }
        } else {
            NSDictionary *userInfo = @{
                @"code": [response valueForKeyPath:@"code"],
                @"message": [response valueForKeyPath:@"message"]
            };

            block([NSArray array], [NSError errorWithDomain:[NSURLErrorDomain init] code:1 userInfo:userInfo]);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

@end
