//
//  FKSVideoDetailViewController.m
//  Fake_KS
//
//  Created by zhang yuanan on 16/8/30.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import <MJExtension.h>

#import "FKSVideoDetailViewController.h"
#import "FKSDetailHeadToolbar.h"
#import "FKSDetailFootToolbar.h"
#import "FKSVideoPlayTableViewCell.h"
#import "FKSVideoDetailTableViewCell.h"
#import "FKSCommentTableViewCell.h"
#import "FKSCommentModel.h"
#import "FKSFeedModel.h"
#import "FKSHttpClient.h"
#import "FKSParameters.h"

@interface FKSVideoDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet FKSDetailHeadToolbar *headToolbar;
@property (weak, nonatomic) IBOutlet FKSDetailFootToolbar *footToolbar;

@property (strong, nonatomic) FKSHttpClient *httpClient;
@property (strong, nonatomic) NSMutableArray *commentList;

@end

@implementation FKSVideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _httpClient = [FKSHttpClient shareClient];
    _commentList = [NSMutableArray new];
    [self _downloadComments];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section==0) ? 2 : _commentList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return (indexPath.row==0) ? 180.0 : 85.0;
    }
    return 65.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            FKSVideoPlayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoPlay" forIndexPath:indexPath];
            cell.cellModel = _feedModel;
            return cell;
        } else {
            FKSVideoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoDetail" forIndexPath:indexPath];
            cell.cellModel = _feedModel;
            return cell;
        }
    } else {
        FKSCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];
        FKSCommentModel *commentModel = [FKSCommentModel mj_objectWithKeyValues:_commentList[indexPath.row]];
        cell.cellModel = commentModel;
        return cell;
    }
}

#pragma mark - Private Methods

- (void)_downloadComments {
    NSDictionary *requestDict = [FKSParameters getCommentRequestParameters];
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithDictionary:[FKSParameters getCommentListParameters]];
    bodyDict[@"order"] = @"desc";
    bodyDict[@"photo_id"] = [_feedModel.photo_id stringValue];
    bodyDict[@"sig"] = [FKSParameters getSig:requestDict withBodyDict:bodyDict];
    
    NSString *request = [NSString stringWithFormat:@"/rest/photo/comment/list?%@",
                         [FKSParameters getFeedListRequest:requestDict]];
    NSString *encodedRequest = [request stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    __weak __typeof(self) wself = self;
    [_httpClient.sessionManager POST:encodedRequest parameters:bodyDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [wself.commentList addObjectsFromArray:responseObject[@"comments"]];
        [wself.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLogError(@"can't download feed list!");
    }];
}

@end
