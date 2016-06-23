//
//  LZShopCell.m
//  瀑布流布局
//
//  Created by 郝庆 on 16/6/23.
//  Copyright © 2016年 haoqing. All rights reserved.
//

#import "LZShopCell.h"
#import "LZShop.h"
#import "UIImageView+WebCache.h"

@interface LZShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation LZShopCell

- (void)setShop:(LZShop *)shop
{
    _shop = shop;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    self.priceLabel.text = shop.price;
}

@end
