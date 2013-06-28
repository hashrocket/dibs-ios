#import "LaunchController.h"
#import "LaunchView.h"
#import "TabBarController.h"
#import "AppDelegate.h"

@interface LaunchController () {
  TabBarController *_tabController;
  LaunchView *_launchView;
}
-(TabBarController*)tabController;
-(LaunchView*)launchView;
-(void)transitionToTabBarController;
-(void)sessionStateDidChange:(NSNotification*)notification;
@end

@implementation LaunchController

-(id)init {
  if (self = [super init]) {
    [self.view addSubview:self.tabController.view];
    [self.view addSubview:self.launchView];
    if ([[UserDataStore sharedInstance] isAuthenticated]) {
      [self transitionToTabBarController];
    }
    [self.view setNeedsUpdateConstraints];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStateDidChange:) name:FBSessionStateChangedNotification object:nil];
  }
  return self;
}

-(LaunchView*)launchView {
  if (!_launchView) {
    _launchView = [[LaunchView alloc] initWithDelegate:self];
    [_launchView setStyleId:@"launch_view"];
    if ([[UserDataStore sharedInstance] isAuthenticated]) {
      [_launchView setEnabled:NO];
    }
  }
  return _launchView;
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
                @"tabbar": self.tabController.view };
  [self.view addUniformConstraintsWithVisualFormat:@"|[launch]|" forSubviews:views];
  [self.view addUniformConstraintsWithVisualFormat:@"|[tabbar]|" forSubviews:views];
}

-(void)transitionToTabBarController {
  [UIView animateWithDuration:0.5 animations:^{
    [self.tabController viewWillAppear:YES];
    [self.launchView setAlpha:0];
  } completion:^(BOOL finished) {
    [self.tabController viewDidAppear:YES];
  }];
}

-(void)sessionStateDidChange:(NSNotification *)notification {
  if ([[UserDataStore sharedInstance] isAuthenticated]) {
    [[DibsClient client] getPath:@"validate" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      [self transitionToTabBarController];
      [[UserDataStore sharedInstance] setUserAttributes:responseObject];
    } failure:nil];
  }
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidAppear:(BOOL)animated {
  if ([[UserDataStore sharedInstance] isUnauthenticated]) {
    postNotification(SlideMenuShouldDisableSwipe);
  }
}

-(void)didTapConnect:(id)sender {
  [sender setEnabled:NO];
  AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  [delegate openSessionWithAllowLoginUI:YES];
}

@end