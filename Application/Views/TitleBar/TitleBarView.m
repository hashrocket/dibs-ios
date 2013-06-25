#import "TitleBarView.h"

@interface TitleBarView() {
  UIImageView *_logoView;
}
-(UIImageView*)logoView;
@end

@implementation TitleBarView

-(id)init {
  if (self = [super init]) {
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setStyleId:@"title_bar"];
    [self addSubview:self.logoView];
    [self setNeedsUpdateConstraints];
  }
  return self;
}

-(UIImageView*)logoView {
  if (!_logoView) {
    _logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titlebar_logo"]];
    [_logoView setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _logoView;
}

-(void)updateConstraints {
  [super updateConstraints];
  [self addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.logoView];
  [self addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.logoView];
}

@end
