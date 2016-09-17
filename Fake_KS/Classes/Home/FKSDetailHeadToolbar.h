//
//  FKSDetailHeadToolbar.h
//  Fake_KS
//
//  Created by zhang yuanan on 16/9/16.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FKSDetailHeadDelegate <NSObject>

- (void)headBackPressed;

@end

@interface FKSDetailHeadToolbar : UIView

@property (weak, nonatomic) id<FKSDetailHeadDelegate> delegate;

@end
