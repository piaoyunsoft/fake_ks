//
//  FKSHomeViewController.m
//  Fake_KS
//
//  Created by zhang yuanan on 16/8/30.
//  Copyright © 2016年 xiaobu network. All rights reserved.
//

#import <MJExtension.h>

#import "FKSHomeViewController.h"
#import "FKSHomeCollectionViewCell.h"
#import "FKSVideoDetailViewController.h"
#import "FKSFeedModel.h"
#import "FKSHttpClient.h"
#import "FKSParameters.h"

#import "CHTCollectionViewWaterfallLayout.h"

@interface FKSHomeViewController () <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *feedlist;
@property (strong, nonatomic) FKSHttpClient *httpClient;
@property (nonatomic) NSInteger currentIndex;

@end

@implementation FKSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //[FKSFeedModel setupReplacement];

    CHTCollectionViewWaterfallLayout *layout = (CHTCollectionViewWaterfallLayout *)_collectionView.collectionViewLayout;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.headerHeight = 15;
    layout.footerHeight = 10;
    layout.minimumColumnSpacing = 20;
    layout.minimumInteritemSpacing = 30;
    
    _feedlist = [NSMutableArray new];
    _httpClient = [FKSHttpClient shareClient];
    [_httpClient initWithBaseUrl:BASE_URL];
    [_httpClient.sessionManager.requestSerializer setValue:@"kwai-ios" forHTTPHeaderField:@"User-Agent"];
    [_httpClient.sessionManager.requestSerializer setValue:@"zh-Hans;q=1, en;q=0.9, fr;q=0.8, de;q=0.7, ja;q=0.6, nl;q=0.5" forHTTPHeaderField:@"Accept-Language"];
    
    [self _downloadFeedlist];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _feedlist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"homeCell";
    FKSHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *dict = _feedlist[indexPath.row];
    cell.cellModel = [FKSFeedModel mj_objectWithKeyValues:dict];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _currentIndex = indexPath.row;
    [self performSegueWithIdentifier:@"video" sender:self];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(160, 160);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FKSVideoDetailViewController *vc = segue.destinationViewController;
    NSDictionary *dict = _feedlist[_currentIndex];
    vc.feedModel = [FKSFeedModel mj_objectWithKeyValues:dict];
}

#pragma mark -- private methods

- (void)_downloadFeedlist {
    NSDictionary *requestDict = [FKSParameters getRequestParameters];
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithDictionary:[FKSParameters getFeedListParameters]];
    bodyDict[@"id"] = @"68";
    bodyDict[@"last"] = @"149164";
    bodyDict[@"page"] = @"1";
    bodyDict[@"sig"] = [FKSParameters getSig:requestDict withBodyDict:bodyDict];
    
    NSString *request = [NSString stringWithFormat:@"/rest/n/feed/list?%@",
                         [FKSParameters getFeedListRequest:requestDict]];
    NSString *encodedRequest = [request stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    __weak __typeof(self) wself = self;
    [_httpClient.sessionManager POST:encodedRequest parameters:bodyDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [wself.feedlist addObjectsFromArray:responseObject[@"feeds"]];
        [wself.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLogError(@"can't download feed list!");
    }];
}


@end
