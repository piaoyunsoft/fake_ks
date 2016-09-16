//
//  FKSVideoDetailTableViewCell.m
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/16.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import "FKSVideoDetailTableViewCell.h"
#import "FKSFeedModel.h"

@interface FKSVideoDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation FKSVideoDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellModel:(FKSFeedModel *)cellModel {
    _shareLabel.text = cellModel.user_name;
    _likeLabel.text = [NSString stringWithFormat:@"%@喜欢", cellModel.like_count];
    _commentLabel.text = [NSString stringWithFormat:@"%@评论", cellModel.comment_count];
}

@end
