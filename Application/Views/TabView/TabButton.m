#import "TabButton.h"

@interface TabButton() {
  UILabel *_titleLabel;
  UIImageView *_iconView;
  NSString *_highlightedIconName;
  UIView *_container;
}
-(id)initWithTitle:(NSString*)title andIconName:(NSString*)iconName;
-(UIView*)container;
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
    [self addSubview:self.container];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.iconView];
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

-(UIView*)container {
  if (!_container) {
    _container = [[UIView alloc] init];
    [_container setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _container;
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
    [self setBackgroundColor:[UIColor colorWithHexString:@"353535"]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
  } else {
    [self setBackgroundColor:[UIColor colorWithHexString:@"424242"]];
    [self.titleLabel setTextColor:[UIColor colorWithHexString:@"747474"]];
  }
}

-(BOOL)isSelected {
  return [self.iconView isHighlighted];
}

-(void)updateConstraints {
  [super updateConstraints];
  [self addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.container];
  [self addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.container];
  [self.container addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.titleLabel];
  [self.container addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.iconView];
  [self.container addEqualityConstraintFor:self.titleLabel relatedBy:NSLayoutAttributeTop
                                        on:self.iconView relatedBy:NSLayoutAttributeBottom];
}

@end
