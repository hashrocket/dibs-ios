#import <Foundation/Foundation.h>

@interface Environment : NSObject

+(id)sharedInstance;

-(NSURL*)baseAPIURL;
-(NSString*)pixateLicenseKey;
-(NSString*)pixateLicenseUser;
-(NSString*)facebookAppID;

@end