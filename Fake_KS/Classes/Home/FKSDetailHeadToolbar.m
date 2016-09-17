//
//  FKSDetailHeadToolbar.m
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/16.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import "FKSDetailHeadToolbar.h"

@interface FKSDetailHeadToolbar ()
- (IBAction)backButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation FKSDetailHeadToolbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)backButtonPressed:(id)sender {
    [_delegate headBackPressed];
}
@end
