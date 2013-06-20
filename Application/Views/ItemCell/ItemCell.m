#import "ItemCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "Item.h"
#import "User.h"

static CGFloat kPadding = 10.f;
static CGFloat kIconLength = 23.5f;

@interface ItemCell() {
  UIImageView *_itemImage;
  UILabel *_title;
  UILabel *_price;
  UIView *_container;
  UIImageView *_authorIcon;
  UILabel *_authorName;
}

-(UIImageView*)itemImage;
-(UILabel*)title;
-(UILabel*)price;
-(UIView*)container;
-(UIImageView*)authorIcon;
-(UILabel*)authorName;

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
    [self.container addSubview:self.authorIcon];
    [self.container addSubview:self.authorName];
    [self.contentView setNeedsUpdateConstraints];
  }
  return self;
}

-(void)setItem:(Item *)item {
  [self.itemImage setImageWithURL:item.primaryImageURL];
  [self.title setText:item.name];
  [self.price setText:item.price];
  [self.authorIcon setImageWithURL:[item.owner profileImageURL]];
  [self.authorName setText:[item.owner name]];
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
    [_container setStyleClass:@"author_container"];
    [_container setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _container;
}

-(UIImageView*)authorIcon {
  if (!_authorIcon) {
    _authorIcon = [[UIImageView alloc] init];
    [_authorIcon setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_authorIcon.layer setCornerRadius:ceilf(kIconLength / 2.f)];
    [_authorIcon setClipsToBounds:YES];
  }
  return _authorIcon;
}

-(UILabel*)authorName {
  if (!_authorName) {
    _authorName = [[UILabel alloc] init];
    [_authorName setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _authorName;
}

-(void)updateConstraints {
  [super updateConstraints];
  // Ensure image is in 4:3 aspect ratio
  NSNumber *imageHeight = @((self.bounds.size.width - kPadding * 2) / (4.f/3.f));
  id views = @{ @"content": self.contentView,
                @"image": self.itemImage,
                @"title": self.title,
                @"price": self.price,
                @"container": self.container,
                @"icon": self.authorIcon};
  id metrics = @{ @"padding": @(kPadding),
                  @"imageHeight": imageHeight,
                  @"containerHeight": @(45),
                  @"iconLength": @(kIconLength) };
  [self addUniformConstraintsWithVisualFormat:@"|[content]|" forSubviews:views];
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
  [self addEqualityConstraintFor:self.authorIcon relatedBy:NSLayoutAttributeLeft
                              on:self.itemImage relatedBy:NSLayoutAttributeLeft];
  [self addUniformConstraintsWithVisualFormat:@"[icon(iconLength)]" forSubviews:views withMetrics:metrics];
  [self.container addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.authorIcon];
  [self.container addEqualityConstraintFor:self.authorIcon relatedBy:NSLayoutAttributeRight
                                        on:self.authorName relatedBy:NSLayoutAttributeLeft constant:-kPadding];
  [self.container addEqualityConstraintOn:NSLayoutAttributeRight forSubview:self.authorName];
  [self.container addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.authorName];
}

@end
