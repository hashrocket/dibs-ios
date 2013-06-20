#import <Foundation/Foundation.h>

@class User;

@interface Item : NSObject

@property(nonatomic,strong) NSDictionary *attributes;

-(id)initWithDictionary:(NSDictionary*)attrs;

-(NSURL*)primaryImageURL;
-(NSArray*)imageURLs;
-(NSString*)name;
-(NSString*)price;
-(User*)owner;

@end
