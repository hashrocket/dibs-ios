#import "MyItemsController.h"
#import "Item.h"

@interface MyItemsController()
-(void)loadItems;
@end

@implementation MyItemsController

- (id)init {
  if (self = [super init]) {
    [self loadItems];
  }
  return self;
}

-(void)loadItems {
  [[DibsClient client] getPath:@"mine" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self setItemsAttributes:responseObject];
  } failure:nil];
}


@end
