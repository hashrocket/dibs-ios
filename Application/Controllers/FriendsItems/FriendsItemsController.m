#import "FriendsItemsController.h"

@interface FriendsItemsController ()
-(void)loadItems;
@end

@implementation FriendsItemsController

-(id)init {
  if (self = [super init]) {
    [self loadItems];
  }
  return self;
}

-(void)loadItems {
  if (self.isLoading) return;
  [self setIsLoading:YES];
  [[DibsClient client] getPath:@"theirs" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self setItemsAttributes:responseObject];
    [self setIsLoading:NO];
  } failure:nil];
}

-(void)didMoveToParentViewController:(UIViewController *)parent {
  [super didMoveToParentViewController:parent];
  if (!self.items) [self loadItems];
}

@end
