//
//  FKSCommentModel.h
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/16.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKSCommentModel : NSObject

@property(retain, nonatomic) NSNumber *about_me;
@property(retain, nonatomic) NSString *user_sex;
@property(retain, nonatomic) NSNumber *user_id;
@property(retain, nonatomic) NSNumber *type;
//@property(retain, nonatomic) NSString *timeFromNow;
@property(retain, nonatomic) NSNumber *timestamp;
@property(retain, nonatomic) NSNumber *reply_to;
@property(retain, nonatomic) NSNumber *photo_id;
@property(retain, nonatomic) NSArray *headurls;
@property(retain, nonatomic) NSString *headurl;
@property(retain, nonatomic) NSString *content;
@property(retain, nonatomic) NSNumber *comment_id;
@property(retain, nonatomic) NSString *author_name;
@property(retain, nonatomic) NSNumber *author_id;

@end
