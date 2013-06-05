#import <Foundation/Foundation.h>

@interface UserDataStore : NSObject

+(id)sharedInstance;

-(void)setToken:(NSString*)token withExpiry:(NSDate*)expiryDate;
-(void)invalidate;

-(NSString*)token;
-(NSDate*)tokenExpiry;

-(BOOL)tokenIsExpired;
-(BOOL)isAuthenticated;
-(BOOL)isUnauthenticated;

@end
