#import "FriendsItemsController.h"
#import "ItemCell.h"

@interface FriendsItemsController ()
-(void)loadItems;
@end

@implementation FriendsItemsController

- (id)init {
  if (self = [super init]) {
    [self loadItems];
  }
  return self;
}

-(void)loadItems {
  [[DibsClient client] getPath:@"theirs" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self setItemsAttributes:responseObject];
    postNotification(TabBarContentControllerWasInvalidated);
  } failure:nil];
}

@end
