#import "TitleBarView.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface TitleBarView() {
  UIImageView *_logoView;
  UIButton *_slideViewButton;
}
-(UIImageView*)logoView;
-(UIButton*)slideViewButton;
-(void)didTapSlideViewButton:(id)sender;
@end

@implementation TitleBarView

-(id)init {
  if (self = [super init]) {
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setStyleId:@"title_bar"];
    [self addSubview:self.slideViewButton];
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

-(UIButton*)slideViewButton {
  if (!_slideViewButton) {
    _slideViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_slideViewButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_slideViewButton setImage:[UIImage imageNamed:@"icon_user_button"] forState:UIControlStateNormal];
    [_slideViewButton addTarget:self action:@selector(didTapSlideViewButton:)
               forControlEvents:UIControlEventTouchUpInside];
  }
  return _slideViewButton;
}

-(void)didTapSlideViewButton:(id)sender {
  postNotification(SlideMenuShouldToggleState);
}

-(void)updateConstraints {
  [super updateConstraints];
  [self addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.logoView];
  [self addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.logoView];
  id views = @{@"slide": self.slideViewButton};
  id metrics = @{@"padding": @(7), @"width": @(34), @"height": @(30)};
  [self addConstraintsWithVisualFormat:@"H:|-(padding)-[slide(width)]" forSubviews:views withMetrics:metrics];
  [self addConstraintsWithVisualFormat:@"V:|-(padding)-[slide(height)]" forSubviews:views withMetrics:metrics];
}

@end
