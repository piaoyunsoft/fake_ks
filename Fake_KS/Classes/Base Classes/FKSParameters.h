//
//  FKSParameters.h
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/12.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKSParameters : NSObject

+ (NSDictionary *)getAllParameters;
+ (NSString *)getSig:(NSDictionary *)dict;
+ (NSString *)getString:(NSDictionary *)dict connector:(NSString *)connector;
+ (NSDictionary *)getRequestParameters;
+ (NSDictionary *)getCommentRequestParameters;
+ (NSString *)getFeedListRequest:(NSDictionary *)dict;
+ (NSDictionary *)getFeedListParameters;
+ (NSDictionary *)getCommentListParameters;
+ (NSString *)getSig:(NSDictionary *)requestDict withBodyDict:(NSDictionary *)bodyDict;

@end
