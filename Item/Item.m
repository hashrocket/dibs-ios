#import "Item.h"
#import "User.h"
#import <ISO8601DateFormatter/ISO8601DateFormatter.h>

@interface Item() {
  NSArray *_imageURLs;
  User *_owner;
  ISO8601DateFormatter *_dateFormatter;
}

-(ISO8601DateFormatter*)dateFormatter;

@end

@implementation Item

+(NSArray*)parse:(NSArray *)itemAttributes {
  return [itemAttributes map:^id(NSDictionary *attrs) {
    return [[Item alloc] initWithDictionary:attrs];
  }];
}

-(id)initWithDictionary:(NSDictionary *)attrs {
  if (self = [super init]) {
    [self setAttributes:attrs];
  }
  return self;
}

-(NSURL*)primaryImageURL {
  return [self.imageURLs firstObject];
}

-(NSArray*)imageURLs {
  if (!_imageURLs) {
    _imageURLs = [self.attributes[@"image_urls"] map:^id(NSString *imageURLString) {
      return [NSURL URLWithString:imageURLString];
    }];
  }
  return _imageURLs;
}

-(NSString*)name {
  return self.attributes[@"name"];
}

-(NSString*)price {
  return self.attributes[@"price"];
}

-(User*)owner {
  if (!_owner) {
    _owner = [[User alloc] initWithDictionary:self.attributes[@"user"]];
  }
  return _owner;
}

-(ISO8601DateFormatter*)dateFormatter {
  if (!_dateFormatter) {
    _dateFormatter = [ISO8601DateFormatter new];
  }
  return _dateFormatter;
}

-(NSDate*)dateListed {
  return [self.dateFormatter dateFromString:self.attributes[@"listed_at"]];
}

-(BOOL)dibbedByLoggedInUser {
  return [self.attributes[@"dibbed"] boolValue];
}

@end
