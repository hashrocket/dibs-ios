static NSString * const NotificationDomain = @"com.dibs.notification";

#define ScopeNotification(notificationString) \
[NSString stringWithFormat:@"%@:%@",NotificationDomain,notificationString]

#define FBSessionStateChangedNotification ScopeNotification(@"fbSessionStateChangedNotification")
#define TabBarContentControllerWasInvalidated ScopeNotification(@"didInvalidateContentController")