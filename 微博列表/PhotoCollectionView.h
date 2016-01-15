//
//  PhotoCollectionView.h
//  微博列表
//
//  Created by GXY on 16/1/14.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "PhotoCollectionViewCell.h"
#import "UITableViewCell+Config.h"

@interface PhotoCollectionView : UICollectionView

@property (nonatomic, strong) NSArray *images_url;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height;

@end
