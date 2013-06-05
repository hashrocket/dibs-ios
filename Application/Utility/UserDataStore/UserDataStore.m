#import "UserDataStore.h"

static NSString *kUserCredentialsKey = @"credentials_key";
static NSString *kUserAccessTokenKey = @"access_token";
static NSString *kUserAccessExpiryKey = @"access_token_expiry";

@interface UserDataStore()
-(NSUserDefaults*)sharedDefaults;
-(NSDictionary*)credentialsDictionary;
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
}

+(id)sharedInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

-(NSDictionary*)credentialsDictionary {
  return [self.sharedDefaults objectForKey:kUserCredentialsKey];
}

-(NSString*)token {
  return [self.credentialsDictionary valueForKey:kUserAccessTokenKey];
}

-(NSDate*)tokenExpiry {
  return [self.credentialsDictionary valueForKey:kUserAccessExpiryKey];
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
