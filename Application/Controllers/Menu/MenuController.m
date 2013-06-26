#import "MenuController.h"

@interface MenuController() {
  UIButton *_logoutButton;
}
-(UIButton*)logoutButton;
-(void)didTapLogout:(id)sender;
@end

@implementation MenuController

- (id)init {
  if (self = [super init]) {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view setStyleId:@"slide_menu"];
    [self.view addSubview:self.logoutButton];
    [self.view setNeedsUpdateConstraints];
  }
  return self;
}

-(UIButton*)logoutButton {
  if (!_logoutButton) {
    _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_logoutButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_logoutButton setTitle:@"Sign Out" forState:UIControlStateNormal];
    [_logoutButton setImage:[UIImage imageNamed:@"icon_signout"] forState:UIControlStateNormal];
    [_logoutButton addTarget:self action:@selector(didTapLogout:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _logoutButton;
}

-(void)updateViewConstraints {
  [super updateViewConstraints];
  [self.view.superview addUniformConstraintsWithVisualFormat:@"|[self]|" forSubviews:@{@"self": self.view}];
  [self.view addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.logoutButton];
  [self.view addEqualityConstraintOn:NSLayoutAttributeLeft forSubview:self.logoutButton];
  [self.view addEqualityConstraintOn:NSLayoutAttributeRight forSubview:self.logoutButton];
  [self.view addConstraintsWithVisualFormat:@"V:[logout(height)]"
                                forSubviews:@{@"logout":self.logoutButton}
                                withMetrics:@{@"height":@(45)}];
}

-(void)didTapLogout:(id)sender {
  postNotification(UserSessionShouldBeInvalidated);
}

@end
