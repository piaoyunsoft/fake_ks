//
//  FKSHomeCollectionViewCell.m
//  Fake_KS
//
//  Created by zhang yuanan on 16/8/30.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>

#import "FKSHomeCollectionViewCell.h"
#import "FKSFeedModel.h"

@interface FKSHomeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIButton *favorButton;
@property (weak, nonatomic) IBOutlet UILabel *favorLabel;

@end

@implementation FKSHomeCollectionViewCell

- (void)setCellModel:(FKSFeedModel *)cellModel {
    self.backgroundColor = [UIColor colorWithRed:0xee/255.0 green:0xee/255.0 blue:0xee/255.0 alpha:1.0];
    NSString *imageUrl = cellModel.cover_thumbnail_urls[0][@"url"];
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"mapFilter1"]];
    NSString *userUrl = cellModel.headurls[0][@"url"];
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:userUrl] placeholderImage:[UIImage imageNamed:@"detail_avatar_secret"]];
    _favorLabel.text = [cellModel.like_count stringValue];
}

@end
