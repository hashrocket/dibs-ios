#import <UIKit/UIKit.h>
#import "Environment.h"
#import "AppDelegate.h"

int main(int argc, char *argv[]) {
  @autoreleasepool {
    [PXEngine licenseKey:[[Environment sharedInstance] pixateLicenseKey]
                 forUser:[[Environment sharedInstance] pixateLicenseUser]];
    [FBSettings setDefaultAppID:[[Environment sharedInstance] facebookAppID]];
    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
  }
}
