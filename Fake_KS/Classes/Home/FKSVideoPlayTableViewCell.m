//
//  FKSVideoPlayTableViewCell.m
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/16.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import <IJKMediaFramework/IJKMediaFramework.h>

#import "FKSVideoPlayTableViewCell.h"
#import "FKSFeedModel.h"
#import "NSDate+Format.h"

@interface FKSVideoPlayTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *playTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IJKFFMoviePlayerController *player;

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
    NSString *movieUrl = cellModel.main_mv_urls[0][@"url"];
    if (!_player) {
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:movieUrl] withOptions:options];
        _player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _player.view.frame = _videoView.bounds;
        _player.scalingMode = IJKMPMovieScalingModeAspectFill;
        _player.shouldAutoplay = YES;
        [_videoView addSubview:_player.view];
        
        [_player prepareToPlay];
        [_player play];
    }
    _playTimesLabel.text = [NSString stringWithFormat:@"%.01fw 播放", cellModel.view_count.integerValue/10000.0];
    _timeLabel.text = [NSString stringWithFormat:@"%@", [NSDate timeFromNow:cellModel.timestamp.integerValue/1000]];
}

- (void)dealloc {
    if (_player) {
        [_player shutdown];
    }
}

@end
