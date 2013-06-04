#import <Foundation/Foundation.h>

@interface Environment : NSObject

+(id)sharedInstance;

-(NSString*)pixateLicenseKey;
-(NSString*)pixateLicenseUser;
-(NSString*)facebookAppID;

@end