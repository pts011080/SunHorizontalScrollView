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

@property (nonatomic, strong) UILabel *indexLabel;

@end

@implementation SunHorizontalImageCollectionViewCell


- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake( 0.0,
                                      0.0,
                                      CGRectGetWidth(self.frame),
                                      CGRectGetHeight(self.frame) );
    self.accessoryButton.frame = CGRectMake(self.frame.size.width - 50, self.frame.size.height - 50, 40, 40);

    self.accessoryButton.hidden = !self.isEditmode;
    if (self.accessoryButtonImage != nil) {
        [self.accessoryButton setImage:self.accessoryButtonImage forState:UIControlStateNormal];
//        [self.accessoryButton setImage:self.accessoryButtonImage forState:UIControlStateHighlighted];
        [self.accessoryButton setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)setImageWithURL:(NSURL *)url {
    [self.imageView setImageWithURL:url placeholderImage:(self.placeHolderImage)?self.placeHolderImage:nil];
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

- (UIButton*)accessoryButton{
    if (!_accessoryButton) {
        _accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_accessoryButton addTarget:self action:@selector(accessoryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_accessoryButton setTitle:@"X" forState:UIControlStateNormal];
//        [_accessoryButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [_accessoryButton setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];
        [self addSubview:_accessoryButton];
    }
    return _accessoryButton;
}

-(void)clearImage{
    [self.imageView setImage:nil];
    [self.indexLabel setText:@""];
    self.indexLabel.hidden = YES;
}

-(void)accessoryButtonAction:(UIButton *)sender{
    NSLog(@"%@ button pressed!",sender);
    if ([self.delegate respondsToSelector:@selector(collectionViewCell:accessoryButton:)]) {
        [self.delegate collectionViewCell:self accessoryButton:sender];
    }
}

-(UILabel*)indexLabel{
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width, 30)];
        _indexLabel.font = [UIFont systemFontOfSize:14];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.7];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_indexLabel];
    }
    return _indexLabel;
}

-(void)setAtPage:(int)atPage withTotalPage:(int)totalPage{
    [self.indexLabel setText:[NSString stringWithFormat:@"%d / %d",atPage,totalPage]];
    if (self.indexLabel.text.length > 0) {
        /* update the label width */
        CGSize textSize = [[self.indexLabel text] sizeWithAttributes:@{NSFontAttributeName:[self.indexLabel font]}];
        CGFloat labelWidth = textSize.width;
        [self.indexLabel setFrame:CGRectMake(10, 10, labelWidth + 10, 20)];
        if (totalPage > 1) {
            self.indexLabel.hidden = NO;
        }
    }else{
        self.indexLabel.hidden = YES;
    }
}

@end
