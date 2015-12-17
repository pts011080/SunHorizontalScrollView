//
//  SunHorizontalScrollView.h
//  SUNScrollTableViewCell
//
//  Created by 孙博弘 on 15/9/13.
//  Copyright (c) 2015年 孙博弘. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SunHorizontalScrollMedia.h"

@class SunHorizontalScrollView;

@protocol SunHorizontalScrollViewDelegate <NSObject>

- (void)collectionView:(SunHorizontalScrollView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)collectionView:(SunHorizontalScrollView *)collectionView shouldRemoveItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SunHorizontalScrollView : UIView {
    UICollectionViewFlowLayout *_flowLayout;
    UICollectionView *_collectionView;
}

@property (weak, nonatomic) id<SunHorizontalScrollViewDelegate> delegate;

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

// you can use this to layout
@property (nonatomic, strong, readonly) UICollectionViewFlowLayout *flowLayout;

//For other customised tableview cell to store the row index
@property (nonatomic, assign) NSInteger atRowIndex;

//Delete item added 2015-12-17
@property (nonatomic, assign) BOOL isEditmode;
@property (nonatomic, strong) UIImage *accessoryButtonImage;

// you can use NSString or NSURL or SunHorizontalScrollMedia
- (void)setData:(NSMutableArray *)collectionImageData;

- (void)setBackgroundColor:(UIColor *)color;

- (NSInteger)currentPage;
- (NSInteger)totalPages;

@end
