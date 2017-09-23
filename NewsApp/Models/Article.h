//
//  News.h
//  Some News App
//
//  Created by Adina Abilda on 23.09.17.
//  Copyright © 2017 Kenzhebekova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Article : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSDate *publishedAt;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (NSURLSessionDataTask *)fetchLatestWithBlock:(void (^)(NSArray *posts, NSError *error))block;

@end
