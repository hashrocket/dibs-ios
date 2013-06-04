#import "AppDelegate.h"
#import "LaunchController.h"

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  [self.window setBackgroundColor:[UIColor whiteColor]];
  [self.window setRootViewController:[[LaunchController alloc] init]];
  [self.window makeKeyAndVisible];
  return YES;
}

#pragma mark - FB Session methods

-(void)sessionStateChanged:(FBSession*)session state:(FBSessionState)state error:(NSError*)error {
  switch (state) {
    case FBSessionStateOpen:
      if (!error) {
        // We have a valid session
        // need to send this to the server and get back the oauthtoken that we store
        // to make requests on their behalf
        log_object([session.accessTokenData accessToken]);
        log_object([session.accessTokenData expirationDate]);
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