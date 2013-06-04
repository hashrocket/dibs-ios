static NSString * const NotificationDomain = @"com.passionTag.notification";

#define ScopeNotification(notificationString) \
[NSString stringWithFormat:@"%@:%@",NotificationDomain,notificationString]

#define FBSessionStateChangedNotification ScopeNotification(@"fbSessionStateChangedNotification")