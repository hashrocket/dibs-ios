#import <Foundation/Foundation.h>

@class User;

@interface Item : NSObject

@property(nonatomic,strong) NSDictionary *attributes;

+(NSArray*)parse:(NSArray*)itemAttributes;

-(id)initWithDictionary:(NSDictionary*)attrs;

-(NSURL*)primaryImageURL;
-(NSArray*)imageURLs;
-(NSString*)name;
-(NSString*)price;
-(User*)owner;

-(BOOL)dibbedByLoggedInUser;

@end
