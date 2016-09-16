//
//  FKSHttpClient.h
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/8.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#define BASE_URL @"http://api.gifshow.com"

@interface FKSHttpClient : NSObject

+ (id)shareClient;

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

- (void)initWithBaseUrl:(NSString *)url;

@end
