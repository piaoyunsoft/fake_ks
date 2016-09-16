//
//  NSDate+Format.m
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/16.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import "NSDate+Format.h"

#define MINUTES 60
#define HOUR (60*MINUTES)
#define DAY (24*HOUR)
#define YEAR (365*DAY)

@implementation NSDate (Format)

+ (NSString *)timeFromNow:(NSInteger)seconds {
    NSString *timeStr = nil;
    NSDate *now = [self new];
    NSInteger timeInterval = [now timeIntervalSince1970] - seconds;
    if (timeInterval>=YEAR) {
        timeStr = [NSString stringWithFormat:@"%ld年前", timeInterval/YEAR];
    } else if (timeInterval>=DAY) {
        timeStr = [NSString stringWithFormat:@"%ld天前", timeInterval/DAY];
    } else if (timeInterval>=HOUR) {
        timeStr = [NSString stringWithFormat:@"%ld小时", timeInterval/HOUR];
    } else {
        timeStr = [NSString stringWithFormat:@"%ld分钟", timeInterval/MINUTES];
    }
    
    return timeStr;
}

@end
