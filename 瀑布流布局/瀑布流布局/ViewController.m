//
//  ViewController.m
//  瀑布流布局
//
//  Created by 郝庆 on 16/6/23.
//  Copyright © 2016年 haoqing. All rights reserved.
//

#import "ViewController.h"
#import "LZWaterflowLayout.h"
#import "LZShopCell.h"
#import "LZShop.h"
#import "MJRefresh.h"
#import "MJExtension.h"

@interface ViewController ()<UICollectionViewDataSource,LZWaterflowLayoutDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray *shops;
@end

@implementation ViewController

static NSString * const LZShopId = @"shop";

#pragma mark - 懒加载
- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建流水布局
    [self setUpLayout];
    
    // 加载数据
    [self setUpRefresh];
}

#pragma mark - 创建流水布局
- (void)setUpLayout
{
    // 创建布局
    LZWaterflowLayout *layout = [[LZWaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LZShopCell class]) bundle:nil] forCellWithReuseIdentifier:LZShopId];
    self.collectionView = collectionView;
}

#pragma mark - 加载数据
- (void)setUpRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.mj_footer.hidden = YES;
}

- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [LZShop mj_objectArrayWithFilename:@"shop.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.mj_header endRefreshing];
    });
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [LZShop mj_objectArrayWithFilename:@"shop.plist"];
        [self.shops addObjectsFromArray:shops];
        
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.mj_footer endRefreshing];
    });
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.mj_footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LZShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LZShopId forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}

#pragma mark - <XMGWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(LZWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    LZShop *shop = self.shops[index];
    return  itemWidth * shop.h / shop.w;
}

- (CGFloat)rowMarginInWaterflowLayout:(LZWaterflowLayout *)waterflowLayout
{
    return 10;
}

- (CGFloat)columnCountInWaterflowLayout:(LZWaterflowLayout *)waterflowLayout
{
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(LZWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
