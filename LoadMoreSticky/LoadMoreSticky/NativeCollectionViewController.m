#import "NativeCollectionViewController.h"
#import "MyCollectionViewCell.h"

#define CELL_IDENTIFIER @"cell_id"

@interface NativeCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic) BOOL addingItems;
@end

@implementation NativeCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    self.items =  [NSMutableArray arrayWithArray:@[ @"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item"]];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    
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
        cell = [[MyCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    }
    cell.titleLabel.text = [self.items[indexPath.row] stringByAppendingString:@(indexPath.row).stringValue];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.addingItems && self.items.count - indexPath.row <= 3) {
        [self addMoreItems];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, 50);
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
            reusableview = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        }
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
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
