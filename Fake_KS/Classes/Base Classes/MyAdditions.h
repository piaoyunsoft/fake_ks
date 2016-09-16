//
//  MyAdditions.h
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/12.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MyAdditions)
- (NSString *)md5;
@end

@interface NSData (MyAdditions)
- (NSString*)md5;
@end
