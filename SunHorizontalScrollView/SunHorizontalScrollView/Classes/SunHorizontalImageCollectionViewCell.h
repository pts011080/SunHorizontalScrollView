//
//  SunHorizontalImageCollectionViewCell.h
//  SUNScrollTableViewCell
//
//  Created by 孙博弘 on 15/9/13.
//  Copyright (c) 2015年 孙博弘. All rights reserved.
//

@class SunHorizontalImageCollectionViewCell;

@protocol SunHorizontalImageCollectionViewCellDelegate <NSObject>

- (void)collectionViewCell:(SunHorizontalImageCollectionViewCell *)collectionViewCell accessoryButton:(UIButton *)accessoryButton;

@end

#import <UIKit/UIKit.h>

@interface SunHorizontalImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id<SunHorizontalImageCollectionViewCellDelegate> delegate;

@property (strong, nonatomic) UIButton *accessoryButton;

//Delete item added 2015-12-17
@property (nonatomic, assign) BOOL isEditmode;
@property (nonatomic, strong) UIImage *accessoryButtonImage;

//placeHolder
@property (nonatomic, strong) UIImage *placeHolderImage;

/**
 *  set image downloaded from web
 *
 *  @param image url
 */
- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithUIImage:(UIImage*)image;
- (void)clearImage;

- (void)setAtPage:(int)atPage withTotalPage:(int)totalPage;

@end
