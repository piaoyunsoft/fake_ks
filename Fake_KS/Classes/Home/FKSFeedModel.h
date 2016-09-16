//
//  FKSFeedModel.h
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/12.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKSFeedModel : NSObject

@property (retain, nonatomic) NSNumber *timestamp;

//@property(retain, nonatomic) KSPoi *poi;
@property(nonatomic) BOOL fansTop;
@property(retain, nonatomic) NSNumber *show_count;
@property(retain, nonatomic) NSNumber *tagTop;
@property(retain, nonatomic) NSArray *tags; 
@property(retain, nonatomic) NSString *display_reco_reason;
@property(retain, nonatomic) NSNumber *hasMagicFaceTag;
//@property(retain, nonatomic) KSMagicFace *magicFace;
@property(retain, nonatomic) NSNumber *hasMusicTag;
//@property(retain, nonatomic) KSMusicItem *music;
@property(retain, nonatomic) NSNumber *tag_hash_type;
@property(retain, nonatomic) NSArray *main_urls;
@property(retain, nonatomic) NSString *main_url;
@property(retain, nonatomic) NSArray *cover_urls;
@property(retain, nonatomic) NSArray *cover_thumbnail_urls;
@property(retain, nonatomic) NSArray *main_mv_urls_h265;
@property(retain, nonatomic) NSArray *main_mv_urls;
@property(retain, nonatomic) NSString *main_mv_url;
@property(nonatomic) BOOL showLikersName;
@property(retain, nonatomic) NSNumber *view_count;
@property(retain, nonatomic) NSString *user_sex;
@property(retain, nonatomic) NSString *user_name;
@property(nonatomic) BOOL privacy;
@property(retain, nonatomic) NSNumber *user_id;
@property(retain, nonatomic) NSNumber *unlike_count;
@property(retain, nonatomic) NSNumber *like_count;
@property(retain, nonatomic) NSNumber *photo_status;
@property(retain, nonatomic) NSNumber *photo_id;
@property(retain, nonatomic) NSMutableArray *likers;
@property(retain, nonatomic) NSNumber *liked;
@property(retain, nonatomic) NSMutableArray *headurls;
@property(retain, nonatomic) NSString *headurl;
@property(retain, nonatomic) NSNumber *forward_count;
@property(nonatomic) BOOL followRequesting;
@property(retain, nonatomic) NSNumber *following;
@property(retain, nonatomic) NSMutableArray *comments;
@property(retain, nonatomic) NSNumber *comment_count;
//@property(retain, nonatomic) NSString *baidu_thumbnail_url_time;
//@property(retain, nonatomic) NSString *baidu_thumbnail_url;
//@property(retain, nonatomic) NSString *baidu_mv_url_time;
//@property(retain, nonatomic) NSString *baidu_mv_url;
@property(retain, nonatomic) NSNumber *us_m;
@property(retain, nonatomic) NSNumber *us_c;
@property(retain, nonatomic) NSNumber *us_d;

//+ (void)setupReplacement;

@end
