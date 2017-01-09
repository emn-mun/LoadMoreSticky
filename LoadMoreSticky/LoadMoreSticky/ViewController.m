//
//  ViewController.m
//  LoadMoreSticky
//
//  Created by Emanuel Munteanu on 21/12/2016.
//  Copyright © 2016 com.loadMoreSticky. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"

#define CELL_IDENTIFIER @"cell_id"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *items;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) BOOL addingItems;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addingItems = NO;
    
    self.items =  [NSMutableArray arrayWithArray:@[ @"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item"]];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).sectionHeadersPinToVisibleBounds = YES;
}
- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:@"contentSize" context:NULL];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyCollectionViewCell alloc] init];
    }
    cell.titleLabel.text = [self.items[indexPath.row] stringByAppendingString:@(indexPath.row).stringValue];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.addingItems && self.items.count - indexPath.row <= 3) {
        [self addMoreItems];
    }
}

- (void)addMoreItems {
    self.addingItems = YES;
    NSLog(@"Starting to add items");
    [UIView animateWithDuration:0 animations:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"Actually adding items");
            NSInteger result = [self.items count];
            for (NSInteger i = 0; i < 10; i++) {
                [self.items addObject:@"item"];
            }
            [self.collectionView performBatchUpdates:^{
                NSMutableArray *arrayWithIndexPaths = [[NSMutableArray alloc] init];
                for (NSInteger i = result; i < 10 + result; i++) {
                    [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                }
                [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
            } completion:^(BOOL finished) {
                self.addingItems = NO;
            }];
        });
    }];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if (reusableview == nil) {
            reusableview = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
        }
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
        label.text = [NSString stringWithFormat:@"My Header #%li", indexPath.section + 1];
        [reusableview setBackgroundColor: [UIColor redColor]];
        [reusableview addSubview:label];
        return reusableview;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headerSize = CGSizeMake(320, 44);
    return headerSize;
}
@end
