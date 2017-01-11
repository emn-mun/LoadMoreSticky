#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    _titleLabel = [[UILabel alloc] initWithFrame:self.frame];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_titleLabel];
    
//    NSArray *constraints = @[
//                             [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
//                             [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
//                             [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
//                             [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
//                             ];
//    [NSLayoutConstraint activateConstraints:constraints];
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

@end
