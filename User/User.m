#import "User.h"

@implementation User

-(id)initWithDictionary:(NSDictionary *)attrs {
  if (self = [super init]) {
    [self setAttributes:attrs];
  }
  return self;
}

-(NSString*)name {
  return self.attributes[@"name"];
}

-(NSURL*)profileImageURL {
  return [NSURL URLWithString:self.attributes[@"profile_image_url"]];
}

@end
