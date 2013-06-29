#import "ContentController.h"
#import "LaunchController.h"
#import "TabBarController.h"

@interface ContentController () {
  LaunchController *_launchController;
  TabBarController *_tabController;
}

-(LaunchController*)launchController;
-(TabBarController*)tabController;
-(UIViewController*)currentViewController;

-(void)sessionStateChanged;
-(void)pushController:(UIViewController*)controller animated:(BOOL)animated;
-(void)popController:(UIViewController*)controller;

@end

@implementation ContentController

-(id)init {
  if (self = [super init]) {
    [self pushController:self.launchController animated:NO];
    if ([[UserDataStore sharedInstance] isAuthenticated]) {
      [self pushController:self.tabController animated:YES];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionStateChanged)
                                                 name:FBSessionStateChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionStateChanged)
                                                 name:UserSessionShouldBeInvalidated
                                               object:nil];
  }
  return self;
}

-(LaunchController*)launchController {
  if (!_launchController) {
    _launchController = [[LaunchController alloc] init];
  }
  return _launchController;
}

-(TabBarController*)tabController {
  if (!_tabController) {
    _tabController = [[TabBarController alloc] init];
  }
  return _tabController;
}

-(UIViewController*)currentViewController {
  return [self.childViewControllers lastObject];
}

-(CGFloat)durationWithAnimated:(BOOL)animated {
  return animated ? 0.25 : 0;
}

-(void)pushController:(UIViewController *)controller animated:(BOOL)animated {
  [controller willMoveToParentViewController:self];
  [self addChildViewController:controller];
  [controller.view setFrame:self.view.bounds];
  [controller.view setAlpha:0];
  [self.view addSubview:controller.view];
  [UIView animateWithDuration:[self durationWithAnimated:animated] animations:^{
    [controller.view setAlpha:1.0];
  } completion:^(BOOL finished) {
    [controller didMoveToParentViewController:self];
  }];
}

-(void)popController:(UIViewController *)controller {
  [UIView animateWithDuration:0.25 animations:^{
    [controller.view setAlpha:0.0];
  } completion:^(BOOL finished) {
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
    [self.currentViewController viewDidAppear:YES];
  }];
}

-(void)sessionStateChanged {
  if ([[UserDataStore sharedInstance] isAuthenticated]) {
    [[DibsClient client] getPath:@"validate" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      [[UserDataStore sharedInstance] setUserAttributes:responseObject];
      [self pushController:self.tabController animated:YES];
    } failure:nil];
  } else {
    [self popController:self.tabController];
  }
}

@end
