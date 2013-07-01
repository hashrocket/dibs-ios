#import "MyItemCell.h"
#import <NSDate+TimeAgo/NSDate+TimeAgo.h>
#import <TTTLocalizedPluralString/TTTLocalizedPluralString.h>

@interface MyItemCell() {
  UILabel *_dateListedLabel;
}

-(UILabel*)dateListedLabel;

@end

@implementation MyItemCell

-(id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self.container addSubview:self.dateListedLabel];
  }
  return self;
}

-(void)setItem:(Item *)item {
  [super setItem:item];
  [self.dateListedLabel setText:strf(@"Listed %@",[[item.dateListed timeAgo] lowercaseString])];
  NSString *formattedCountString = strf(@"%u\n%@", item.dibCount, TTTLocalizedPluralString(item.dibCount, @"Dib", nil));
  [self setDibInfoText:formattedCountString];
}

-(UILabel*)dateListedLabel {
  if (!_dateListedLabel) {
    _dateListedLabel = [[UILabel alloc] init];
    [_dateListedLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _dateListedLabel;
}

-(void)updateConstraints {
  [super updateConstraints];
  [self addEqualityConstraintFor:self.dateListedLabel relatedBy:NSLayoutAttributeLeft
                              on:self.itemImage relatedBy:NSLayoutAttributeLeft];
  [self.container addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.dateListedLabel];
}

@end
