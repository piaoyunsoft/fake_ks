//
//  FKSHttpClient.m
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/8.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import "FKSHttpClient.h"

@implementation FKSHttpClient

+ (id)shareClient {
    static FKSHttpClient *sharedHttpClient = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedHttpClient = [[self alloc] init];
    });
    return sharedHttpClient;
}

- (void)initWithBaseUrl:(NSString *)url {
    _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
}

@end
