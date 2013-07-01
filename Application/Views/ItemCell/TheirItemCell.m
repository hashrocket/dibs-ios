#import "TheirItemCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "User.h"

static CGFloat kIconLength = 23.5f;

@interface TheirItemCell() {
  UIImageView *_authorIcon;
  UILabel *_authorName;
}

-(UIImageView*)authorIcon;
-(UILabel*)authorName;

@end

@implementation TheirItemCell

-(id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    
    [self.container addSubview:self.authorIcon];
    [self.container addSubview:self.authorName];
  }
  return self;
}

-(void)setItem:(Item *)item {
  [super setItem:item];
  [self.authorIcon setImageWithURL:[item.owner profileImageURL]
                  placeholderImage:[UIImage imageNamed:@"icon_user_menu"]];
  [self.authorName setText:[item.owner name]];
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
  id views = @{ @"icon": self.authorIcon };
  id metrics = @{ @"iconLength": @(kIconLength) };
  [self addEqualityConstraintFor:self.authorIcon relatedBy:NSLayoutAttributeLeft
                              on:self.itemImage relatedBy:NSLayoutAttributeLeft];
  [self addUniformConstraintsWithVisualFormat:@"[icon(iconLength)]" forSubviews:views withMetrics:metrics];
  [self.container addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.authorIcon];
  [self.container addEqualityConstraintFor:self.authorIcon relatedBy:NSLayoutAttributeRight
                                        on:self.authorName relatedBy:NSLayoutAttributeLeft constant:-kItemCellPadding];
  [self.container addEqualityConstraintOn:NSLayoutAttributeRight forSubview:self.authorName];
  [self.container addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.authorName];
}


@end
