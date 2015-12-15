//
//  SunHorizontalImageCollectionViewCell.m
//  SUNScrollTableViewCell
//
//  Created by 孙博弘 on 15/9/13.
//  Copyright (c) 2015年 孙博弘. All rights reserved.
//

#import "SunHorizontalImageCollectionViewCell.h"

//#import "UIImageView+WebCache.h"

#import "AFNetworking.h"

@interface SunHorizontalImageCollectionViewCell ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation SunHorizontalImageCollectionViewCell


- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake( 0.0,
                                      0.0,
                                      CGRectGetWidth(self.frame),
                                      CGRectGetHeight(self.frame) );
}

- (void)setImageWithURL:(NSURL *)url {
    [self.imageView setImageWithURL:url placeholderImage:nil];
//    [self.imageView sd_setImageWithURL:url];
//    [self.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:url] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
////        NSLog(@"Load image successful!");
//        [self.imageView setImage:image];
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
////        NSLog(@"failed to laod image URL: %@",response.URL.absoluteString);
//    }];
//    [self.contentView addSubview:self.imageView];
}

- (void)setImageWithUIImage:(UIImage*)image{
    [self.imageView setImage:image];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode   = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

-(void)clearImage{
    [self.imageView setImage:nil];
}

@end
