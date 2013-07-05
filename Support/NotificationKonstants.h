static NSString * const NotificationDomain = @"com.dibs.notification";

#define ScopeNotification(notificationString) \
[NSString stringWithFormat:@"%@:%@",NotificationDomain,notificationString]

#define FBSessionDidRequestSessionNotification ScopeNotification(@"fbSessionDidRequestSessionNotification")
#define FBSessionStateChangedNotification ScopeNotification(@"fbSessionStateChangedNotification")

#define SlideMenuShouldToggleState ScopeNotification(@"slideMenuShouldToggleState")
#define SlideMenuShouldDisableSwipe ScopeNotification(@"slideMenuShouldDisableSwipe")
#define SlideMenuShouldEnableSwipe ScopeNotification(@"slideMenuShouldEnableSwipe")
#define SlideMenuWillSlideIn ScopeNotification(@"slideMenuWillSlideIn")
#define SlideMenuWillSlideOut ScopeNotification(@"slideMenuWillSlideOut")

#define UserSessionShouldBeInvalidated ScopeNotification(@"userSessionShouldBeInvalidated")
#define UserDetailsWereAcquired ScopeNotification(@"userDetailsWereAcquired")
