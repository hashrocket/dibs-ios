#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,strong) NSDictionary *attributes;

-(id)initWithDictionary:(NSDictionary*)attrs;
-(NSString*)name;
-(NSURL*)profileImageURL;

@end
