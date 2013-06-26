#import "MenuController.h"
#import "User.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

static CGFloat kUserAvatarLength = 70.f;
static CGFloat kUserItemPadding = 25.f;

@interface MenuController() {
  UIImageView *_userAvatar;
  UILabel *_userName;
  UIButton *_logoutButton;
}
-(User*)currentUser;
-(UILabel*)userName;
-(UIImageView*)userAvatar;
-(UIButton*)logoutButton;
-(void)didTapLogout:(id)sender;
-(void)didAcquireUserDetails:(NSNotification*)notification;
@end

@implementation MenuController

- (id)init {
  if (self = [super init]) {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view setStyleId:@"slide_menu"];
    [self.view addSubview:self.userAvatar];
    [self.view addSubview:self.userName];
    [self.view addSubview:self.logoutButton];
    [self.view setNeedsUpdateConstraints];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didAcquireUserDetails:)
                                                 name:UserDetailsWereAcquired object:nil];
  }
  return self;
}

-(User*)currentUser {
  return [[UserDataStore sharedInstance] currentUser];
}

-(UIImageView*)userAvatar {
  if (!_userAvatar) {
    _userAvatar = [[UIImageView alloc] init];
    [_userAvatar setStyleId:@"user_avatar"];
    [_userAvatar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_userAvatar setContentMode:UIViewContentModeScaleAspectFill];
    [_userAvatar.layer setCornerRadius:ceilf(kUserAvatarLength / 2.f)];
    [_userAvatar setClipsToBounds:YES];
    [_userAvatar.layer setBorderColor:[[UIColor colorWithHexString:@"606060"] CGColor]];
    [_userAvatar.layer setBorderWidth:1.f];
    if ([[UserDataStore sharedInstance] isAuthenticated]) {
      [_userAvatar setImageWithURL:[self.currentUser largeProfileImageURL]
                  placeholderImage:[UIImage imageNamed:@"icon_user_menu"]];
    }
  }
  return _userAvatar;
}

-(UILabel*)userName {
  if (!_userName) {
    _userName = [[UILabel alloc] init];
    [_userName setStyleId:@"user_name"];
    [_userName setTranslatesAutoresizingMaskIntoConstraints:NO];
    if ([[UserDataStore sharedInstance] isAuthenticated]) {
      [_userName setText:[self.currentUser name]];
    }
  }
  return _userName;
}

-(UIButton*)logoutButton {
  if (!_logoutButton) {
    _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_logoutButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_logoutButton setStyleId:@"logout_button"];
    [_logoutButton setTitle:@"Sign Out" forState:UIControlStateNormal];
    [_logoutButton setImage:[UIImage imageNamed:@"icon_signout"] forState:UIControlStateNormal];
    [_logoutButton addTarget:self action:@selector(didTapLogout:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _logoutButton;
}

-(void)updateViewConstraints {
  [super updateViewConstraints];
  id views = @{@"self": self.view, @"avatar": self.userAvatar, @"logout": self.logoutButton};
  id metrics = @{@"width": @(235), @"length": @(kUserAvatarLength), @"height": @(45), @"padding": @(50)};
  [self.view.superview addConstraintsWithVisualFormat:@"H:|[self(width)]"
                                          forSubviews:views withMetrics:metrics];
  [self.view.superview addConstraintsWithVisualFormat:@"V:|[self]|" forSubviews:views];
  [self.view addUniformConstraintsWithVisualFormat:@"[avatar(length)]"
                                       forSubviews:views withMetrics:metrics];
  [self.view addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.userAvatar];
  [self.view addEqualityConstraintOn:NSLayoutAttributeTop
                          forSubview:self.userAvatar
                            constant:-kUserItemPadding];
  [self.view addEqualityConstraintOn:NSLayoutAttributeLeft forSubview:self.userName];
  [self.view addEqualityConstraintOn:NSLayoutAttributeRight forSubview:self.userName];
  [self.view addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.userName];
  [self.view addEqualityConstraintFor:self.userAvatar relatedBy:NSLayoutAttributeBottom
                                   on:self.userName relatedBy:NSLayoutAttributeTop
                             constant:-(kUserItemPadding/2.f)];
  [self.view addEqualityConstraintFor:self.userName relatedBy:NSLayoutAttributeBottom
                                   on:self.logoutButton relatedBy:NSLayoutAttributeTop
                             constant:-kUserItemPadding];
  [self.view addEqualityConstraintOn:NSLayoutAttributeLeft forSubview:self.logoutButton constant:1];
  [self.view addEqualityConstraintOn:NSLayoutAttributeRight forSubview:self.logoutButton constant:-1];
  [self.view addConstraintsWithVisualFormat:@"V:[logout(height)]"
                                forSubviews:views withMetrics:metrics];
}

-(void)didTapLogout:(id)sender {
  postNotification(UserSessionShouldBeInvalidated);
}

-(void)didAcquireUserDetails:(NSNotification *)notification {
  [self.userAvatar setImageWithURL:[self.currentUser largeProfileImageURL]
                  placeholderImage:[UIImage imageNamed:@"icon_user_menu"]];
}

@end
