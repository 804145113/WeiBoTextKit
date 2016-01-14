//
//  PhotoCollectionView.m
//  微博列表
//
//  Created by GXY on 16/1/14.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import "PhotoCollectionView.h"

@implementation PhotoCollectionView

- (void)setImages_url:(NSArray *)images_url {
    _images_url = images_url;
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _images_url.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    NSDictionary *imagDic = [self.images_url objectAtIndex:indexPath.row];
    NSString *imageUrl = [imagDic objectForKey:@"thumbnail_pic"];
    cell.photoImage.contentMode = UIViewContentModeScaleAspectFit;
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"videoplayer_loading"]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(PHOTOWEIDTH / 3, PHOTOHEIGHT);
}

@end
