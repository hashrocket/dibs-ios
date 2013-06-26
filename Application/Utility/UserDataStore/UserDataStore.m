#import "UserDataStore.h"
#import "User.h"

static NSString *kUserCredentialsKey = @"credentials_key";
static NSString *kUserAccessTokenKey = @"access_token";
static NSString *kUserAccessExpiryKey = @"access_token_expiry";
static NSString *kUserAttributesKey = @"attributes_key";

@interface UserDataStore() {
  User *_currentUser;
}
-(NSUserDefaults*)sharedDefaults;
-(NSDictionary*)credentialsDictionary;
-(NSDictionary*)userAttributesDictionary;
@end

static UserDataStore *sharedInstance = nil;

@implementation UserDataStore

-(NSUserDefaults*)sharedDefaults {
  return [NSUserDefaults standardUserDefaults];
}

-(void)setToken:(NSString *)token withExpiry:(NSDate *)expiry {
  id credentials = @{kUserAccessTokenKey: token, kUserAccessExpiryKey: expiry};
  [self.sharedDefaults setObject:credentials forKey:kUserCredentialsKey];
  [self.sharedDefaults synchronize];
}

-(void)invalidate {
  [self.sharedDefaults setObject:nil forKey:kUserCredentialsKey];
  [self.sharedDefaults setObject:nil forKey:kUserAttributesKey];
}

+(id)sharedInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

-(void)setUserAttributes:(NSDictionary *)dict {
  [self.sharedDefaults setObject:dict forKey:kUserAttributesKey];
  postNotificationObject(UserDetailsWereAcquired, self.currentUser);
}

-(NSDictionary*)credentialsDictionary {
  return [self.sharedDefaults objectForKey:kUserCredentialsKey];
}

-(NSDictionary*)userAttributesDictionary {
  return [self.sharedDefaults objectForKey:kUserAttributesKey];
}

-(NSString*)token {
  return [self.credentialsDictionary valueForKey:kUserAccessTokenKey];
}

-(NSDate*)tokenExpiry {
  return [self.credentialsDictionary valueForKey:kUserAccessExpiryKey];
}

-(User*)currentUser {
  return [[User alloc] initWithDictionary:self.userAttributesDictionary];
}

-(BOOL)tokenIsExpired {
  return [self.tokenExpiry compare:[NSDate date]] != NSOrderedDescending;
}

-(BOOL)isAuthenticated {
  return self.token && !self.tokenIsExpired;
}

-(BOOL)isUnauthenticated {
  return !self.isAuthenticated;
}

@end
