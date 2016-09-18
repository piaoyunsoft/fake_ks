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
#import "FKSConstants.h"

#import "ZWCollectionViewFlowLayout.h"

@interface FKSHomeViewController () <UICollectionViewDataSource, ZWwaterFlowDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *feedlist;
@property (strong, nonatomic) FKSHttpClient *httpClient;
@property (nonatomic) NSInteger currentIndex;

@end

@implementation FKSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //[FKSFeedModel setupReplacement];
    ZWCollectionViewFlowLayout *layout = (ZWCollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    layout.colMagrin = 10;
    layout.rowMagrin = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.colCount = 2;
    layout.degelate = self;
    
    _feedlist = [NSMutableArray new];
    _httpClient = [FKSHttpClient shareClient];
    [_httpClient initWithBaseUrl:kFKSBaseURL];
    [_httpClient.sessionManager.requestSerializer setValue:kFKSUserAgent forHTTPHeaderField:@"User-Agent"];
    [_httpClient.sessionManager.requestSerializer setValue:kFKSAcceptLanguage forHTTPHeaderField:@"Accept-Language"];
    
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

- (CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach {
    return width*4/3;
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
