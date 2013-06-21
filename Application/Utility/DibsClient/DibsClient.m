#import "DibsClient.h"
#import "AFJSONRequestOperation.h"

static id sharedClient;

@interface DibsClient()

+(NSURL*)baseAPIURL;

@end

@implementation DibsClient

+(NSURL*)baseAPIURL {
  return [[Environment sharedInstance] baseAPIURL];
}

+(id)client {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedClient = [self clientWithBaseURL:self.baseAPIURL];
    [sharedClient setParameterEncoding:AFJSONParameterEncoding];
    [sharedClient setDefaultHeader:@"Accept" value:@"application/json"];
    [sharedClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [sharedClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
      if (status == AFNetworkReachabilityStatusNotReachable) {
        simpleAlert(@"Connection Failed", @"Please check your internet connection");
      }
    }];
  });
  
  [sharedClient setAuthorizationHeaderWithToken:[[UserDataStore sharedInstance] token]];
  return sharedClient;
}

@end
