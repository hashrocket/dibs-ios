static NSString * const NotificationDomain = @"com.dibs.notification";

#define ScopeNotification(notificationString) \
[NSString stringWithFormat:@"%@:%@",NotificationDomain,notificationString]

#define FBSessionStateChangedNotification ScopeNotification(@"fbSessionStateChangedNotification")

#define SlideMenuShouldToggleState ScopeNotification(@"slideMenuShouldToggleState")
#define SlideMenuShouldDisableSwipe ScopeNotification(@"slideMenuShouldDisableSwipe")
#define SlideMenuShouldEnableSwipe ScopeNotification(@"slideMenuShouldEnableSwipe")

#define UserSessionShouldBeInvalidated ScopeNotification(@"userSessionShouldBeInvalidated")
#define UserDetailsWereAcquired ScopeNotification(@"userDetailsWereAcquired")
