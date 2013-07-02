#import "TabButton.h"

@interface TabButton() {
  UILabel *_titleLabel;
  UIImageView *_iconView;
  NSString *_highlightedIconName;
}
-(id)initWithTitle:(NSString*)title andIconName:(NSString*)iconName;
@end

@implementation TabButton

+(id)buttonWithTitle:(NSString *)title {
  return [[self class] buttonWithTitle:title andIconName:nil];
}

+(id)buttonWithTitle:(NSString *)title andIconName:(NSString *)iconName {
  return [[self alloc] initWithTitle:title andIconName:iconName];
}

-(id)initWithTitle:(NSString *)title andIconName:(NSString *)iconName {
  if (self = [super init]) {
    [self setTitle:title];
    [self setIconName:iconName];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setStyleClass:@"tab_button"];
    [self addSubview:self.titleLabel];
    [self addSubview:self.iconView];
    [self setNeedsUpdateConstraints];
  }
  return self;
}

-(NSString*)highlightedIconName {
  if (!_highlightedIconName) {
    _highlightedIconName = strf(@"%@_highlighted",self.iconName);
  }
  return _highlightedIconName;
}

-(void)setHighlightedIconName:(NSString *)highlightedIconName {
  _highlightedIconName = highlightedIconName;
}

-(UILabel*)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_titleLabel setText:self.title];
  }
  return _titleLabel;
}

-(UIImageView*)iconView {
  if (!_iconView) {
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.iconName]
                                  highlightedImage:[UIImage imageNamed:self.highlightedIconName]];
    [_iconView setContentMode:UIViewContentModeCenter];
    [_iconView setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _iconView;
}

-(void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  [self setSelected:!enabled];
}

-(void)setSelected:(BOOL)selected {
  [self.iconView setHighlighted:selected];
  if (selected) {
    [self setBackgroundColor:[UIColor colorWithHexString:@"4f88c9"]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
  } else {
    [self setBackgroundColor:[UIColor colorWithHexString:@"2c68ac"]];
    [self.titleLabel setTextColor:[UIColor colorWithHexString:@"00336c"]];
  }
}

-(BOOL)isSelected {
  return [self.iconView isHighlighted];
}

-(void)updateConstraints {
  [super updateConstraints];
  [self addConstraintsWithVisualFormat:@"V:[icon(height)]"
                           forSubviews:@{@"icon": self.iconView}
                           withMetrics:@{@"height": @(27)}];
  [self addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.titleLabel];
  [self addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.iconView];
  [self addEqualityConstraintOn:NSLayoutAttributeTop forSubview:self.iconView constant:-10.f];
  [self addEqualityConstraintFor:self.titleLabel relatedBy:NSLayoutAttributeTop
                              on:self.iconView relatedBy:NSLayoutAttributeBottom];
}

@end
