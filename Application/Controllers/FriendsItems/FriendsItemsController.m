#import "FriendsItemsController.h"

@interface FriendsItemsController ()
-(void)loadItems;
@end

@implementation FriendsItemsController

-(void)loadItems {
  if (self.isLoading) return;
  [self setIsLoading:YES];
  [[DibsClient client] getPath:@"theirs" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self setItemsAttributes:responseObject];
    [self setIsLoading:NO];
    [self.refreshControl endRefreshing];
  } failure:nil];
}

-(void)didMoveToParentViewController:(UIViewController *)parent {
  [super didMoveToParentViewController:parent];
  if (!self.items || [self.items count] == 0) [self loadItems];
}

@end
