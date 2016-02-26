//
//  SunHorizontalScrollView.m
//  SUNScrollTableViewCell
//
//  Created by 孙博弘 on 15/9/13.
//  Copyright (c) 2015年 孙博弘. All rights reserved.
//

#import "SunHorizontalScrollView.h"

#import "SunHorizontalImageCollectionViewCell.h"

@interface SunHorizontalScrollView () <UICollectionViewDataSource, UICollectionViewDelegate,SunHorizontalImageCollectionViewCellDelegate>

@property (strong, nonatomic) NSMutableArray *mediaContainer;
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

// - (void)layoutSubviews {
//     [super layoutSubviews];

//     self.collectionView.frame = self.frame;

//     [self.collectionView reloadData];
    
//     [self updatePageLabel];
// }

- (void)setData:(NSMutableArray *)collectionImageData {
    self.mediaContainer = [collectionImageData mutableCopy];

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
    }else{
        [cell clearImage];
    }
    
    if (self.placeHolderImage) {
        cell.placeHolderImage = self.placeHolderImage;
    }
    
    cell.delegate = self;
    cell.isEditmode = self.isEditmode;
    cell.accessoryButtonImage = self.accessoryButtonImage;
    
    if ([mediaObject isKindOfClass:[NSString class]] || [mediaObject isKindOfClass:[NSURL class]]) {
        [cell setImageWithURL:mediaObject];
    } else {
        SunHorizontalScrollMedia *horizontalScrollMedia = (SunHorizontalScrollMedia *)mediaObject;
        switch (horizontalScrollMedia.type) {
            case SunHorizontalScrollMediaTypeImageURL:

                [cell setImageWithURL:horizontalScrollMedia.object];

                break;
            case SunHorizontalScrollMediaTypeUIImage:
                
                [cell setImageWithUIImage:horizontalScrollMedia.object];
                
                break;
        }
    }
    
    [cell setAtPage:(int)indexPath.row+1 withTotalPage:(int)self.mediaContainer.count];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
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
    CGFloat targetX = scrollView.contentOffset.x;
    CGFloat targetIndex = round(targetX / (self.flowLayout.itemSize.width + self.flowLayout.minimumLineSpacing));
    self.currentPage = targetIndex + 1;
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
        _pageLabel.font = [UIFont systemFontOfSize:14];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.7];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.hidden = YES;
        [self addSubview:_pageLabel];
    }
    return _pageLabel;
}

-(void)updatePageLabel{
    if (self.totalPages < self.currentPage) {
        self.currentPage = self.totalPages;
    }
    self.pageLabel.text =[NSString stringWithFormat:@"%d / %d", (int)self.currentPage, (int)self.totalPages];
    /* update the label width */
    CGSize textSize = [[self.pageLabel text] sizeWithAttributes:@{NSFontAttributeName:[self.pageLabel font]}];
    CGFloat labelWidth = textSize.width;
    [self.pageLabel setFrame:CGRectMake(20, 20, labelWidth + 10, 20)];
    
    /* can replace teh update the label width with one line code, but not good layout display with colored background.*/
    //[self.pageLabel sizeToFit];
    
//    if (self.showPageLabel == YES) {
//        self.pageLabel.hidden = NO;
//    }else{
//        self.pageLabel.hidden = YES;
//    }
    
}

- (void)setIsEditmode:(BOOL)isEditmode{
    NSLog(@"is editmote? %@",isEditmode?@"YES":@"NO");
    _isEditmode = isEditmode;
    self.pageLabel.hidden = isEditmode;
}

#pragma mark -- SunHorizontalImageCollectionViewCellDelegate
-(void)collectionViewCell:(SunHorizontalImageCollectionViewCell *)collectionViewCell accessoryButton:(UIButton *)accessoryButton{
    NSLog(@"%@ cell delebutton pressed!",collectionViewCell);
    if ([self.delegate respondsToSelector:@selector(collectionView:shouldRemoveItemAtIndexPath:)]) {
        NSIndexPath *indexpath =[self.collectionView indexPathForCell:collectionViewCell];
        if ([self.delegate collectionView:self shouldRemoveItemAtIndexPath:indexpath] ) {
            NSLog(@"Should remove the cell.");
            [self.mediaContainer removeObjectAtIndex:(int)indexpath.row];
//            [self setData:[self.mediaContainer mutableCopy]];
            [self.collectionView reloadData];
            [self updatePageLabel];
        }else{
            NSLog(@"Don't remove the cell!");
        }
    }
    
    
}

//Credit: http://stackoverflow.com/questions/6813270/uiscrollview-custom-paging-size lucius and Kevin Hirsch
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat targetX = scrollView.contentOffset.x + velocity.x * 60.0;
    CGFloat targetIndex = round(targetX / (self.flowLayout.itemSize.width + self.flowLayout.minimumLineSpacing));
    
    if (velocity.x > 0) {
        targetIndex = ceil(targetX / (self.flowLayout.itemSize.width + self.flowLayout.minimumLineSpacing));
    } else {
        targetIndex = floor(targetX / (self.flowLayout.itemSize.width + self.flowLayout.minimumLineSpacing));
    }
    targetContentOffset->x = targetIndex * (self.flowLayout.itemSize.width + self.flowLayout.minimumLineSpacing);
}

@end
