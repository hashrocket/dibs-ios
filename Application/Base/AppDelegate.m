#import "AppDelegate.h"
#import "LaunchController.h"
#import "MenuController.h"
#import "NVSlideMenuController.h"

@interface AppDelegate() {
  NVSlideMenuController *_slideController;
}

-(NVSlideMenuController*)slideController;
-(void)toggleSlideMenu:(NSNotification*)notification;

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleSlideMenu:)
                                               name:SlideMenuShouldToggleState object:nil];
  [self.window setRootViewController:self.slideController];
  [self.window makeKeyAndVisible];
  return YES;
}

-(NVSlideMenuController*)slideController {
  if (!_slideController) {
    _slideController = [[NVSlideMenuController alloc] initWithMenuViewController:[[MenuController alloc] init]
                                                        andContentViewController:[[LaunchController alloc] init]];
  }
  return _slideController;
}

-(void)toggleSlideMenu:(NSNotification *)notification {
  [self.slideController toggleMenuAnimated:nil];
}

#pragma mark - FB Session methods

-(void)sessionStateChanged:(FBSession*)session state:(FBSessionState)state error:(NSError*)error {
  switch (state) {
    case FBSessionStateOpen:
      if (!error) {
        [[UserDataStore sharedInstance] setToken:[session.accessTokenData accessToken]
                                      withExpiry:[session.accessTokenData expirationDate]];
      }
      break;
    case FBSessionStateClosed:
    case FBSessionStateClosedLoginFailed:
      [FBSession.activeSession closeAndClearTokenInformation];
      break;
    default:
      break;
  }

  postNotificationObject(FBSessionStateChangedNotification, session);

  if (error) {
    simpleAlert(@"Session Error", error.localizedDescription);
  }
}

-(BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
  return [FBSession openActiveSessionWithReadPermissions:@[@"email"] allowLoginUI:allowLoginUI completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
    [self sessionStateChanged:session state:status error:error];
  }];
}

#pragma mark - Application Lifecycle

-(void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

-(void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

-(void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

-(void)applicationDidBecomeActive:(UIApplication *)application {
  [FBSession.activeSession handleDidBecomeActive];
}

-(void)applicationWillTerminate:(UIApplication *)application {
  [FBSession.activeSession close];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  return [FBSession.activeSession handleOpenURL:url];
}

@end