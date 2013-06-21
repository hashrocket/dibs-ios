#import "Environment.h"

@interface Environment(Private)
-(id)init;
-(NSDictionary*)config;
@end

@implementation Environment

static Environment *sharedInstance = nil;

+(id)sharedInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

-(id)init {
  return [super init];
}

-(NSDictionary*)config {
  NSBundle* bundle = [NSBundle mainBundle];
  NSString* configuration = [[bundle infoDictionary] objectForKey:@"Configuration"];
  NSString* envsPlistPath = [bundle pathForResource:@"Environments" ofType:@"plist"];
  NSDictionary* environments = [NSDictionary dictionaryWithContentsOfFile:envsPlistPath];
  return environments[configuration];
}

-(NSURL*)baseAPIURL {
  return [NSURL URLWithString:[self.config valueForKey:@"APIBaseURL"]];
}

-(NSString*)pixateLicenseKey {
  return self.config[@"pixateLicenseKey"];
}

-(NSString*)pixateLicenseUser {
  return self.config[@"pixateLicenseUser"];
}

-(NSString*)facebookAppID {
  return self.config[@"facebookAppID"];
}

@end