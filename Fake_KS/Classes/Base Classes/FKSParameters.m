//
//  FKSParameters.m
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/12.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import "FKSParameters.h"
#import "MyAdditions.h"

static NSString *salt = @"23caab00356c";

@implementation FKSParameters

+ (NSDictionary *)getAllParameters {
    return @{
             @"type" : @"7",
             @"ctype" : @"1",
             @"mtype" : @"2",
             @"vtype" : @"1",
             @"did" : @"B84C798B-953E-408D-8596-97BF193B979C",
             @"c" : @"a",
             @"ver" : @"4.93",
             @"lon" : @"116.304929578888",
             @"lat" : @"40.06960277858728",
             @"appver" : @"4.93.1.91",
             @"sys" : @"ios7.1.2",
             @"mod" : @"iPhone3,1",
             @"net" : @"中国移动5",
             @"client_key" : @"56c3713c",
             @"country_code" : @"cn",
             @"user_id" : @"56551592",
             @"count" : @"20",
             @"pv"  : @"false",
             @"language" : @"zh-Hans;q=1, en;q=0.9, fr;q=0.8, de;q=0.7, ja;q=0.6, nl;q=0.5"
             };
}

+ (NSString *)getSig:(NSDictionary *)dict {
    NSMutableString *sig = [[NSMutableString alloc] initWithString:[self getString:dict connector:@""]];
    [sig appendString:salt];
    return [[sig md5] copy];
}

+ (NSString *)getString:(NSDictionary *)dict connector:(NSString *)connector {
    NSMutableString *res = [NSMutableString new];
    NSArray *sortedKeys = [dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [sortedKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *value = dict[obj];
        [res appendFormat:@"%@=%@%@", obj, value, connector];
    }];
    [res deleteCharactersInRange:NSMakeRange(res.length-connector.length, connector.length)];
    return [res copy];
}

+ (NSDictionary *)getRequestParameters {
    NSArray *array = @[@"did", @"type", @"c", @"ver", @"lon", @"appver", @"lat", @"sys", @"mod", @"net"];
    return [self _getDictionaryFromArray:array];
}

+ (NSDictionary *)getCommentRequestParameters {
    NSArray *array = @[@"did", @"c", @"ver", @"lon", @"appver", @"lat", @"sys", @"mod", @"net"];
    return [self _getDictionaryFromArray:array];
}

+ (NSString *)getFeedListRequest:(NSDictionary *)dict {
    return [self getString:dict connector:@"&"];
}

+ (NSDictionary *)getFeedListParameters {
    NSArray *array = @[@"client_key", @"count", @"country_code", @"ctype", @"language",
                       @"pv",@"mtype", @"type", @"vtype"];
    return [self _getDictionaryFromArray:array];
}

+ (NSDictionary *)getCommentListParameters {
    NSArray *array = @[@"client_key", @"country_code", @"ctype", @"language",
                       @"user_id"];
    return [self _getDictionaryFromArray:array];
}

+ (NSString *)getSig:(NSDictionary *)requestDict withBodyDict:(NSDictionary *)bodyDict {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:requestDict];
    [dict addEntriesFromDictionary:bodyDict];
    return [FKSParameters getSig:dict];
}

#pragma mark - Private Methods

+ (NSDictionary *)_getDictionaryFromArray:(NSArray *)array {
    NSDictionary *dict = [self getAllParameters];
    NSMutableDictionary *mdict = [NSMutableDictionary new];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        mdict[obj] = dict[obj];
    }];
    return [mdict copy];
}


@end
