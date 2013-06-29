#import "LaunchController.h"
#import "LaunchView.h"
#import "AppDelegate.h"

@interface LaunchController () {
  LaunchView *_launchView;
}

@property(nonatomic,weak) AppDelegate *appDelegate;

-(LaunchView*)launchView;


@end

@implementation LaunchController

-(id)init {
  if (self = [super init]) {
    [self.view addSubview:self.launchView];
    [self.view setNeedsUpdateConstraints];
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

-(void)updateViewConstraints {
  [super updateViewConstraints];
  id views = @{ @"launch": self.launchView };
  [self.view addUniformConstraintsWithVisualFormat:@"|[launch]|" forSubviews:views];
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidAppear:(BOOL)animated {
  if ([[UserDataStore sharedInstance] isUnauthenticated]) {
    postNotification(SlideMenuShouldDisableSwipe);
    [self.launchView setEnabled:YES];
  }
}

-(void)didTapConnect:(id)sender {
  [self.launchView setEnabled:NO];
  postNotification(FBSessionDidRequestSessionNotification);
}

@end