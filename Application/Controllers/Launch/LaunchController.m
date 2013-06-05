#import "LaunchController.h"
#import "AppDelegate.h"
#import "TabBarController.h"

@interface LaunchController () {
  UIButton *_connectButton;
  TabBarController *_tabController;
  UIView *_launchView;
}
-(UIButton*)connectButton;
-(TabBarController*)tabController;
-(UIView*)launchView;
-(void)transitionToTabBarController;
-(void)didTapConnect:(id)sender;
-(void)sessionStateDidChange:(NSNotification*)notification;
@end

@implementation LaunchController

-(id)init {
  if (self = [super init]) {
    [self.view addSubview:self.tabController.view];
    [self.view addSubview:self.launchView];
    if ([[UserDataStore sharedInstance] isUnauthenticated]) {
      [self.launchView addSubview:self.connectButton];
    } else {
      [self transitionToTabBarController];
    }
    [self.view setNeedsUpdateConstraints];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStateDidChange:) name:FBSessionStateChangedNotification object:nil];
  }
  return self;
}

-(UIView*)launchView {
  if (!_launchView) {
    _launchView = [[UIView alloc] initWithoutAutoresizing];
    [_launchView setBackgroundColor:[UIColor grayColor]];
    [_launchView setStyleId:@"launch_view"];
  }
  return _launchView;
}

-(UIButton*)connectButton {
  if (!_connectButton) {
    _connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_connectButton setBackgroundColor:[UIColor blueColor]];
    [_connectButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_connectButton addTarget:self action:@selector(didTapConnect:)
             forControlEvents:UIControlEventTouchUpInside];
    [_connectButton setTitle:NSLocalizedString(@"button.connect", nil)
                    forState:UIControlStateNormal];
  }
  return _connectButton;
}

-(TabBarController*)tabController {
  if (!_tabController) {
    _tabController = [[TabBarController alloc] init];
  }
  return _tabController;
}

-(void)updateViewConstraints {
  [super updateViewConstraints];
  id views = @{ @"launch": self.launchView,
                @"connect": self.connectButton,
                @"tabbar": self.tabController.view };
  [self.view addUniformConstraintsWithVisualFormat:@"|[launch]|" forSubviews:views];
  [self.view addUniformConstraintsWithVisualFormat:@"|[tabbar]|" forSubviews:views];
  if ([[UserDataStore sharedInstance] isUnauthenticated]) {
    [self.view addConstraintsWithVisualFormat:@"H:[connect(200)]" forSubviews:views];
    [self.view addConstraintsWithVisualFormat:@"V:[connect(40)]" forSubviews:views];
    [self.view addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.connectButton];
    [self.view addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.connectButton];
  }
}

-(void)transitionToTabBarController {
  [UIView animateWithDuration:0.5 animations:^{
    [self.launchView setAlpha:0];
  }];
}

-(void)didTapConnect:(id)sender {
  AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  [delegate openSessionWithAllowLoginUI:YES];
}

-(void)sessionStateDidChange:(NSNotification *)notification {
  log_object(notification);
  if ([[UserDataStore sharedInstance] isAuthenticated]) {
    [self transitionToTabBarController];
  }
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end