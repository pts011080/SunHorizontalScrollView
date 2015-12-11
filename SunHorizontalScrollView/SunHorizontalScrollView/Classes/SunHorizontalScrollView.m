//
//  SunHorizontalScrollView.m
//  SUNScrollTableViewCell
//
//  Created by 孙博弘 on 15/9/13.
//  Copyright (c) 2015年 孙博弘. All rights reserved.
//

#import "SunHorizontalScrollView.h"

#import "SunHorizontalImageCollectionViewCell.h"

@interface SunHorizontalScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *mediaContainer;
@property (strong, nonatomic) UILabel *pageLabel;

//Current page number (current showing last item index of collectionView)
@property (nonatomic, assign) NSInteger currentPage;
//Total Number of items in collectionView
@property (nonatomic, assign) NSInteger totalPages;

@end

@implementation SunHorizontalScrollView

//-(id)init{
//    self = [super init];
//    if (self) {
//        self.atRowIndex = -1;
//        NSLog(@"_init: %@ at position: %ld", self,(long)self.atRowIndex);
//    }
//    return self;
//}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.collectionView.frame = self.frame;

    [self.collectionView reloadData];
    
    [self updatePageLabel];
}

- (void)setData:(NSArray *)collectionImageData {
    self.mediaContainer = collectionImageData;

    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];

    [self.collectionView reloadData];
    
    //removed add subview of collectionView at 2015-12-11, moved to it's lazy instantiation method.
    
    self.currentPage = 1;
    [self updatePageLabel];
}

- (void)setBackgroundColor:(UIColor *)color {
    self.collectionView.backgroundColor = color;
}

#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.mediaContainer.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id mediaObject = self.mediaContainer[indexPath.row];

    static NSString *cellReuseIdentify = @"SunHorizontalImageCollectionViewCell";

    SunHorizontalImageCollectionViewCell *cell = (SunHorizontalImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentify forIndexPath:indexPath];

    if (!cell) {
        cell = [[SunHorizontalImageCollectionViewCell alloc] init];
    }

    if ([mediaObject isKindOfClass:[NSString class]] || [mediaObject isKindOfClass:[NSURL class]]) {
        [cell setImageWithURL:mediaObject];
    } else {
        SunHorizontalScrollMedia *horizontalScrollMedia = (SunHorizontalScrollMedia *)mediaObject;
        switch (horizontalScrollMedia.type) {
            case SunHorizontalScrollMediaTypeImageURL:

                [cell setImageWithURL:horizontalScrollMedia.object];

                break;
        }
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didChangeValueForKey:)]) {
        [self.delegate collectionView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - get
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.itemSize     = CGSizeMake(80.0, 80.0);
        _flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
        _flowLayout.minimumLineSpacing = 10.0;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;

        _collectionView.backgroundColor = [UIColor whiteColor];

        _collectionView.collectionViewLayout = self.flowLayout;

        [_collectionView registerClass:[SunHorizontalImageCollectionViewCell class] forCellWithReuseIdentifier:@"SunHorizontalImageCollectionViewCell"];
        
        [self addSubview:_collectionView]; //added at 2015-12-11
    }
    return _collectionView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //may casue memory issues, but show accurate last shown item page number.
    NSInteger largeNumber = 0;
    //actually the mobile device only have limited screen dimension to display numbers of items. There for I assume it is not a problem
    for (UICollectionViewCell *cell in [self.collectionView visibleCells]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        if (indexPath.row > largeNumber) {
            largeNumber = indexPath.row;
        }
    }
    /* // lite way for large amount of item showed, but lower accuracy.
    UICollectionViewCell *lastVisableCell = [[self.collectionView visibleCells] lastObject];
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:lastVisableCell];
    largeNumber = indexPath.row;
    */
    self.currentPage = largeNumber + 1;
    [self updatePageLabel];
}

-(NSInteger)totalPages{
    return [self.mediaContainer count];
}

-(NSInteger)currentPage{
    if (!_currentPage) {
        _currentPage = 1;
    }
    return _currentPage;
}

-(UILabel*)pageLabel{
    if (!_pageLabel) {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width, 30)];
        _pageLabel.font = [UIFont systemFontOfSize:14 weight:1];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pageLabel];
    }
    return _pageLabel;
}

-(void)updatePageLabel{
    self.pageLabel.text =[NSString stringWithFormat:@"%d / %d", (int)self.currentPage, (int)self.totalPages];
    /* update the label width */
    CGSize textSize = [[self.pageLabel text] sizeWithAttributes:@{NSFontAttributeName:[self.pageLabel font]}];
    CGFloat labelWidth = textSize.width;
    [self.pageLabel setFrame:CGRectMake(20, 20, labelWidth + 10, 20)];
    
    /* can replace teh update the label width with one line code, but not good layout display with colored background.*/
    //[self.pageLabel sizeToFit];
}

@end
