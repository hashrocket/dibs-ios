#import "MyItemsController.h"

@interface MyItemsController()
-(void)loadItems;
@end

@implementation MyItemsController

-(void)loadItems {
  if (self.isLoading) return;
  [self setIsLoading:YES];
  [self.collectionView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height) animated:YES];
  [self.refreshControl beginRefreshing];
  [[DibsClient client] getPath:@"mine" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
