#import "ItemCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

static CGFloat dibDotLength = 55.f;

@interface ItemCell() {
  UIImageView *_itemImage;
  UILabel *_title;
  UILabel *_price;
  UIView *_container;
  UIView *_dibInfoContainer;
  UILabel *_dibInfoLabel;
}

-(UIView*)dibInfoContainer;
-(UILabel*)dibInfoLabel;

@end

@implementation ItemCell

-(id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setStyleClass:@"item_cell"];
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.itemImage];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.price];
    [self.contentView addSubview:self.container];
    [self.contentView addSubview:self.dibInfoContainer];
    [self.dibInfoContainer addSubview:self.dibInfoLabel];
    [self.contentView setNeedsUpdateConstraints];
  }
  return self;
}

-(void)setItem:(Item *)item {
  [self.itemImage setImageWithURL:item.primaryImageURL];
  [self.title setText:item.name];
  [self.price setText:item.price];
}

-(void)setDibInfoText:(NSString *)infoText {
  [self.dibInfoContainer setHidden:NO];
  [self.dibInfoLabel setText:infoText];
}

-(UIView*)dibInfoContainer {
  if (!_dibInfoContainer) {
    _dibInfoContainer = [[UIView alloc] init];
    [_dibInfoContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_dibInfoContainer setStyleClass:@"dib_dot"];
    [_dibInfoContainer setHidden:YES];
  }
  return _dibInfoContainer;
}

-(UILabel*)dibInfoLabel {
  if (!_dibInfoLabel) {
    _dibInfoLabel = [[UILabel alloc] init];
    [_dibInfoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_dibInfoLabel setNumberOfLines:2];
  }
  return _dibInfoLabel;
}

-(UIImageView*)itemImage {
  if (!_itemImage) {
    _itemImage = [[UIImageView alloc] init];
    [_itemImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_itemImage setContentMode:UIViewContentModeScaleAspectFill];
    [_itemImage setClipsToBounds:YES];
  }
  return _itemImage;
}

-(UILabel*)title {
  if (!_title) {
    _title = [[UILabel alloc] init];
    [_title setStyleClass:@"item_title"];
    [_title setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _title;
}

-(UILabel*)price {
  if (!_price) {
    _price = [[UILabel alloc] init];
    [_price setStyleClass:@"item_price"];
    [_price setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _price;
}

-(UIView*)container {
  if (!_container) {
    _container = [[UIView alloc] init];
    [_container setStyleClass:@"metadata_container"];
    [_container setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _container;
}

-(void)updateConstraints {
  [super updateConstraints];
  // Ensure image is in 4:3 aspect ratio
  NSNumber *imageHeight = @((self.bounds.size.width - kItemCellPadding * 2) / (4.f/3.f));
  id views = @{ @"dibdot": self.dibInfoContainer,
                @"dibLabel": self.dibInfoLabel,
                @"content": self.contentView,
                @"image": self.itemImage,
                @"title": self.title,
                @"price": self.price,
                @"container": self.container };
  id metrics = @{ @"padding": @(kItemCellPadding),
                  @"imageHeight": imageHeight,
                  @"containerHeight": @(45),
                  @"dibLength": @(dibDotLength)};
  [self addUniformConstraintsWithVisualFormat:@"|[content]|" forSubviews:views];
  [self addConstraintsWithVisualFormat:@"H:[dibdot(dibLength)]-(-2)-|" forSubviews:views withMetrics:metrics];
  [self.dibInfoContainer addUniformConstraintsWithVisualFormat:@"|[dibLabel]|" forSubviews:views];
  [self addConstraintsWithVisualFormat:@"V:|-(-2)-[dibdot(dibLength)]" forSubviews:views withMetrics:metrics];
  [self addConstraintsWithVisualFormat:@"H:|-(padding)-[image]-(padding)-|" forSubviews:views withMetrics:metrics];
  [self addConstraintsWithVisualFormat:@"V:|-(padding)-[image(imageHeight)]" forSubviews:views withMetrics:metrics];
  [self addEqualityConstraintFor:self.itemImage relatedBy:NSLayoutAttributeBottom
                              on:self.title relatedBy:NSLayoutAttributeTop];
  [self addConstraintsWithVisualFormat:@"H:|-(padding)-[title]-(padding)-|" forSubviews:views withMetrics:metrics];
  [self addEqualityConstraintFor:self.title relatedBy:NSLayoutAttributeBottom
                              on:self.price relatedBy:NSLayoutAttributeTop];
  [self addConstraintsWithVisualFormat:@"H:|-(padding)-[price]-(padding)-|" forSubviews:views withMetrics:metrics];
  [self addConstraintsWithVisualFormat:@"H:|[container]|" forSubviews:views];
  [self addConstraintsWithVisualFormat:@"V:[container(containerHeight)]|" forSubviews:views withMetrics:metrics];
}

@end
