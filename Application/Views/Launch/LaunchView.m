#import "LaunchView.h"
#import "AppDelegate.h"

@interface LaunchView() {
  UIView *_wrapper;
  UIImageView *_dibsLogo;
  UILabel *_slogan;
  UIButton *_connectButton;
}
-(UIImageView*)dibsLogo;
-(UILabel*)slogan;
-(UIButton*)connectButton;
-(void)didTapConnect:(id)sender;
-(UIView*)wrapper;
@end

@implementation LaunchView

-(id)init {
  if (self = [super init]) {
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.wrapper];
    [self.wrapper addSubview:self.dibsLogo];
    [self.wrapper addSubview:self.slogan];
    [self.wrapper addSubview:self.connectButton];
    if ([[UserDataStore sharedInstance] isAuthenticated]) {
      [self.connectButton setEnabled:NO];
    }
  }
  return self;
}

-(UIView*)wrapper {
  if (!_wrapper) {
    _wrapper = [[UIView alloc] init];
    [_wrapper setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _wrapper;
}

-(UIImageView*)dibsLogo {
  if (!_dibsLogo) {
    _dibsLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_full"]];
    [_dibsLogo setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _dibsLogo;
}

-(UILabel*)slogan {
  if (!_slogan) {
    _slogan = [[UILabel alloc] init];
    [_slogan setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_slogan setNumberOfLines:2];
    [_slogan setText:NSLocalizedString(@"label.slogan", nil)];
  }
  return _slogan;
}

-(UIButton*)connectButton {
  if (!_connectButton) {
    _connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_connectButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_connectButton setImage:[UIImage imageNamed:@"icon_f"] forState:UIControlStateNormal];
    [_connectButton addTarget:self action:@selector(didTapConnect:)
             forControlEvents:UIControlEventTouchUpInside];
    [_connectButton setTitle:NSLocalizedString(@"button.connect", nil)
                    forState:UIControlStateNormal];
  }
  return _connectButton;
}

-(void)didTapConnect:(id)sender {
  AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  [delegate openSessionWithAllowLoginUI:YES];
}

-(void)updateConstraints {
  [super updateConstraints];
  id views = @{ @"wrapper" : self.wrapper,
                @"connect" : self.connectButton,
                @"slogan"  : self.slogan,
                @"dibsLogo": self.dibsLogo };
  [self addConstraintsWithVisualFormat:@"V:[wrapper(275)]" forSubviews:views];
  [self addConstraintsWithVisualFormat:@"H:|[wrapper]|" forSubviews:views];
  [self addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.wrapper];
  [self.wrapper addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.dibsLogo];
  [self.wrapper addEqualityConstraintOn:NSLayoutAttributeTop forSubview:self.dibsLogo];
  [self.wrapper addEqualityConstraintFor:self.dibsLogo relatedBy:NSLayoutAttributeBottom
                                      on:self.slogan   relatedBy:NSLayoutAttributeTop constant:-15];
  [self.wrapper addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.slogan];
  [self.wrapper addConstraintsWithVisualFormat:@"V:[connect(47)]" forSubviews:views];
  [self.wrapper addConstraintsWithVisualFormat:@"H:|-(35)-[connect]-(35)-|" forSubviews:views];
  [self.wrapper addEqualityConstraintOn:NSLayoutAttributeBottom forSubview:self.connectButton];
}

@end
