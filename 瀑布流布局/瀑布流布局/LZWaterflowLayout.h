//
//  LZWaterflowLayout.h
//  瀑布流布局
//
//  Created by 郝庆 on 16/6/23.
//  Copyright © 2016年 haoqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZWaterflowLayout;

@protocol LZWaterflowLayoutDelegate <NSObject>
@required
/** 设置每个格子的高度 */
- (CGFloat)waterflowLayout:(LZWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;
@optional
/** 设置列数 */
- (CGFloat)columnCountInWaterflowLayout:(LZWaterflowLayout *)waterflowLayout;
/** 设置每一列之间的间距 */
- (CGFloat)columnMarginInWaterflowLayout:(LZWaterflowLayout *)waterflowLayout;
/** 设置每一行之间的间距 */
- (CGFloat)rowMarginInWaterflowLayout:(LZWaterflowLayout *)waterflowLayout;
/** 设置边缘间距 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(LZWaterflowLayout *)waterflowLayout;
@end

@interface LZWaterflowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<LZWaterflowLayoutDelegate> delegate;
@end
