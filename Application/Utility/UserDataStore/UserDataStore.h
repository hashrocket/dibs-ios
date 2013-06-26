#import <Foundation/Foundation.h>

@class User;

@interface UserDataStore : NSObject

+(id)sharedInstance;

-(void)setToken:(NSString*)token withExpiry:(NSDate*)expiryDate;
-(void)invalidate;

-(User*)currentUser;
-(NSString*)token;
-(NSDate*)tokenExpiry;

-(void)setUserAttributes:(NSDictionary*)dict;

-(BOOL)tokenIsExpired;
-(BOOL)isAuthenticated;
-(BOOL)isUnauthenticated;

@end
