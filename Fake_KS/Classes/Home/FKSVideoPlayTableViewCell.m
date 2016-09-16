//
//  FKSVideoPlayTableViewCell.m
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/16.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import "FKSVideoPlayTableViewCell.h"
#import "FKSFeedModel.h"
#import "NSDate+Format.h"

@interface FKSVideoPlayTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *playTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation FKSVideoPlayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellModel:(FKSFeedModel *)cellModel {
    _playTimesLabel.text = [NSString stringWithFormat:@"%01fw 播放", cellModel.view_count.integerValue/10000.0];
    _timeLabel.text = [NSString stringWithFormat:@"%@", [NSDate timeFromNow:cellModel.timestamp.integerValue/1000]];
}

@end
