//
//  FKSCommentTableViewCell.m
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/16.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>

#import "FKSCommentTableViewCell.h"
#import "FKSCommentModel.h"

#import "NSDate+Format.h"

@interface FKSCommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation FKSCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellModel:(FKSCommentModel *)cellModel {
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.headurl] placeholderImage:[UIImage imageNamed:@"detail_avatar_secret"]];
    _userLabel.text = cellModel.author_name;
    _contentLabel.text = cellModel.content;
    _timeLabel.text = [NSDate timeFromNow:cellModel.timestamp.integerValue/1000];
}

@end
